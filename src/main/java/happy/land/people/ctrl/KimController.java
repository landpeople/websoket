package happy.land.people.ctrl;

import java.io.FileInputStream;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPDaysDto;
import happy.land.people.dto.kim.LPMapdataDto;
import happy.land.people.model.kim.ILPCanvasService;
import happy.land.people.model.kim.ILPDaysService;
import happy.land.people.model.kim.ILPMapdataService;

@Controller
public class KimController {
	
	@Autowired
	private ILPMapdataService mapService;
	
	@Autowired
	private ILPDaysService daysService;
	
	@Autowired
	private ILPCanvasService canvasService;
	
    @RequestMapping(value="loadMap.do",method=RequestMethod.GET )
    public String loadMap() throws IOException {
    	FileInputStream inputStream = new FileInputStream("D:\\LandPeople_20190507.xlsx");
    	@SuppressWarnings("resource")
		XSSFWorkbook workbook = new XSSFWorkbook(inputStream);//엑셀읽기
        XSSFSheet sheet = workbook.getSheetAt(0);//시트가져오기 0은 첫번째 시트
        
        int rows = sheet.getPhysicalNumberOfRows();// 총 행 개수
        int cols = 7;// 총 열개수
        XSSFCell cell;        
        String[] result = new String[rows];
        for(int i = 0 ; i < rows ; i++) {
        	String value = "";
        	for(int j = 0; j < cols ; j++) {
        		cell = sheet.getRow(i).getCell(j);   
        		if(cell != null) {
		        	if(cell.getCellTypeEnum() == CellType.BLANK){
		                value +=" ";
		            }
		        	else if(cell.getCellTypeEnum() == CellType.FORMULA){
		        		value+=cell.getCellFormula()+"/";
		        	}
		        	else if(cell.getCellTypeEnum() == CellType.NUMERIC) {
		        		 value+=cell.getNumericCellValue()+"/";
		        	}
		        	else if(cell.getCellTypeEnum() == CellType.STRING) {
		        		value+=cell.getStringCellValue()+"/";
		        	}
		        	else if(cell.getCellTypeEnum() == CellType.ERROR) {
		        		 value+=cell.getErrorCellValue()+"/";
		        	}
        		}	        	            
        	}
        	System.out.println(value);
        	result[i] = new String(value);
        }       
               
        for(int i = 1; i < result.length; i++) {
        	String[] value = result[i].split("/");
        	
        	LPMapdataDto mapDto = new LPMapdataDto(value[0], value[1], value[2], value[3], value[4]," ");        
            mapService.mapInsert(mapDto);
        }
        
        return "1";
    }
    
    @ResponseBody
    @RequestMapping(value="showFood.do",method=RequestMethod.POST)
    public Map<String,List<LPMapdataDto>> showFood(String type){    	
    	List<LPMapdataDto> mapList = mapService.mapSelectType(type);    
    	System.out.println(mapList.get(0));
    	Map<String,List<LPMapdataDto>> result = new HashMap<String,List<LPMapdataDto>>();
    	result.put("result", mapList);    	
    	return result;
    }
    
    @ResponseBody
    @RequestMapping(value="showTrip.do",method=RequestMethod.POST)
    public Map<String,List<LPMapdataDto>> showTrip(String type){    	
    	List<LPMapdataDto> mapList = mapService.mapSelectType(type);    
    	System.out.println(mapList.get(0));
    	Map<String,List<LPMapdataDto>> result = new HashMap<String,List<LPMapdataDto>>();
    	result.put("result", mapList);    	
    	return result;
    }
    
    @ResponseBody
    @RequestMapping(value="showRest.do",method=RequestMethod.POST)
    public Map<String,List<LPMapdataDto>> showRest(String type){    	
    	List<LPMapdataDto> mapList = mapService.mapSelectType(type);    
    	System.out.println(mapList.get(0));
    	Map<String,List<LPMapdataDto>> result = new HashMap<String,List<LPMapdataDto>>();
    	result.put("result", mapList);    	
    	return result;
    }
    
    @ResponseBody
    @RequestMapping(value="insertDaysCanvas.do",method=RequestMethod.POST)
    public Map<String, String> insertDaysCanvas(HttpSession session,@RequestBody Map<String, Object> val) throws ParseException{
    	// 캔버스 생성 부분 
    	LPCanvasDto canvasDto =  (LPCanvasDto)session.getAttribute("canvas");
    	int chk = canvasService.canvasInsert(canvasDto);
    	String canvasID = canvasService.canvasSelectID(canvasDto);
    	canvasDto.setCan_id(canvasID);
    	// 캔버스 생성 완료
    	if(canvasDto!= null) {    		
    	}
    	
    	for(int i = 0; i < val.size() ; i++) {
    	Map<String,String> map = (Map<String,String>)val.get("days"+i);
    	//System.out.println(map);   
    	SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    		LPDaysDto dto = new LPDaysDto(canvasDto.getCan_id(), map.get("title"), map.get("content"), formatDate.parse(map.get("startDate")), formatDate.parse(map.get("endDate")), map.get("x") , map.get("y"), map.get("address"));
    		daysService.daysInsert(dto);
    	}        		 	
    	Map<String,String> result = new HashMap<String,String>();
    	result.put("result", "성공");
    	return result;
    }
    
