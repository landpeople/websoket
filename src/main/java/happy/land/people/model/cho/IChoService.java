package happy.land.people.model.cho;

import java.util.Map;

import happy.land.people.dto.cho.ChoDto;

public interface IChoService {
	//회원가입
	public boolean signUp(ChoDto dto);
	//로그인
	public ChoDto login(ChoDto dto);
	//회원탈퇴
	public boolean deleteUser(String user_email);
	//정보수정
	public boolean userInfo(Map<String, String> map); 
	//이메일중복체크
	public int emailDupChk(String user_email);
	//닉네임중복체크
	public int nicknameDupChk(String user_nickname);
	//이메일 인증키 저장
	public boolean authkeyUpdate(ChoDto dto);
	//이메일 인증 상태 변경
	public boolean authStatusUpdate(String user_email);
}
