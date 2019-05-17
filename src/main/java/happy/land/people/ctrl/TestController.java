package happy.land.people.ctrl;

import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import happy.land.people.dto.TestDto;
import happy.land.people.model.ITestService;

// 4*번
@Controller
public class TestController {

	private Logger logger = LoggerFactory.getLogger(TestController.class);

	@Autowired
	private JavaMailSender jms;

	@Autowired
	ITestService service;
	
	// 5*번
	@RequestMapping(value = "/test.do", method = RequestMethod.GET)
	public String Test() {
		return "test";
	}
	
	// 개인별 테스트 페이지 -> 각자 기능 테스트 후 통합 예정
	@RequestMapping(value = "/kim.do", method = RequestMethod.GET)
	public String Kim() {
		System.out.println("태우 태우");
		return "kim";
	}
	
	@RequestMapping(value = "/na.do", method = RequestMethod.GET)
	public String Na() {
		return "na";
	}
	
	@RequestMapping(value = "/lee.do", method = RequestMethod.GET)
	public String Lee() {
		
		return "lee";
	}
	
	@RequestMapping(value = "/jang.do", method = RequestMethod.GET)
	public String Jang() {
		return "jang";
	}
	
	@RequestMapping(value = "/jung.do", method = RequestMethod.GET)
	public String Jung() {
		return "jung";
	}
	
	@RequestMapping(value = "/cho.do", method = RequestMethod.GET)
	public String Cho() {
		return "cho";
	}
	// ============================================================================
	
	@RequestMapping(value = "/init.do", method = RequestMethod.GET)
	public String init(Model model) {
		logger.debug("● TestController init 실행 + {}", new Date());
		model.addAttribute("now", new Date());
		return "start";
	}

	@RequestMapping(value = "/interceptor.do", method = RequestMethod.GET)
	public String interceptorTest() {
		logger.debug("● TestController interceptorTest 실행 {}", new Date());
		return "interceptorTest";
	}

	@RequestMapping(value = "/mail.do", method = RequestMethod.POST)
	public String mailSender(String toEmail, String title, String content) { // DTO없어서 그냥 값 몽창 받을거에여
		logger.debug("● TestController mailSender {}&{}", toEmail, title + ":" + content);
		// 꼭 보내는 메일을 적어줘야 에러가 안 나더라
		String setFrom = "happylandpeople@gmail.com";
//		String toEmail = toEmail; // 받는 사람 메일
//		String title = title; // 받는 메일 제목, 받는 메일 제목 MMS인 경우에는 반드시 제목을 적어야함 (안적으면 철컹철컹)
//		String content = content; // 받는 메일 내용
		try {
			MimeMessage message = jms.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setFrom);
			messageHelper.setTo(toEmail); // 중요 메일 보내는것 나중에 해보기!
			messageHelper.setSubject(title);
			messageHelper.setText(content); // true 설정이면 HTML 전송가능

			jms.send(message);
		} catch (MessagingException e) {
			logger.warn("● 메일이 전송되지 않았습니다.");
			e.printStackTrace();
		}

		// IoC에 내부에 있는 Spring의 RequestMapping 값을 호출한다.
		// Controller를 다시 호출한다. 이것이 바로~! "redirect:"
		return "redirect:/init.do";
	}

	@RequestMapping(value = "/jobAll.do", method = RequestMethod.GET)
	public String jobAll(Model model) {
		logger.info("● TestController jobAll 실행");
		List<TestDto> lists = service.jobAll();
		model.addAttribute("lists", lists);
		return "start";
	}
	
	@RequestMapping(value = "/transaction.do", method = RequestMethod.GET)
	public String transactionUpdate(Model model) {
		logger.info("● TestController transactionUpdate 실행");
		int n = service.transactionUpdateTest();
		logger.info("● TestController transactionUpdate 실행 {}", n);
		model.addAttribute("n", n);
		return "start";
	}
	
	@RequestMapping(value = "/cryptographic.do", method = RequestMethod.POST)
	public String cryptographic(TestDto dto) {
		logger.info("● TestController cryptographic 실행");
		int n = service.cryptographicInsert(dto);
		logger.info("● TestController cryptographic 실행 {}", n);
		return "start";
	}
	
	@RequestMapping(value = "/crytographicCompare.do", method = RequestMethod.POST)
	public String crytographicCompare(TestDto dto, HttpSession session) {
		logger.info("● TestController crytographicCompare 실행");
		TestDto lDto = service.crytographicCompare(dto);
		logger.info("● TestController crytographicCompare실행 {}", lDto);
		session.setAttribute("login", lDto);
		return "start";
	}
}