    @RequestMapping(value="detailCanvas.do",method=RequestMethod.GET)
    public String detailDaysCanvas(HttpServletRequest request){
    	// 스케치북 id에 따른 캔버스의 개수
    	int canvasCnt = canvasService.canvasCnt("1");
    	System.out.println("해당 스케치북의 캔버스 개수:"+canvasCnt);
    	
    	List<LPCanvasDto> canvasList = canvasService.canvasSelectType("1");
    	Map<Integer,List<LPDaysDto>> map = new HashMap<Integer,List<LPDaysDto>>();
    	System.out.println(canvasList);
    	// 캔버스 개수에 맞게 map에 canvas를 입력
    	for(int i=0; i < canvasCnt ; i++) {    		
    		if(canvasList.get(i).getCan_type().equalsIgnoreCase("1")) {    		
    			List<LPDaysDto> daysList =  daysService.daysSelectAll(canvasList.get(i).getCan_id());
    			map.put(i, daysList);
    		}
    		else {
    			// 자유 캔버스는 여기에 
    		}    		
    	}
    	System.out.println(map);
    	// 캔버스들 화면으로 보내기
    	request.setAttribute("daysList", map);
    	// 캔버스들 타입을 화면으로 보내기
    	request.setAttribute("daysType", canvasList);
    	
    	//List<LPDaysDto> daysList1 =  daysService.daysSelectAll("0002");
    	//request.setAttribute("daysList1", daysList1);
    	//System.out.println(daysList1.get(0));
    	//model.addAttribute(attributeValue);
    	return "kim_detailCanvas";
    }
    
    @RequestMapping(value="insertDaysForm.do",method=RequestMethod.POST)
    public String insertDaysFrom(HttpSession session,String nowPageNo){
     // 페이지 번호 , 캔버스 id     	
    	LPCanvasDto dto = new LPCanvasDto("0001", "1", "제목은 대충", "내용도 아무거나", "1", nowPageNo);
    	session.setAttribute("canvas", dto);
    	return "kim_insertDaysCanvas";
    }
    // 수정폼으로 이동
    @RequestMapping(value="updateDaysForm.do",method=RequestMethod.POST)
    public String updateDaysFrom(HttpSession session,String nowPageNo){
        //캔버스 세팅	
    	LPCanvasDto canvasDto = new LPCanvasDto();
    	canvasDto.setCan_pageno(nowPageNo);
    	// 스케치북 세팅
    	canvasDto.setSketch_id("1");
    	// 보고 있는 페이지의 캔버스 id값을 가져옴
    	String id = canvasService.canvasSelectID(canvasDto);
    	// 캔버스 dto 세팅
    	canvasDto = canvasService.canvasSelectOne(id);
    	session.setAttribute("canvas", canvasDto);
    	// 일정 캔버스 세팅
    	List<LPDaysDto> daysDto = daysService.daysSelectAll(id);
    	session.setAttribute("days", daysDto);
    	return "kim_updateDaysCanvas";
    }
    
    @RequestMapping(value="deleteDaysForm.do",method=RequestMethod.POST)
    public String deleteDaysFrom(HttpSession session,String nowPageNo){
     // 페이지 번호 , 캔버스 id     	
    	System.out.println("페이지번호:"+nowPageNo);
    	LPCanvasDto canvasDto = new LPCanvasDto();
    	canvasDto.setCan_pageno(nowPageNo);
    	// 스케치북 세팅
    	canvasDto.setSketch_id("1");
    	// 보고 있는 페이지의 캔버스 id값을 가져옴
    	String id = canvasService.canvasSelectID(canvasDto);
    	// 캔버스 dto 세팅
    	canvasDto = canvasService.canvasSelectOne(id);
    	
    	// 삭제를 위해 Map에 담음 (담을값들 can_id,can_type,sketch_id,pageNo)
    	Map<String,String> delMap = new HashMap<String,String>();
    	delMap.put("can_id", id);
    	delMap.put("can_type", canvasDto.getCan_type());
    	delMap.put("sketch_id", canvasDto.getSketch_id());
    	delMap.put("pageNo", canvasDto.getCan_pageno());
    	// 삭제
    	canvasService.canvasDelete(delMap);
    	return "kim";
    }
    
