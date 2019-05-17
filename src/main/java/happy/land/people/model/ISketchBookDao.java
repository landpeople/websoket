package happy.land.people.model;

import java.util.Map;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPCollectDto;


public interface ISketchBookDao {
	
	// 스케치북 작성권한 확인
	public String sketchSelectWrite(String user_email);
	
	// 스케치북 생성 
	public boolean sketchInsert(LPSketchbookDto dto);
	
	// 스크랩 최초 등록
	public boolean collectInsert(LPCollectDto dto);
	
	// 스케치북 스크랩 상태 확인
	public String scrapeSelect(Map<String, String> map);
	
	// 스케치북 스크랩 상태 변경(등록, 취소)
	public boolean scrapeUpdate(Map<String, String>map);
	
	// 스케치북 상태 가져오기
	public String likeSelect(Map<String, String> map);
	
	// 스케치북 좋아요 상태 변경(등록, 취소)
	public boolean likeUpdate(Map<String, String>map);
	
	
}
