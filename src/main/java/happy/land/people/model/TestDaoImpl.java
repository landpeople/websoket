package happy.land.people.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.TestDto;

@Repository
public class TestDaoImpl implements ITestDao {
	private Logger logger = LoggerFactory.getLogger(TestDaoImpl.class);

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public List<TestDto> jobAll() {

		logger.info("● Repository jobsAll 실행");
		return sqlSession.selectList("statement_test.jobsAll");
	}

	@Override
	public int update01() {
		logger.info("● Repository update01 성공 실행");
		return sqlSession.update("statement_test.update01");
	}

	@Override
	public int update02() {
		logger.info("● Repository update02 실패 실행");
		return sqlSession.update("statement_test.update02");
	}

	@Override
	public int cryptographicInsert(TestDto dto) {
		logger.info("● Repository cryptographicInsert 실행");
		String passwordEncode = passwordEncoder.encode(dto.getJob_title());
		dto.setJob_title(passwordEncode);
		return sqlSession.insert("statement_test.cryptographic",dto);
	}

	@Override
	public TestDto crytographicCompare(TestDto dto) {
		logger.info("● Repository crytographicCompare 실행");
		TestDto dbPWDto = sqlSession.selectOne("statement_test.crytographicCompare",dto);
		// DB PW 값
		String dbPW = dbPWDto.getJob_title();
		// 전달 받은 PW 값
		String reqPW = dto.getJob_title();
		System.out.println("● DB PW 값 : " + dbPW);
		System.out.println("● 전달 받은 PW 값 : " + reqPW);
		
		if(passwordEncoder.matches(reqPW, dbPW)) {
			logger.info("==================== 패스워드 일치 ====================");
		};
		return dbPWDto;
	}
}
