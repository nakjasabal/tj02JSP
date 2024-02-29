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
    	$('input[type=submit]').click(function(){
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
    		
    		$.ajax({
    			url : './LoginProcess.jsp',  
    			type : 'post', 
    			data : params,
    			dataType : "json", 
    			success : function(resData){
    				console.log("콜백데이터", resData);
    				if(resData.result=='success'){
    					let str = resData.userName+' 회원님, 로그인하셨습니다(Ajax3)<br />'
    						+'<a href="Logout.jsp">[로그아웃]</a>';
    					$('form[name=loginFrm]').html(str);
    				}
    				else{
    					alert('아이디/비번을 확인하세요');
    				}
    			},		 
    			error : function(errData){ 
    				console.log(errData.state, errData.statusText); 
    			},
    		}); 
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
