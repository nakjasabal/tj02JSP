<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<html>
<head><title>Session</title></head>
<body>	 
	<!-- 액션태그를 통해 외부 JSP파일을 현재 문서에 인클루드 한다.  -->
	<jsp:include page="../Common/Link.jsp" />
	<%--@ include file="../Common/Link.jsp" --%>
	
    <h2>로그인 페이지</h2>
 	
 	<!--  
 	로그인을 위해 폼값을 전송한 후 만약 조건에 맞는 회원정보가 없는경우
 	request영역에 에러메세지를 저장한 후 현제페이지로 포워드한다. 
 	request영역은 forward된 페이지까지는 영역이 공유되므로 아래와같이
 	메세지를 출력할 수 있다. 
 	-->
    <span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg") %>
    </span>
    
<%
/*
session영역에 해당 속성값이 있는지 확인한다. 즉 세션영역에 속성값이
없다면 로그아웃 상태이므로 로그인폼을 웹브라우저에 출력한다. 
*/
if (session.getAttribute("UserId") == null) { 
%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    $(function(){
    	$('#submit').click(function(){    		
    		let id = document.getElementById('user_id');
    		let pw = document.getElementById('user_pw');
    		
    		if (!id.value) {
                alert("아이디를 입력하세요.");
                id.focus();
                return false;
            } 
            if (pw.value == "") {
                alert("패스워드를 입력하세요.");
                pw.focus();
                return false;
            }
            
    		//사용자가 입력값을 파라미터로 조립 
    		let params = {
    			'user_id':$('#user_id').val(),
    			'user_pw':$('#user_pw').val()
    		};    		
    		$.post(
    			"LoginProcess.jsp",
    			params,
    			function(resData){
    				console.log("텍스트형 콜백", resData);    				
    				let json = JSON.parse(resData);
    				console.log("JSON으로 변환", json);
    				
    				if(json.result=='로그인성공'){
    					let str = json.userName+' 회원님, 로그인하셨습니다(Ajax1).<br />'
    						+'<a href="Logout.jsp">[로그아웃]</a>';
    					$('#loginFrm').html(str);
    				}
    				else{
    					alert('아이디/비번을 확인하세요');
    				}
    			}
    		);
    	});
    });
    </script>
    <form id="loginFrm">
        아이디 : <input type="text" id="user_id" /><br />
        패스워드 : <input type="password" id="user_pw" /><br />
        <input type="button" id="submit" value="로그인하기" />
    </form>
<%
} else {  
	/* 세션영역에 저장된 속성값이 있다면 로그인 된 상태이므로, 회원정보와 
	로그아웃 버튼을 출력한다. */
%>
        <%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
        <a href="Logout.jsp">[로그아웃]</a>
<%
}
%>
</body>
</html>
