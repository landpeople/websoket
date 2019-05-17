package happy.land.people.model;

import java.util.List;

import happy.land.people.dto.TestDto;

public interface ITestService {
	// 데이터 베이스 연결 결과값 확인
	public List<TestDto> jobAll();
	// Transaction 처리 Dao
	public int transactionUpdateTest();
	//Spring security 사용 입력 : 계속해서 사용하는 거라서 비교했을 때 match라는 애를 통해서 역추적을 통해서 비교해야함! 중요!!
	public int cryptographicInsert(TestDto dto);
	//Spring security 사용 비교
	public TestDto crytographicCompare(TestDto dto);
}
