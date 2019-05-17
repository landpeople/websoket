package happy.land.people.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import happy.land.people.dto.JsonUtil;
import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPUserDto;
import happy.land.people.model.jang.IManagerService;
import happy.land.people.ctrl.JangController;

@Controller
public class JangController {
	
	private Logger logger = LoggerFactory.getLogger(JangController.class);
	
	@Autowired
	private IManagerService iManagerService; 
	
	// 회원 조회 페이지로 이동
	@RequestMapping(value="/jqgrid.do", method=RequestMethod.GET)
	public String jqgrid() {
		logger.info("Controller jqgrid");
		return "manager/managerMemberList";
	}
	
	// 스케치북 조회 페이지로 이동
	@RequestMapping(value="/jqgrid2.do", method=RequestMethod.GET)
	public String jqgrid2() {
		logger.info("Controller jqgrid2");
		return "manager/managerSketchList";
	}
	
	// 회원 목록 조회
	@RequestMapping(value="/searchMemberList.do")
	public void searchMemberList(HttpServletRequest request, HttpServletResponse response, String title,
			@ModelAttribute LPUserDto lDto, ModelMap model) {
		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");
		System.out.println(title);
		
		String serviceImplYn = request.getParameter("param");
        System.out.println(serviceImplYn);
        String input = request.getParameter("param2");
        System.out.println(input);
		
        Map<String, Object> castMap = new HashMap<String, Object>();
        Map<String, Object> castMap2 = new HashMap<String, Object>();
        
        castMap = JsonUtil.JsonToMap(serviceImplYn); // quotZero json을 맵으로 변환시킨다.
        castMap2 = JsonUtil.JsonToMap(input); // quotZero json을 맵으로 변환시킨다.

        lDto.setServiceImplYn((String) castMap.get("serviceImplYn"));
        lDto.setInput((String) castMap2.get("input"));
                
        List<Map<String, String>> jqGridList = iManagerService.selectMemberList(lDto);
        Map<String, Integer> jqGridListCnt = iManagerService.selectMemberListCnt(lDto);
	        HashMap<String, Object> resMap = new HashMap<String, Object>();
	        
	        // 페이징
	        resMap.put("records", jqGridListCnt.get("TOTALTOTCNT"));
	        resMap.put("rows", jqGridList);
	        resMap.put("page", request.getParameter("page"));
	        System.out.println("page from request "+request.getParameter("page"));
	        resMap.put("total", jqGridListCnt.get("TOTALPAGE"));
	        
	        System.out.println("resMap 입니다! : "+resMap);
	                
	        try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
	                
	        out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	// 회원 작성권한 수정
	@RequestMapping(value="/modifyIswrite.do")
	public void modifyIswrite(HttpServletRequest request, HttpServletResponse response, String email) {
		logger.info("Controller modifyIswrite {}", email);
		
		boolean isc = iManagerService.modifyIswrite(email);
	}
	
	// 스케치북 조회
	@RequestMapping(value="/searchSketchList.do")
	public void searchSketchList(HttpServletRequest request, HttpServletResponse response, String title,
			@ModelAttribute LPSketchbookDto lsDto, ModelMap model) {
		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");
		System.out.println(title);
		
		String serviceImplYn = request.getParameter("param");
        System.out.println(serviceImplYn);
        String input = request.getParameter("param2");
        System.out.println(input);
		
        Map<String, Object> castMap = new HashMap<String, Object>();
        Map<String, Object> castMap2 = new HashMap<String, Object>();
        
        castMap = JsonUtil.JsonToMap(serviceImplYn); // quotZero json을 맵으로 변환시킨다.
        castMap2 = JsonUtil.JsonToMap(input); // quotZero json을 맵으로 변환시킨다.

        lsDto.setServiceImplYn((String) castMap.get("serviceImplYn"));
        lsDto.setInput((String) castMap2.get("input"));
                
        List<Map<String, String>> jqGridList = iManagerService.selectSketchList(lsDto);
        Map<String, Integer> jqGridListCnt = iManagerService.selectSketchListCnt(lsDto);
	        HashMap<String, Object> resMap = new HashMap<String, Object>();
	        
	        // 페이징
	        resMap.put("records", jqGridListCnt.get("TOTALTOTCNT"));
	        resMap.put("rows", jqGridList);
	        resMap.put("page", request.getParameter("page"));
	        System.out.println("page from request "+request.getParameter("page"));
	        resMap.put("total", jqGridListCnt.get("TOTALPAGE"));
	        
	        System.out.println("resMap 입니다! : "+resMap);
	                
	        try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
	                
	        out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	// 스케치북 공개/비공개 여부 수정
	@RequestMapping(value="/modifyBlock.do")
	public void saveDataSk2(HttpServletRequest request, HttpServletResponse response, String id) {
		logger.info("Controller modifyBlock {}", id);
		boolean isc = iManagerService.modifyBlock(id);
	}
}
