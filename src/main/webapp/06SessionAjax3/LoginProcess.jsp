<%@page import="org.json.simple.JSONObject"%>
<%@ page import="membership.MemberDTO"%>
<%@ page import="membership.MemberDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
//로그인 폼에서 입력한 값을 받는다. 
String userId = request.getParameter("user_id"); 
String userPwd = request.getParameter("user_pw");
System.out.println(userId+"="+userPwd);


//web.xml에 입력한 컨텍스트 초기화 파라미터를 읽어온다. 
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//위 정보를 통해 DAO 인스턴스를 생성하고 오라클에 연결한다. 
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
//메서드 호출을 통해 아이디, 패스워드와 일치하는 회원정보가 있는지 확인한다.
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
//자원반납 
dao.close();

//Simple JSON 인스턴스 
JSONObject obj = new JSONObject();
if (memberDTO.getId() != null) {
    session.setAttribute("UserId", memberDTO.getId()); 
    session.setAttribute("UserName", memberDTO.getName());
    
    obj.put("result", "success");
    obj.put("userName", memberDTO.getName());    
}
else { 
    request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
    obj.put("result", "fail");
}
out.print(obj.toString());    
%>