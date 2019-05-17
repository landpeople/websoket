package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LeeServiceImpl implements ILeeService {

	private Logger logger = LoggerFactory.getLogger(LeeServiceImpl.class);

	@Autowired
	private ILeeDao dao;
	

	@Override
	public int chatList_Insert(String user_nickname) {
		logger.info("● Service chatList_Insert 실행");
		return dao.chatList_Insert(user_nickname);
	}
	
	@Override
	public List<String> chatList_SelectAll() {
		logger.info("● Service chatList_SelectAll 실행");
		return dao.chatList_SelectAll();
	}

	@Override
	public String chatRoom_Select(Map<String, String> map) {
		logger.info("● Service chatRoom_Select 실행");
		return dao.chatRoom_Select(map);
	}

	@Override
	public int chatRoom_UpdateOut(String chr_id) {
		logger.info("● Service chatRoom_UpdateOut 실행");
		return dao.chatRoom_UpdateOut(chr_id);
	}

	@Override
	public int chatRoom_Insert(Map<String, String> map) {
		logger.info("● Service chatRoom_Insert 실행");
		return dao.chatRoom_Insert(map);
	}

	@Override
	public String chkChatMember(String chr_id) {
		logger.info("● Service chkChatMember 실행");
		return dao.chkChatMember(chr_id);
	}
}