<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 완료 - AD</title>
    <link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
    <link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/tagcss/tab.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/joinComplete.css'/>">
    <link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
  
</head>
<body> 
    <%@ include file="/consumer/header.jsp" %>
    
    <main class="main-container">
        <!-- 성공 아이콘 -->
        <div class="success-icon"></div>
        
        <!-- 메인 메시지 -->
        <h1 class="main-title">회원가입이 완료되었습니다.</h1>
        
        <p class="sub-text">회원가입 축하 쿠폰이 발행되었습니다.</p>
        <p class="info-text">
            로그인 후 마이페이지 포인트/쿠폰 메뉴에서 확인하실 수 있습니다.
        </p>
        

        <div class="btn-container">        
            <a href="${pageContext.request.contextPath}/store/login" class="btn btn-primary">로그인</a>
        </div>
           
    </main>
    
    
    <%@ include file="/consumer/footer.jsp" %>
    
    <script>
        // 페이지 로드 시 애니메이션 효과
        document.addEventListener('DOMContentLoaded', function() {
            const successIcon = document.querySelector('.success-icon');
            const mainTitle = document.querySelector('.main-title');
            
            // 아이콘 애니메이션
            successIcon.style.transform = 'scale(0)';
            successIcon.style.transition = 'transform 0.5s ease-out';
            
            setTimeout(() => {
                successIcon.style.transform = 'scale(1)';
            }, 100);
            
            // 제목 fade-in 효과
            mainTitle.style.opacity = '0';
            mainTitle.style.transform = 'translateY(20px)';
            mainTitle.style.transition = 'all 0.6s ease-out';
            
            setTimeout(() => {
                mainTitle.style.opacity = '1';
                mainTitle.style.transform = 'translateY(0)';
            }, 300);
        });
        
        // 버튼 클릭 효과
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                // 클릭 효과
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
    </script>
</body>
</html>