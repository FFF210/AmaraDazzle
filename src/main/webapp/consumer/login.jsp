<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - AD</title>
    <link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">    
    <link rel="stylesheet" href="<c:url value='/consumer/css/login.css'/>">
    <link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
    <link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
    <!-- 카카오 SDK -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body class="login-page">
    <!-- 헤더 include -->
    <%@ include file="/consumer/header.jsp" %>
    
    <div class="login-container">
            <h1 class="login-title">로그인</h1>
            
            <!-- 일반 로그인 폼 -->
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                <div class="input-group">
                    <div class="form-group">
					<label for="loginId">아이디</label>
					<my:textInput id="loginId" name="loginId" placeholder="아이디를 입력하세요"
						type="default" size="lg" state="default" />
				</div>
				<div class="form-group">
					<label for="loginPw">비밀번호</label>
					<my:textInput id="loginPw" name="loginPw" placeholder="비밀번호를 입력하세요"
						type="password" size="lg" state="default" />
				</div>
			</div>
                
                <div class="form-options">
				<p><input type="checkbox" name="rememberId" /> 아이디 기억하기</p>
				<a href="/findAccount" class="link">아이디/비밀번호 찾기</a>
			</div>
                
                <button type="submit" class="btn btn-primary btn-xl login">로그인</button>
                
            <!-- 카카오 로그인 버튼 -->
            <button type="button" class="kakao-login-btn" onclick="loginWithKakao()">
                <img src="<c:url value='/images/kakao_login_icon.svg'/>" 
                     alt="카카오" class="kakao-icon">
                카카오 로그인
            </button>
                    
            <p class="auth-footer">
				아직 계정이 없으신가요? <a href="/signup" class="link">회원가입</a>
		    </p>
	</form>
   </div>
    
    <!-- 푸터 include -->
    <%@ include file="/consumer/footer.jsp" %>
    
    <script src="${pageContext.request.contextPath}/resources/js/login.js"></script>
    
    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty errorMessage}">
        <script>
            alert('${errorMessage}');
        </script>
    </c:if>
</body>
</html>