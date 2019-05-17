package happy.land.people.ctrl;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MidiDevice.Info;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.github.scribejava.core.model.OAuth2AccessToken;

import happy.land.people.dto.cho.ChoDto;
import happy.land.people.model.cho.IChoService;

import happy.land.people.naver.NaverLoginBO;
import happy.land.people.model.lee.ILeeService;


@Controller
public class ChoController {

	private Logger logger = LoggerFactory.getLogger(ChoController.class);

	@Autowired
	private IChoService iChoService;
  
	/* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;
    
    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }
	
  /* GoogleLogin */
 @Autowired
  private GoogleConnectionFactory googleConnectionFactory;
  @Autowired
  private OAuth2Parameters googleOAuth2Parameters;

	@Autowired
	ILeeService iLeeService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// 메인페이지로가는 컨트롤러
	@RequestMapping(value = "/mainPage.do", method = RequestMethod.GET)
	public String mainPage() {
		return "foward:./index.jsp";
	}
	// 로그인 페이지로 가는 컨트롤러 + 네이버 값받아오는거 추가함
	@RequestMapping(value="/loginPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String loginPage(Model model, HttpSession session) {
		logger.info("loginPage 컨트롤러");
		
	      
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
        System.out.println("네이버:" + naverAuthUrl);
        
        //네이버 
        model.addAttribute("url", naverAuthUrl);


		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		System.out.println("구글:" + url);

		model.addAttribute("google_url", url);

		return "users/loginPage";
	}
	
	
	 //네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, ChoDto dto) throws Exception {
        System.out.println("여기는 callback");
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
        System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
        model.addAttribute("result", apiResult);
        
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonArray = (JSONObject) jsonParser.parse(apiResult);
        JSONObject resultObject = (JSONObject)jsonArray.get("response");
        System.out.println(resultObject.get("email"));
        //dto.setUser_email(jsonArray.get("email").);
        
        String user_email =(String)resultObject.get("email");
       
        
        dto.setUser_email(user_email);
        String[] user_name = user_email.split("@");
        dto.setUser_nickname(user_name[0]);
    	dto.setUser_auth("N");
		boolean isc = iChoService.signUp(dto);
		
        return isc?"redirect:./index.jsp":"404";
    }
 
    //구글 로그인 성공시 콜백
    @RequestMapping(value="/callbackgoogle.do" , method= {RequestMethod.POST,RequestMethod.GET})
    public String callbackGoogle(Model model, @RequestParam String code, HttpSession session , ChoDto dto) {
    	System.out.println("여기는 googleCallback");

    	
		return "redirect:./index.jsp";
    }
	
	
	// 여기는 나중에 한다 ^^ 로그인기능 => 다 됐다 로그인 기능
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(ChoDto dto, HttpSession session) {

		ChoDto ldto = iChoService.login(dto);

		System.out.println(ldto);
		iLeeService.chatList_Insert(ldto.getUser_nickname());
		session.setAttribute("ldto", ldto);

		return "forward:./index.jsp";
	}
  
	// 로그아웃
	@RequestMapping(value="/logout.do",method=RequestMethod.GET)
	public String logout(HttpSession session ,ChoDto dto) {
		logger.info("logout");
		
		System.out.println("로그아웃.do 현재 세션 : " + session);

		session.invalidate();
		return "forward:./index.jsp";
	}

	//회원가입 페이지로가기 ^^
	@RequestMapping(value="/regiForm.do" , method=RequestMethod.GET)
	public String regiForm() {
		logger.info("regiForm 컨트롤러");

		return "users/sign/regiForm";
	}
	
	//회원가입(db에저장하기 헤헤) 일반유저
	@RequestMapping(value="/signUp.do" , method=RequestMethod.POST)
	public String signUp(HttpServletRequest req, ChoDto dto) {
		
		dto.setUser_auth("U");
		boolean isc = iChoService.signUp(dto);

		return isc ? "users/sign/auth" : "404";
	}

	// 이메일 링크 클릭으로 들어옴
	@RequestMapping(value = "/mailConfirm.do", method = RequestMethod.GET)
	public String mailConfirm(ChoDto dto) {
//		System.out.println(dto); //==	logger.info(dto.toString());
		boolean isc = iChoService.authStatusUpdate(dto.getUser_email());
		return isc ? "users/sign/auth" : "error";
	}
}
