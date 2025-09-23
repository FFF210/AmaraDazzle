<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>

<%-- ================================
     Header 커스텀 태그
================================ --%>

<header class="header">
    <button class="icon-btn" title="알림">
        <i class="bi bi-bell"></i>
    </button>
    <button class="icon-btn" title="내 프로필">
        <i class="bi bi-person"></i>
    </button>
    <div class="header_button">
        <button type="button" onclick="">사이트 바로가기</button>
    </div>
</header>
<!-- 헤더부분 end -->



<script>
const logInfo = document.querySelector("header .icon-btn .bi-person");
const modal = document.querySelector(".modal.loginInfo");

// 마우스 올리면 펼치기
logInfo.addEventListener("click", () => {
    if (modal.style.display === "flex") {
        modal.style.display = "none";
        return;
    }
    modal.style.display = "flex";
    modal.style.position = "fixed";
});

</script>

