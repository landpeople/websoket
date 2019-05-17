package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

public interface ILeeDao {
	public List<String> chatList_SelectAll();
	
	public int chatList_Insert(String user_nickname);
	
	// 채팅방 생성
	public String chatRoom_Select(Map<String,String> map);
	public int chatRoom_UpdateOut(String chr_id);
	public int chatRoom_Insert(Map<String,String> map);
	
	public String chkChatMember(String chr_id);
}