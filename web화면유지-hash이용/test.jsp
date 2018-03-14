<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException"%>
<%=java.nio.charset.Charset.defaultCharset() %>
<%
/*
HOME : /usr/share/tomcat8
CONF :  /etc/tomcat8
LOG :  /var/log/tomcat8
ROOT : /var/lib/tomcat8
 */

        try {
            Runtime.getRuntime().exec("chown -R root:root /var/lib/tomcat8");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        try {
            Runtime.getRuntime().exec("chown -R root:root /var/log/tomcat8");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
%>
