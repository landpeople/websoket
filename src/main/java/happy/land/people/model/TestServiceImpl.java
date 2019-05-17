package happy.land.people.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.TestDto;

@Service
public class TestServiceImpl implements ITestService {

	private Logger logger = LoggerFactory.getLogger(TestServiceImpl.class);

	@Autowired
	private ITestDao dao;

	// aop intercepter 걸어서 왼쪽 빨간색 화살표 걸림!
	@Override
	public List<TestDto> jobAll() {
		logger.info("● Service jobsAll 실행");
		return dao.jobAll();
	}

	@Override
//	@Transactional(readOnly=false) // application-context에서 transaction aop로 걸어줘서 이거 주석처리해줌
	public int transactionUpdateTest() {
		logger.info("● Service transactionUpdateTest 실행");
		int a = dao.update01();
		int b = dao.update02();
		return a + b;
	}

	@Override
	public int cryptographicInsert(TestDto dto) {
		logger.info("● Service cryptographicInsert 실행");
		return dao.cryptographicInsert(dto);
	}

	@Override
	public TestDto crytographicCompare(TestDto dto) {
		logger.info("● Service crytographicCompare 실행");
		return dao.crytographicCompare(dto);
	}
}