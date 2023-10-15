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
Part part = request.getPart("ofile");					
String partHeader = part.getHeader("content-disposition");
//System.out.println("partHeader="+ partHeader);
String[] phArr = partHeader.split("filename=");
String originalFileName = phArr[1].trim().replace("\"", "");
if (!originalFileName.isEmpty()) {				
	part.write(saveDirectory+ File.separator +originalFileName);
}

//파일명 변경하기 
String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
String newFileName = now + ext;  
File oldFile = new File(saveDirectory + File.separator + originalFileName);
File newFile = new File(saveDirectory + File.separator + newFileName);
oldFile.renameTo(newFile);

//폼값받기
String title = request.getParameter("title");
String[] cate = request.getParameterValues("cate");
StringBuffer cateBuf = new StringBuffer();
for(String s : cate){
	cateBuf.append(s + ", ");
}

//DB입력
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