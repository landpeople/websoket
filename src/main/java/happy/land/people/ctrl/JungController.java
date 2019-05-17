package happy.land.people.ctrl;

import java.util.HashMap;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.dto.LPCollectDto;
import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.model.ISketchBookService;

@Controller
public class JungController {

	private Logger logger = LoggerFactory.getLogger(JungController.class);
	
	@Autowired
	private ISketchBookService iSketchBookService;
	
	@ResponseBody
	@RequestMapping(value="/sketchMakeForm.do", method=RequestMethod.GET)
	public Map<String, String> sketchIsWrite(String user_email) {
		
		Map<String, String> map = new HashMap<String, String>();
		// 스케치북 작성권한 확인
		String user_iswrite = iSketchBookService.sketchSelectWrite(user_email);
		map.put("user_email", user_email);
		map.put("user_iswrite", user_iswrite);
		System.out.println(map);
		
		
		return map;
	}
	
	@RequestMapping(value="/writeSketch.do",method=RequestMethod.POST)
	public  String sketchMake(LPSketchbookDto dto) {
		logger.info("sketchBook 생성 {}", dto);
		// 스케치북 생성 (제목, 여행테마, 공유 여부)
		boolean isc = iSketchBookService.sketchInsert(dto);
		System.out.println(isc);		
		return "kim";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/CancelLike.do",method=RequestMethod.GET)
	public Map<String, String> cancelLike(String user_email, String sketch_id){
		logger.info("JungController 실행");

		// 스케치북 좋아요 상태 가져오기
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", "128@happy.com");
		map.put("sketch_id", "0004");
		String like = iSketchBookService.scrapeSelect(map);		
		
		// 스케치북 좋아요 상태 변경(등록, 취소)
		Map<String,String> result = new HashMap<String,String>();
	
		boolean isc = false;
		if(like.equalsIgnoreCase("F")) {
			map.put("like", "T");
			isc = iSketchBookService.likeUpdate(map);
			result.put("result", "T");
		}else {
			map.put("like", "F");
			isc = iSketchBookService.likeUpdate(map);
			result.put("result", "F");
		}		
				
		System.out.println(isc+"!!!!!!!!!!!~~!@!@!@!@!@");
		//logger.info("Controller CancelLike {}", isc);	
				
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="Scrape.do", method=RequestMethod.GET)
	public Map<String, String> scrapeState(String user_email, String sketch_id, LPCollectDto dto ) {
		// 스케치북 스크랩 최초 등록
		boolean isc = iSketchBookService.collectInsert(dto);
		System.out.println(isc+"스크랩 최초 등록~~~~~ 성공");
		logger.info("scrapeState 실행 {}", isc);
		
		// 스케치북 스크랩 상태 확인
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", "130@happy.com");
		map.put("sketch_id", "0007");
		String scrape = iSketchBookService.scrapeSelect(map);
	
		// 스케치북 스크랩 상태 변경(등록, 취소)
		Map<String, String> sresult =new HashMap<String, String>();
	 	
		
		boolean sisc = false;
		if(scrape.equalsIgnoreCase("F")) {
			map.put("scrape", "T");
			sisc = iSketchBookService.scrapeUpdate(map);
			sresult.put("sresult", "T");
		}else {
			map.put("scrape", "F");
			sisc = iSketchBookService.scrapeUpdate(map);
			sresult.put("sresult", "F");
		}
		
		
		return sresult;
	}

}
	

