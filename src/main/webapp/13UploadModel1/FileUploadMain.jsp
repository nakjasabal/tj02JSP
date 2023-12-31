<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>FileUpload</title></head>
<script>
	/* 폼값을 submit(전송)할때 빈값에 대한 검증을 위한 JS 함수
	필수사항인 제목과 첨부파일에 대해서만 검증한다. */
    function validateForm(form, flag) { 
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.ofile.value == "") {
            alert("첨부파일은 필수 입력입니다.");
            return false;
        }
        if(flag==1) form.action = "UploadProcess1.jsp";
        else if(flag==2) form.action = "UploadProcess2.jsp";
        form.submit();
    }
</script>
<body>
    <h3>파일 업로드</h3>
    <span style="color: red;">${errorMessage }</span>
    <!--  
    파일 첨부를 위한 <form>태그 구성시 아래 2가지는 필수사항
    1. method 속성은 반드시 'post'
    2. enctype 속성은 'multipart/form-data'로 해야한다.
    만약 get방식으로 설정하는 경우에는 파일이 전송되는게 아니라 파일명만 전송
    되게된다.  
    -->
    <form name="fileForm" method="post" enctype="multipart/form-data">        
        제목 : <input type="text" name="title" /><br /> 
        카테고리(선택사항) : 
            <input type="checkbox" name="cate" value="사진" checked />사진 
            <input type="checkbox" name="cate" value="과제" />과제 
            <input type="checkbox" name="cate" value="워드" />워드 
            <input type="checkbox" name="cate" value="음원" />음원 <br /> 
        첨부파일 : <input type="file" name="ofile" /> <br />
        <!-- 별도의 처리 메서드 없음 -->
        <input type="button" value="전송하기1" onclick="validateForm(this.form, 1);" />
        <!-- 서블릿 방식에서 만든 메서드 사용 -->
        <input type="button" value="전송하기2" onclick="validateForm(this.form, 2);" />
    </form>
</body>
</html>