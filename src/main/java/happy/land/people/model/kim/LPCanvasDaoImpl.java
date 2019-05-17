package happy.land.people.model.kim;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPDaysDto;

@Repository
public class LPCanvasDaoImpl implements ILPCanvasDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int canvasCnt(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("kim_test.canvas_Cnt", id);
	}

	@Override
	public List<LPCanvasDto> canvasSelectType(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("kim_test.canvas_SelectType", id);
	}
	

	@Override	
	public int canvasInsert(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String,String>();
		map.put("pageNo", dto.getCan_pageno());
		map.put("id", dto.getSketch_id());
		sqlSession.update("kim_test.canvas_IncreasePage", map);
		int chk = sqlSession.insert("kim_test.canvas_Insert", dto);
		return chk;
	}

	@Override
	public String canvasSelectID(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("kim_test.canvas_SelectID", dto);
	}

	@Override
	public List<LPDaysDto> canvasDownloadExcel(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("kim_test.canvas_DownloadExcel", id);
	}

	@Override
	public LPCanvasDto canvasSelectOne(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("kim_test.canvas_SelectOne", id);
	}

	@Override
	public int canvasDelete(Map<String,String> map) {
		// TODO Auto-generated method stub
		// 트랜젝션 걸어야 함
		// 가져와야 할 Map의 데이터 can_id,can_type,sketch_id,pageNo
		int delChk = 0;
		if(map.get("can_type").equalsIgnoreCase("1"))
			sqlSession.delete("kim_test.days_Delete", map.get("can_id"));
		else {
			// 자유 캔버스 삭제
		}
		delChk = sqlSession.delete("kim_test.canvas_Delete", map.get("can_id"));
		Map<String,String> delMap = new HashMap<String,String>();
		delMap.put("pageNo",map.get("pageNo"));
		delMap.put("sketch_id", map.get("sketch_id"));
		sqlSession.update("kim_test.canvas_DecreasePage", delMap);
		
		return delChk;
	}
	
}
