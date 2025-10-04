<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
     Header 커스텀 태그
================================ --%>

<header class="header">

	<div class="alert_section" id="toast"></div>
	<div id="overlay" class="overlay"></div>
	
	<div class="header-right">
		<button class="icon-btn" title="알림">
			<i class="bi bi-bell"></i>
		</button>

		<div class="dropdown_myinfo">
			<button class="icon-btn" title="내 프로필">
				<i class="bi bi-person"></i>
			</button>

			<!-- myInfo modal -->
			<div class="modal loginInfo ">
				<div class="info">
					<div class="prof_img">
						<img src="/image/logo_black.svg" alt="logo">
					</div>
					<span class="aname"><b>&nbsp;${aname}</b></span>
					<span><b>[ADMIN]</b></span>
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
	    loginInfoBox.classList.toggle("show");
	});
	
	// 팝업 내부는 닫힘 방지
	loginInfoBox.addEventListener("click", (e) => e.stopPropagation());
	
	// 문서 아무 곳이나 클릭 → 팝업 닫기
	document.addEventListener("click", () => {
	    if (loginInfoBox.classList.contains("show")) {
	    	loginInfoBox.classList.remove("show");
	    }
	});

	
	//로그아웃 
	function admin_logout() {
		fetch("/admin/logout", {
			method: "GET",
			
		}).then(function(data) {
			return data.json();

		}).then(function(result) {
			if(result.status == "ok"){
				// 오버레이 표시
				document.getElementById("overlay").classList.add("active");
						
				//로그아웃 성공 알럿 표시
				showAlert("success", result.title, result.message); // 2초간 토스트
				
				//로그인으로 이동
				setTimeout(() => {
					location.href = "/admin/login"; // 2초 후 로그인 화면으로 이동
				}, 2000);
				
			}else if(result=="fail"){
				showAlert("error", result.title, result.message);
			}

		}).catch(function(error) {
			console.log("통신오류발생", error);
		    showAlert("error", "서버 오류", "통신 중 오류가 발생했습니다.");
		});
	}
</script>





