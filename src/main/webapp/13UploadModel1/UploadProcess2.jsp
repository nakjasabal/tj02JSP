<%@page import="fileupload.FileUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="fileupload.MyFileDAO"%>
<%@page import="fileupload.MyFileDTO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//파일업로드
String saveDirectory = application.getRealPath("/Uploads");
String originalFileName = FileUtil.uploadFile(request, saveDirectory);

//파일명 변경하기 
String newFileName = FileUtil.renameFile(saveDirectory, originalFileName);

//폼값받기
String title = request.getParameter("title");
String[] cate = request.getParameterValues("cate");
StringBuffer cateBuf = new StringBuffer();
for(String s : cate){
	cateBuf.append(s + ", ");
}

//DB입력(이 부분도 메서드로 만들 수 있음)
MyFileDTO dto = new MyFileDTO();
dto.setTitle(title);
dto.setCate(cateBuf.toString());
dto.setOfile(originalFileName);
dto.setSfile(newFileName);
MyFileDAO dao = new MyFileDAO();
dao.insertFile(dto);
dao.close();

response.sendRedirect("FileList.jsp");
%>