package happy.land.people.model.kim;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.kim.LPMapdataDto;

@Service
public class LPMapdataServiceImpl implements ILPMapdataService{

	@Autowired
	private ILPMapdataDao mapDao;
	
	public LPMapdataServiceImpl() {		
	}
	
	@Override
	public int mapInsert(LPMapdataDto dto) {
		// TODO Auto-generated method stub
		return mapDao.mapInsert(dto);
	}

	@Override
	public List<LPMapdataDto> mapSelectType(String type) {
		// TODO Auto-generated method stub
		return mapDao.mapSelectType(type);
	}

}
