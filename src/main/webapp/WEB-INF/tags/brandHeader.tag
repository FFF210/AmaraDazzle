<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="admin-header">
	<!-- <button class="icon-btn" title="알림">
        <i class="bi bi-bell"></i>
    </button> -->

	<!-- 프로필 버튼 + 드롭다운 -->
	<div class="profile-wrapper">
		<button class="icon-btn profile-btn" title="내 프로필" id="profileBtn">
			<i class="bi bi-person"></i>
		</button>

		<!-- 드롭다운 박스 -->
		<div class="profile-dropdown" id="profileDropdown">
			<div class="profile-box">
				<div class="profile-info">
					<img src="/upload_file/${sessionScope.logoFileId}"
						class="profile-icon-img" width="40px" height="40px">
					<p class="brand-name">${sessionScope.brandName != null ? sessionScope.brandName : '브랜드명'}</p>
				</div>

				<button class="btn btn-outline btn-sm profile-action-btn"
					onclick="location.href='/brand/brandEdit'">브랜드 정보 수정</button>

				<form action="/logout" method="post">
					<button type="submit" class="btn btn-danger btn-sm logout-btn">로그아웃</button>
				</form>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${not empty sessionScope.brandId}">
			<button class="btn btn-outline btn-sm"
				onclick="location.href='/store/brandDetail?brandId=${sessionScope.brandId}'">
				내 브랜드 스토어 보기</button>
		</c:when>
		<c:otherwise>
			<button class="btn btn-outline btn-sm"
				onclick="alert('브랜드 정보가 없습니다. 로그인 상태를 확인하세요.');">내 브랜드 스토어
				보기</button>
		</c:otherwise>
	</c:choose>
</div>
<script>
    const profileBtn = document.getElementById("profileBtn");
    const profileDropdown = document.getElementById("profileDropdown");

    profileBtn.addEventListener("click", (e) => {
        e.stopPropagation();
        profileDropdown.classList.toggle("active");
    });

    document.addEventListener("click", (e) => {
        if (!profileDropdown.contains(e.target) && e.target !== profileBtn) {
            profileDropdown.classList.remove("active");
        }
    });
</script>
