package happy.land.people.model.kim;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPDaysDto;

@Service
public class LPCanvasServiceImpl implements ILPCanvasService{

	@Autowired
	private ILPCanvasDao canvasDao;
	
	@Override
	public int canvasCnt(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasCnt(id);
	}

	@Override
	public List<LPCanvasDto> canvasSelectType(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasSelectType(id);
	}

	@Override	
	public int canvasInsert(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		return canvasDao.canvasInsert(dto);
	}

	@Override
	public String canvasSelectID(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		return canvasDao.canvasSelectID(dto);
	}

	@Override
	public List<LPDaysDto> canvasDownloadExcel(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasDownloadExcel(id);
	}

	@Override
	public LPCanvasDto canvasSelectOne(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasSelectOne(id);
	}

	@Override
	public int canvasDelete(Map<String, String> map) {
		// TODO Auto-generated method stub
		return canvasDao.canvasDelete(map);
	}

}
