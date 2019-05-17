package happy.land.people.aop;

import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// aop에서 실질적으로 실행되는 JAVA Class
// aop-context.xml에 Bean으로 등록 => logAop
public class AopDaoLogger {

	// join pointer
	// 메소드가 실행되기 전에 Argument 정보를 출력
	public void before(JoinPoint j) {

		// 멤버로 선언하면 그 클래스의 로그만 찍히니까
		Logger logger = LoggerFactory.getLogger(j.getTarget() + "");
		logger.info("==================== AOP 시작 ====================");

		// 전달 받은 argument
		Object[] args = j.getArgs();
		
		if (args != null) {
			logger.info("● method:\t" + j.getSignature().getName()); // get name 으로 메소드 명만 가지고 옴
			for (int i = 0; i < args.length; i++) {
				logger.info("● argument : " + i + "번째:\t" + args[i]);
			}
			logger.info("● method:\t" + j.getSignature().getName());
		}
	}

	// 메소드가 실행되고 난 후 리턴이 있을때
	public void afterReturning(JoinPoint j) {
		Logger logger = LoggerFactory.getLogger(j.getTarget() + "");
		logger.info("==================== Aop 끝 ====================");
	}

	// 예외가 발생했을때
	public void afterThrowing(JoinPoint j) {
		Logger logger = LoggerFactory.getLogger(j.getTarget() + "");
		logger.info("● 에러:\t" + j.getArgs());
		logger.info("● 에러:\t" + j.toString());
	}
}