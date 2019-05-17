package happy.land.people.model.cho;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import happy.land.people.cho.mail.MailUtils;
import happy.land.people.cho.mail.TempKey;
import happy.land.people.dto.cho.ChoDto;
@Service
public class ChoServiceImpl implements IChoService {

	@Autowired
	private IChoDao iChoDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@Override
	public boolean signUp(ChoDto dto) {
		System.out.println("signUp 서비스 임플");
		boolean isc = iChoDao.signUp(dto);
		System.out.println("==============================================================="+isc);
		//authkey 임시 생성 후 dto 같이 담아줌
		String user_emailkey = new TempKey().getKey(50, false);
		dto.setUser_emailkey(user_emailkey);
		System.out.println(dto);
		
		isc = iChoDao.authkeyUpdate(dto);
		
		// 메일 관련
		// 메일 내용 담을 변수(email, authkey만 보낼예정)
		String mailContent = new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
				.append("<a href='http://192.168.10.186:8091/LandPeople/mailConfirm.do?user_email=")
				.append(dto.getUser_email())
				.append("&authkey=").append(dto.getUser_emailkey())
				.append("' target='_blank' >이메일 인증 확인</a>").toString();
	
		
		
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			
			// 메일 제목
			sendMail.setSubject("[LandPeople] 서비스 메일 인증");
			// 메일 내용 (html전송)
			sendMail.setText(mailContent);
			// 메일 보내는 계정
			sendMail.setFrom("info.happy0612@gmail.com", "육지사람");
			// 메일 받는 사람
			sendMail.setTo(dto.getUser_email());
			
			sendMail.send();
			
		} catch (MessagingException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return isc;
	}

	@Override
	public ChoDto login(ChoDto dto) {
		return iChoDao.login(dto);
	}

	@Override
	public boolean deleteUser(String user_email) {
		// TODO Auto-generated method stub
		return iChoDao.deleteUser(user_email);
	}

	@Override
	public boolean userInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int emailDupChk(String user_email) {
		// TODO Auto-generated method stub
		return iChoDao.emailDupChk(user_email);
	}

	@Override
	public int nicknameDupChk(String user_nickname) {
		// TODO Auto-generated method stub
		return iChoDao.nicknameDupChk(user_nickname);
	}

	@Override
	public boolean authkeyUpdate(ChoDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean authStatusUpdate(String user_email) {
		return iChoDao.authStatusUpdate(user_email);
	}

}
