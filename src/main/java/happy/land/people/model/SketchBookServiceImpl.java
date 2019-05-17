package happy.land.people.model;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPCollectDto;

@Service
public class SketchBookServiceImpl implements ISketchBookService {

	private Logger logger = LoggerFactory.getLogger(SketchBookServiceImpl.class);
	
	@Autowired
	private ISketchBookDao iSketchBookDao;
	
	
	@Override
	public String sketchSelectWrite(String user_email) {
		logger.info("service sketchSelectWrite 스케치북 작성 권한 확인");
		return iSketchBookDao.sketchSelectWrite(user_email);
	}
	
	@Override
	public boolean sketchInsert(LPSketchbookDto dto) {
		logger.info("service sketchInsert 스케치북 생성 실행");
		return iSketchBookDao.sketchInsert(dto);
	}
	
	
	@Override
	public boolean collectInsert(LPCollectDto dto) {
		logger.info("service collectInsert 좋아요 최초등록 실행");
		return iSketchBookDao.collectInsert(dto);
	}
	
	@Override
	public String scrapeSelect(Map<String, String> map) {
		logger.info("service selScrape 좋아요 현재상태 가져오기");
		return iSketchBookDao.scrapeSelect(map);
		
	}
	
	@Override
	public boolean scrapeUpdate(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service scrapeChange 스크랩 상태 변경 실행");
		return iSketchBookDao.scrapeUpdate(map);
	}

	@Override
	public boolean likeUpdate(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service likeCancel 좋아요 상태 변경 실행");
		return iSketchBookDao.likeUpdate(map);
	}

	@Override
	public String likeSelect(Map<String, String> map) {
		
		logger.info("service selLike 좋아요 상태 변경 실행");
		return iSketchBookDao.likeSelect(map);
	}


	

	



	

}
