<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
     Header 커스텀 태그
================================ --%>

<header class="header">
	<div class="header-right">
		<button class="icon-btn" title="알림">
			<i class="bi bi-bell"></i>
		</button>

		<div class="dropdown_myinfo">
			<button class="icon-btn" title="내 프로필">
				<i class="bi bi-person"></i>
			</button>
			
			<!-- myInfo modal -->
			<div class="modal loginInfo hidden">
				<div class="info">
					<div class="prof_img">
						<img src="/image/logo_black.svg" alt="logo">
					</div>
					<span><b>&nbsp;홍 길 동 [ADMIN]</b></span>
				</div>
				<div class="modifyInfo">
					<button type="button">내 정보 수정</button>
				</div>
				<div class="logout">
					<button type="button" onclick="admin_logout()">로그아웃</button>
				</div>
			</div>
			<!-- myInfo modal end -->
		</div>

		<button type="button" class="link-btn" onclick="">사이트 바로가기</button>
	</div>
</header>
<!-- 헤더부분 end -->




<!-- JS소스 -->
<script>
	// loginInfo 모달 열고닫기 
	const logInfoBtn = document.querySelector(".header .bi-person");
	const loginInfoBox = document.querySelector(".modal.loginInfo");
	
	//팝업 열기/닫기 토글
	logInfoBtn.addEventListener("click", (e) => {
	    e.stopPropagation(); 
	    loginInfoBox.classList.toggle("hidden");
	});
	
	// 팝업 내부는 닫힘 방지
	loginInfoBox.addEventListener("click", (e) => e.stopPropagation());
	
	// 문서 아무 곳이나 클릭 → 팝업 닫기
	document.addEventListener("click", () => {
	    if (!loginInfoBox.classList.contains("hidden")) {
	    	loginInfoBox.classList.add("hidden");
	    }
	});

	
	//로그아웃 
	function admin_logout() {
		location.href="/admin/logout";
		
	}



</script>





