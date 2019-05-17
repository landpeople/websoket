package happy.land.people.dto.cho;

public class ChoDto {
//이메일	
private String user_email; 
//비번
private String user_password;
//닉네임
private String user_nickname;
// 가입종류
private String user_auth;           // N네이버 G구글 U유저 M 매니져
// 회원상태
private String user_delflag;        //  T 탈퇴 F 일반  
// 이메일인증 체크
private String user_emailchk;       // Y 이메일인증함 N 이메일인증 안함
// 이메일키
private String user_emailkey;

public ChoDto() {
}


//회원가입할떄 이메일 닉네임 비번
public ChoDto(String user_email, String user_password, String user_nickname, String user_auth) {
	super();
	this.user_email = user_email;
	this.user_password = user_password;
	this.user_nickname = user_nickname;
	this.user_auth = user_auth;
}

//api회원가입 이메일 닉네임 그리고 가십상태??
public ChoDto(String user_email, String user_nickname, String user_auth) {
	super();
	this.user_email = user_email;
	this.user_nickname = user_nickname;
	this.user_auth = user_auth;
}


//비밀번호 수정
public ChoDto(String user_email) {
	super();
	this.user_email = user_email;
}







public ChoDto(String user_email, String user_password, String user_nickname, String user_auth, String user_delflag,
		String user_emailchk, String user_emailkey) {
	super();
	this.user_email = user_email;
	this.user_password = user_password;
	this.user_nickname = user_nickname;
	this.user_auth = user_auth;
	this.user_delflag = user_delflag;
	this.user_emailchk = user_emailchk;
	this.user_emailkey = user_emailkey;
}






public String getUser_email() {
	return user_email;
}

public void setUser_email(String user_email) {
	this.user_email = user_email;
}

public String getUser_password() {
	return user_password;
}

public void setUser_password(String user_password) {
	this.user_password = user_password;
}

public String getUser_nickname() {
	return user_nickname;
}

public void setUser_nickname(String user_nickname) {
	this.user_nickname = user_nickname;
}

public String getUser_auth() {
	return user_auth;
}

public void setUser_auth(String user_auth) {
	this.user_auth = user_auth;
}

public String getUser_delflag() {
	return user_delflag;
}

public void setUser_delflag(String user_delflag) {
	this.user_delflag = user_delflag;
}

public String getUser_emailchk() {
	return user_emailchk;
}

public void setUser_emailchk(String user_emailchk) {
	this.user_emailchk = user_emailchk;
}

public String getUser_emailkey() {
	return user_emailkey;
}

public void setUser_emailkey(String user_emailkey) {
	this.user_emailkey = user_emailkey;
}

@Override
public String toString() {
	return "ChoDto [user_email=" + user_email + ", user_password=" + user_password + ", user_nickname=" + user_nickname
			+ ", user_auth=" + user_auth + ", user_delflag=" + user_delflag + ", user_emailchk=" + user_emailchk
			+ ", user_emailkey=" + user_emailkey + "]";
}




}
