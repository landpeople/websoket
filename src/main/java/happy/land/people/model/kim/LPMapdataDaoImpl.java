package happy.land.people.model.kim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.kim.LPMapdataDto;

@Repository
public class LPMapdataDaoImpl implements ILPMapdataDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//private String NS = "happy.land.people.kim_test.";
	
	
	public LPMapdataDaoImpl() {
		
	}
	
	@Override
	public int mapInsert(LPMapdataDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("kim_test.map_Insert", dto);
	}

	@Override
	public List<LPMapdataDto> mapSelectType(String type) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("kim_test.map_SelectType", type);
	}

}
