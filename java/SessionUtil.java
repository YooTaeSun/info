package com.osstem.ow.common.util;

import javax.servlet.http.HttpSession;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.osstem.ow.model.SawonDetailInfo;

/**
 * session Util
 * - Spring에서 제공하는 RequestContextHolder 를 이용하여
 * request 객체를 service까지 전달하지 않고 사용할 수 있게 해줌
 *
 */
public class SessionUtil {
    /**
     * attribute 값을 가져 오기 위한 method
     *
     * @param String  attribute key name
     * @return Object attribute obj
     */
    public static Object getAttribute(String name){
        return (Object)RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
    }

    /**
     * attribute 설정 method
     *
     * @param String  attribute key name
     * @param Object  attribute obj
     * @return void
     */
    public static void setAttribute(String name, Object object){
    	try{
    		RequestContextHolder.getRequestAttributes().setAttribute(name, object, RequestAttributes.SCOPE_SESSION);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }

    /**
     * 설정한 attribute 삭제
     *
     * @param String  attribute key name
     * @return void
     */
    public static void removeAttribute(String name){
    	try{
    		RequestContextHolder.getRequestAttributes().removeAttribute(name, RequestAttributes.SCOPE_SESSION);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }

    /**
     * session id
     *
     * @param void
     * @return String SessionId 값
     */
    public static String getSessionId(){
    	try{
    		return RequestContextHolder.getRequestAttributes().getSessionId();
    	}catch(Exception e){
    		e.printStackTrace();
    		return "";
    	}    
    }
    
    /**
     * 로그인사용자정보
     * @return
     *
     */
    @Deprecated
    public static SawonDetailInfo getLoginUser() {
      
      ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
      HttpSession session = attr.getRequest().getSession(true);
      return (SawonDetailInfo) session.getAttribute("UserInfo");

    }
    
    /**
     * 로그인한 사용자의 사번을 리턴
     * @return
     *
     */
    public static String getLoginUserId() {
      
      SawonDetailInfo userInfo = SessionUtil.getLoginUser();
      if(userInfo == null) {
       //TODO 로그인 시스템이 확정되지 않아 임시로 코딩. 정상개발 이후에 걷어내시오.
        return "21120430";
      }
        
      return userInfo.getSabun();
    }
    
    
}