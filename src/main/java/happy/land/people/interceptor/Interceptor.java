package happy.land.people.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/*
 * servlet-context.xml의 Intercepion
 *
 */
public class Interceptor extends HandlerInterceptorAdapter {

	private Logger logger = LoggerFactory.getLogger(Interceptor.class); // 클래스를 넣는 이유 이 클래스에 넣는 애들만 로그릴 찍어주겠다.

	// 인터셉터가 시작될때
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("==================== 인터셉터 시작 {} ====================", new Date());
		HttpSession session = request.getSession();
		session.getAttribute("loginDto");
		if (session.getAttribute("loginDto") == null) { // 들어오면 loginDto가 있는지를 확인. 마바티스가 아니가 하이버네이트가 일 경우, 값까지 확인해야하는
														// 경우가 있음?
			response.sendRedirect("./ind.jsp");
			return false;
		} // 이전에는 여기다가 try-catch 걸어줬었음
		return super.preHandle(request, response, handler);
	}

	// 인터셉터가 지나가고 나서
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.debug("==================== 인터셉터 종료 {} ====================", new Date());
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}
