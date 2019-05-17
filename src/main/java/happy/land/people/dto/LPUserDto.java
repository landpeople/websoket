package happy.land.people.dto;

public class LPUserDto {

	private String user_email;
	private String user_password;
	private String user_nickname;
	private String user_auth;
	private String user_delflag;
	private String user_emailchk;
	private String user_emailkey;
	private String user_iswrite;
	
	private String serviceImplYn;
	private String input;
	private String rows;
	private String page;
	
	public LPUserDto() {
	}
	
	public LPUserDto(String user_email, String user_password, String user_nickname, String user_auth,
			String user_delflag, String user_emailchk, String user_emailkey, String user_iswrite, String serviceImplYn,
			String input, String rows, String page) {
		super();
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_nickname = user_nickname;
		this.user_auth = user_auth;
		this.user_delflag = user_delflag;
		this.user_emailchk = user_emailchk;
		this.user_emailkey = user_emailkey;
		this.user_iswrite = user_iswrite;
		this.serviceImplYn = serviceImplYn;
		this.input = input;
		this.rows = rows;
		this.page = page;
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

	public String getUser_iswrite() {
		return user_iswrite;
	}

	public void setUser_iswrite(String user_iswrite) {
		this.user_iswrite = user_iswrite;
	}

	public String getServiceImplYn() {
		return serviceImplYn;
	}

	public void setServiceImplYn(String serviceImplYn) {
		this.serviceImplYn = serviceImplYn;
	}

	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
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
	
	
}
