package happy.land.people.model.kim;

import java.util.List;

import happy.land.people.dto.kim.LPMapdataDto;

public interface ILPMapdataService {
	public int mapInsert(LPMapdataDto dto);
	public List<LPMapdataDto> mapSelectType(String type);
}
