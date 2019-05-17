package happy.land.people.model.cho;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.cho.ChoDto;

@Repository
public class ChoDaoImpl implements IChoDao {

	private Logger logger = LoggerFactory.getLogger(ChoDaoImpl.class);
	
	@Autowired
	private SqlSessionTemplate session;
	private final String NS = "cho_test.";
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public boolean signUp(ChoDto dto) {
		System.out.println("signUp 다오임플");
		boolean isc = false;
		if(dto.getUser_auth().equalsIgnoreCase("U")) {
			String passwordEncode = passwordEncoder.encode(dto.getUser_password());
			dto.setUser_password(passwordEncode);
			isc = session.insert(NS+"signUpU",dto)>0? true:false;
		}else if(dto.getUser_auth().equalsIgnoreCase("N")) {
			isc = session.insert(NS+"signUpN",dto)>0? true:false;
			
		}else if(dto.getUser_auth().equalsIgnoreCase("G")) {
			isc = session.insert(NS+"signUpG", dto)>0? true : false;
		}
		
		return isc;
	}

	@Override
	public boolean authkeyUpdate(ChoDto dto) {
		return session.update(NS+"authkeyUpdate",dto)>0? true:false;
	}

	
	
	// 로그인 다오인데 비밀번호 불일치할떄 로그인이 안되게 설정해줘야함....흠....
	@Override
	public ChoDto login(ChoDto dto) {
		logger.info("login 실행");
		
		// db의 pw값
		ChoDto DBPWDto = session.selectOne(NS+"login", dto);
		// 암호화된 비번
		String DBPW = DBPWDto.getUser_password();
		
		//전달 받은 pw값
		String reqPW = dto.getUser_password();
		
		System.out.println("db의pw값:"+DBPW);
		System.out.println("전달받은PW값:"+reqPW);
		
		if(passwordEncoder.matches(reqPW, DBPW)) {
			logger.info("-------------패스워드일치------------");
			return DBPWDto;
		}else {
			logger.info("--------------패스워드 불일치----------");
		}
		return session.selectOne(NS+"login", dto);
	}

	@Override
	public boolean deleteUser(String user_email) {
		return false;
	}

	@Override
	public boolean userInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int emailDupChk(String user_email) {
		return session.update(NS+"emailDupChk",user_email);
	}

	@Override
	public int nicknameDupChk(String user_nickname) {
		return session.update(NS+"nicknameDupChk",user_nickname);
	}

	@Override
	public boolean authStatusUpdate(String user_email) {
		return session.update(NS+"authStatusUpdate",user_email)>0? true:false;
	}

}
