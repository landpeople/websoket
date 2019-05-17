package happy.land.people.model.jang;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPUserDto;

@Service
public class ManagerServiceImpl implements IManagerService {

	private Logger logger = LoggerFactory.getLogger(ManagerServiceImpl.class);
	
	@Autowired
	private IManagerDao iManagerDao;
	
	@Override
	public List<Map<String, String>> selectMemberList(LPUserDto dto) {
		logger.info("회원 목록 조회 selectMemberList {}", dto);
		return iManagerDao.selectMemberList(dto);
	}

	@Override
	public Map<String, Integer> selectMemberListCnt(LPUserDto dto) {
		logger.info("회원 목록 개수 selectMemberListCnt {}", dto);
		return iManagerDao.selectMemberListCnt(dto);
	}

	@Override
	public List<Map<String, String>> selectSketchList(LPSketchbookDto lsDto) {
		logger.info("스케치북 목록 조회 selectSketchList {}", lsDto);
		return iManagerDao.selectSketchList(lsDto);
	}

	@Override
	public Map<String, Integer> selectSketchListCnt(LPSketchbookDto lsDto) {
		logger.info("스케치북 목록 개수 selectSketchListCnt {}", lsDto);
		return iManagerDao.selectSketchListCnt(lsDto);
	}

	@Override
	public boolean modifyIswrite(String email) {
		logger.info("회원 작성권한 수정  modifyIswrite {}", email);
		return iManagerDao.modifyIswrite(email);
	}

	@Override
	public boolean modifyBlock(String id) {
		logger.info("스케치북 공개/비공개 수정  modifyBlock {}", id);
		return iManagerDao.modifyBlock(id);
	}

	
}
