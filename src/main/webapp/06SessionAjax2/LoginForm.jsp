<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<html>
<head><title>Session</title></head>
<body> 
	<jsp:include page="../Common/Link.jsp" />
	
    <h2>로그인 페이지</h2>
 	
    <span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg") %>
    </span>
    
<%
if (session.getAttribute("UserId") == null) { 
%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    $(function(){
    	$('form[name=loginFrm]').submit(function(){        
            let f = document.loginFrm;   		
    		if (!f.user_id.value) {
                alert("아이디를 입력하세요.");
                f.user_id.focus();
                return false;
            }
            if (f.user_pw.value == "") {
                alert("패스워드를 입력하세요.");
                f.user_pw.focus();
                return false;
            }            
    		//사용자가 입력한 값 파라미터로 자동조립
    		let params = $('form[name=loginFrm]').serialize();
    		console.log("params", params);
    		$.post(
    			"LoginProcess.jsp",
    			params,
    			function(resData){
    				console.log("텍스트형 콜백", resData);    				
    				let json = JSON.parse(resData);
    				console.log("JSON으로 변환", json);
    				if(json.result=='로그인성공'){
    					let str = json.userName+' 회원님, 로그인하셨습니다(Ajax2)<br />'
    						+'<a href="Logout.jsp">[로그아웃]</a>';
    					$('form[name=loginFrm]').html(str);
    				}
    				else{
    					alert('아이디/비번을 확인하세요');
    				}
    			}
    		);
    		//submit 차단
            return false;
    	});
    });
    </script>
    <form name="loginFrm">
        아이디 : <input type="text" name="user_id" /><br />
        패스워드 : <input type="password" name="user_pw" /><br />
        <input type="submit" value="로그인하기" />
    </form>
<%
} else {  
%>
        <%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
        <a href="Logout.jsp">[로그아웃]</a>
<%
}
%>
</body>
</html>
