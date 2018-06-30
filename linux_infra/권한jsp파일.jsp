<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.nio.*"%>
<%=java.nio.charset.Charset.defaultCharset() %>
<%

        try {
            Runtime.getRuntime().exec("chown -R user:user /usr/local/tomcat8/webapps/abcapp");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        try {
            Runtime.getRuntime().exec("chown -R user:user /usr/local/tomcat8/webapps/cseoptool");
        } catch (java.io.IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            Runtime.getRuntime().exec("chown -R user:user /usr/local/tomcat8/webapps/abcapp-debug");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            Runtime.getRuntime().exec("chown -R user:user /usr/local/tomcat8/logs");
        } catch (IOException e) { 
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        try {
            Runtime.getRuntime().exec("chown -R user:user /home/user/logs");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        try {
            Runtime.getRuntime().exec("chown -R user:user /usr/local/tomcat8/temp");
        } catch (java.io.IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
%>
