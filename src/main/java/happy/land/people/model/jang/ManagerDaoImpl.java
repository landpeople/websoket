package happy.land.people.model.jang;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPUserDto;

@Repository
public class ManagerDaoImpl implements IManagerDao {

	private Logger logger = LoggerFactory.getLogger(ManagerDaoImpl.class);
	private final String NS = "jang_test.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 회원 목록 조회
	@Override
	public List<Map<String, String>> selectMemberList(LPUserDto dto) {
		return sqlSession.selectList(NS+"selectMemberList", dto);
	}

	// 회원 목록 개수
	@Override
	public Map<String, Integer> selectMemberListCnt(LPUserDto dto) {
		return sqlSession.selectOne(NS+"selectMemberListCnt", dto);
	}

	@Override
	public List<Map<String, String>> selectSketchList(LPSketchbookDto lsDto) {
		return sqlSession.selectList(NS+"selectSketchList", lsDto);
	}

	@Override
	public Map<String, Integer> selectSketchListCnt(LPSketchbookDto lsDto) {
		return sqlSession.selectOne(NS+"selectSketchListCnt", lsDto);
	}

	// 회원 작성권한 수정
	@Override
	public boolean modifyIswrite(String email) {
		String str = sqlSession.selectOne(NS+"selectIswrite", email);
		logger.info("회원 작성권한 수정 50%! modifyIswrite {}", str);
		Map<String, String> map = new HashMap<String, String>();
		map.put("Iswrite", str);
		map.put("email", email);
		
		int n = sqlSession.update(NS+"modifyIswrite", map);
		logger.info("회원 작성권한 수정 완료! modifyIswrite {}", n);
		return n>0 ? true:false;
	}

	// 스케치북 공개/비공개 수정
	@Override
	public boolean modifyBlock(String id) {
		String str = sqlSession.selectOne(NS+"selectBlock", id);
		logger.info("스케치북 공개/비공개 수정 50%! modifyIswrite {}", str);
		Map<String, String> map = new HashMap<String, String>();
		map.put("block", str);
		map.put("id", id);
		
		int n = sqlSession.update(NS+"modifyBlock", map);
		logger.info("스케치북 공개/비공개 수정 완료! modifyIswrite {}", n);
		return n>0 ? true:false;
	}

}