    @RequestMapping(value="canvasDownloadExcel.do",method=RequestMethod.GET)
    public void canvasDownloadExcel(HttpServletResponse response) throws IOException {
    	List<LPDaysDto> canvasList = canvasService.canvasDownloadExcel("1");
    	
    	XSSFWorkbook workbook = new XSSFWorkbook();
    	XSSFSheet sheet = null; 
    	XSSFRow row= null;
    	XSSFCell cell = null;
    	
        // 테이블 헤더용 스타일
        XSSFCellStyle headStyle = workbook.createCellStyle();

        // 가는 경계선을 가집니다.
        headStyle.setBorderTop(BorderStyle.THIN);
        headStyle.setBorderBottom(BorderStyle.THIN);
        headStyle.setBorderLeft(BorderStyle.THIN);
        headStyle.setBorderRight(BorderStyle.THIN);
    	 
    	// 데이터 부분 생성	   
	    int rowNo = 1;
	    int days = 1;
	    // 이전 아이디 체크
	    String beforeId = "0";	    
	    System.out.println(canvasList.size());
    	for(int i= 0; i < canvasList.size() ; i++) {
    		// 아이디가 같으면 같은 일자이므로
    		if(!(canvasList.get(i).getCan_id().equalsIgnoreCase(beforeId))) {    			
    			sheet = workbook.createSheet(days+"일차");
    			row = sheet.createRow(0);
          	 	cell = row.createCell(0);
    	       	cell.setCellStyle(headStyle);
    	       	cell.setCellValue("일정제목");
    	       	cell = row.createCell(1);
    	      	cell.setCellStyle(headStyle);
    	      	cell.setCellValue("출발시간");
    	      	cell = row.createCell(2);
    	       	cell.setCellStyle(headStyle);
    	       	cell.setCellValue("도착시간");
    	       	cell = row.createCell(3);
    	       	cell.setCellStyle(headStyle);
    	       	cell.setCellValue("주소");
    	       	days++;
    			rowNo = 1;   			
    		} 
		    row = sheet.createRow(rowNo);
   	        cell = row.createCell(0);   	        
    	    cell.setCellValue(canvasList.get(i).getDays_title());
   	        cell = row.createCell(1);   	       
   	        cell.setCellValue(canvasList.get(i).getDays_sdate());
   	        cell = row.createCell(2);   	       
   	        cell.setCellValue(canvasList.get(i).getDays_edate());
   	        cell = row.createCell(3);   	       
	        cell.setCellValue(canvasList.get(i).getDays_address());
	        rowNo++;    
	        beforeId = canvasList.get(i).getCan_id();
    	}


    		SimpleDateFormat simpleFormat = new SimpleDateFormat ( "yyyyMMdd");
    		Date time = new Date();  
        	String fileName = simpleFormat.format(time) + "_testdays.xls";
        	
    	    // 컨텐츠 타입과 파일명 지정
    	    response.setContentType("ms-vnd/excel");
    	    response.setHeader("Content-Disposition", "attachment;filename="+fileName);
    	    // 엑셀 출력
    	    workbook.write(response.getOutputStream());
    	    workbook.close();       	
    }      
    
    
    
    @ResponseBody
    @RequestMapping(value="updateDaysCanvas.do",method=RequestMethod.POST)
    public Map<String, String> updateDaysCanvas(HttpSession session,@RequestBody Map<String, Object> val) throws ParseException{
    	// 캔버스 가져 오기
    	LPCanvasDto canvasDto =  (LPCanvasDto)session.getAttribute("canvas");
    	    	
    	if(canvasDto!= null) {    		
    	}
    	// 해당 캔버스의 일정내용 싹 지우기
    	daysService.daysDelete(canvasDto.getCan_id());	
    	
    	for(int i = 0; i < val.size() ; i++) {
    	Map<String,String> map = (Map<String,String>)val.get("days"+i);
    	//System.out.println(map);   
    	SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    		LPDaysDto dto = new LPDaysDto(canvasDto.getCan_id(), map.get("title"), map.get("content"), formatDate.parse(map.get("startDate")), formatDate.parse(map.get("endDate")), map.get("x") , map.get("y"), map.get("address"));
    		daysService.daysInsert(dto);
    	}        		 	
    	Map<String,String> result = new HashMap<String,String>();
    	result.put("result", "성공");
    	return result;
    }
    
    @RequestMapping(value="canvasDownloadImage.do",method=RequestMethod.GET)
    public void canvasDownloadImage(HttpServletResponse response) {
    	
    }
}
