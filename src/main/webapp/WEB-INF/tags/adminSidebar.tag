<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>

<%-- ================================
     Sidebar 커스텀 태그
================================ --%>

<!-- 사이드바 -->
<nav class="sidebar collapsed" id="sidebar">
	<div>
		<div class="sidebar_header">
			<div class="logo">
				<div class="logo_img logo_collapsed" id="logoImg"></div>
				<!-- <img onclick="goMain();" /> -->
			</div>
			<div id="toggleBtn">
				<i class="bi bi-chevron-double-right"></i>
			</div>
		</div>
		<div class="menus">
			<div class="menu-item" data-menu="menu1">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-house-fill"></i>
					</div>
					<div class="menu-text">
						<a href="#">홈</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu2">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-house-fill"></i>
					</div>
					<div class="menu-text">
						<a href="#">오늘의 할 일</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu3">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-house-fill"></i>
					</div>
					<div class="menu-text">
						<a href="#">회원</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu4">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-house-fill"></i>
					</div>
					<div class="menu-text">
						<a href="#">일대일문의</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu5">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-person-fill"></i>
					</div>
					<div class="menu-text">게시판</div>
				</div>
				<div class="submenu">
					<div data-submenu="menu5_sub1" onclick="setHeader('프로필 > 정보수정')">
						<a href="#">신고글</a>
					</div>
					<div data-submenu="menu5_sub2" onclick="setHeader('프로필 > 비밀번호 변경')">
						<a href="#">공지</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu6">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-person-fill"></i>
					</div>
					<div class="menu-text">주문정산</div>
				</div>
				<div class="submenu">
					<div data-submenu="menu6_sub1" onclick="setHeader('프로필 > 정보수정')">
						<a href="#">주문내역</a>
					</div>
					<div data-submenu="menu6_sub2" onclick="setHeader('프로필 > 비밀번호 변경')">
						<a href="#">정산내역</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu7">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-person-fill"></i>
					</div>
					<div class="menu-text">프로모션</div>
				</div>
				<div class="submenu">
					<div data-submenu="menu7_sub1" onclick="setHeader('프로필 > 정보수정')">
						<a href="#">이벤트</a>
					</div>
					<div data-submenu="menu7_sub2" onclick="setHeader('프로필 > 비밀번호 변경')">
						<a href="#">메인배너</a>
					</div>
					<div data-submenu="menu7_sub3" onclick="setHeader('프로필 > 정보수정')">
						<a href="#">쿠폰</a>
					</div>
					<div data-submenu="menu7_sub4" onclick="setHeader('프로필 > 정보수정')">
						<a href="#">포인트</a>
					</div>
				</div>
			</div>

			<div class="menu-item" data-menu="menu8">
				<div class="menu-link">
					<div class="menu-icon">
						<i class="bi bi-person-fill"></i>
					</div>
					<div class="menu-text">설정</div>
				</div>
				<div class="submenu">
					<div data-submenu="menu8_sub1" onclick="setHeader('프로필 > 정보수정')">
						<a href="#">플랫폼설정</a>
					</div>
					<div data-submenu="menu8_sub2" onclick="setHeader('프로필 > 비밀번호 변경')">
						<a href="#">ㄴㄴㄴ</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="copyRight">
		ⓒ copyRight 2025. <br /> All rights reserved.
	</div>
</nav>
<!-- 사이드바 end -->


<script>
//사이드바 펼치기
const sidebar = document.getElementById("sidebar");
const logoImg = document.getElementById("logoImg");
const toggleBtn = document.getElementById("toggleBtn");
const footer = document.querySelector(".copyRight");

let isPinned = localStorage.getItem("sidebarPinned") === "true"; // 저장된 값 확인
//let isPinned = sessionStorage.getItem("sidebarPinned") === "true";

// 초기 상태 반영
if (isPinned) {
    sidebar.classList.remove("collapsed");
    logoImg.classList.remove("logo_collapsed");
    logoImg.classList.add("logo_expanded");
    toggleBtn.innerHTML = `<i class="bi bi-pin-angle-fill"></i>`;
    footer.innerHTML = `ⓒ copyRight 2025. <br> All rights reserved.`;
    footer.classList.add("expanded");
} else {
    sidebar.classList.add("collapsed");
    // toggleBtn.innerHTML = `<i class="bi bi-chevron-double-right"></i>`;
    toggleBtn.innerHTML = "";
    logoImg.classList.remove("logo_expanded");
    logoImg.classList.add("logo_collapsed");
    footer.innerHTML = `ⓒ2025`;
    footer.classList.remove("expanded");
}

// 마우스 올리면 사이드바 펼치기
sidebar.addEventListener("mouseenter", () => {
    //펼친상태 고정하지않은경우
    if (!isPinned) {
        sidebar.classList.remove("collapsed");
        logoImg.classList.remove("logo_collapsed");
        logoImg.classList.add("logo_expanded");
        toggleBtn.innerHTML = `<i class="bi bi-pin-angle"></i>`;
        footer.innerHTML = `ⓒ copyRight 2025. <br> All rights reserved.`;
        footer.classList.add("expanded");
    }
});

// 마우스 나가면 접기
sidebar.addEventListener("mouseleave", () => {
    //펼친상태 고정하지않은경우
    if (!isPinned) {
        sidebar.classList.add("collapsed");
        logoImg.classList.remove("logo_expanded");
        logoImg.classList.add("logo_collapsed");
        toggleBtn.innerHTML = "";
        footer.innerHTML = `ⓒ2025`;
        footer.classList.remove("expanded");
    }
});

// 핀 버튼 클릭 시 고정/해제
toggleBtn.addEventListener("click", () => {
    isPinned = !isPinned; // 상태 토글
    localStorage.setItem("sidebarPinned", isPinned); //펼친 상태 저장
    //	sessionStorage.setItem("sidebarPinned", isPinned); //펼친 상태 저장

    if (isPinned) {
        sidebar.classList.remove("collapsed");
        sidebar.classList.add("sidebarPinned");
        toggleBtn.innerHTML = `<i class="bi bi-pin-angle-fill"></i>`;
        footer.innerHTML = `ⓒ copyRight 2025. <br> All rights reserved.`;
        footer.classList.add("expanded");
    } else {
        sidebar.classList.add("collapsed");
        toggleBtn.innerHTML = `<i class="bi bi-chevron-double-right"></i>`;
        footer.innerHTML = `ⓒ2025`;
        footer.classList.remove("expanded");
    }
});

//사이드바 메뉴 클릭시 활성화
let lastClickedMenu = null; // 마지막으로 클릭한 대메뉴
let lastClickedSubItem = null; // 마지막으로 클릭한 서브메뉴 a

document.addEventListener("DOMContentLoaded", () => {
    if (!sidebar) {
        console.error("sidebar element (#sidebar) not found.");
        return;
    }
    const menuItems = document.querySelectorAll(".menu-item");

    // 디버깅: 요소 개수 확인 (콘솔에 몇 개 뜨는지 확인)
    console.log("menuItems count:", menuItems.length, "sidebar:", !!sidebar);

    menuItems.forEach((menu) => {
        const link = menu.querySelector(".menu-link");
        const submenu = menu.querySelector(".submenu");

        // 메뉴 전체(아이콘+텍스트+서브영역) hover
        menu.addEventListener("mouseenter", () => {
            // 다른 메뉴들의 hover/open 제거 (clicked active는 건드리지 않음)
            menuItems.forEach((m) => {
                if (m !== menu) {
                    m.classList.remove("hover", "open");
                }
            });

            // 현재 hover 메뉴만 강조
            menu.classList.add("hover");
            if (submenu) menu.classList.add("open");
        });

        // 메뉴 밖으로 나갈 때
        menu.addEventListener("mouseleave", () => {
            menu.classList.remove("hover");
            // 서브가 있고, 이 메뉴가 마지막 클릭한 메뉴가 아니면 닫음
            if (submenu && menu !== lastClickedMenu) menu.classList.remove("open");
        });

        // 서브영역에 마우스 들어오면 hover 유지
        if (submenu) {
            submenu.querySelectorAll("a").forEach((a) => {
                a.addEventListener("click", () => setActiveMenu(menu, a));
            });
        } else {
            link.addEventListener("click", () => setActiveMenu(menu, null));
        }
    });

    // 사이드바를 완전히 벗어나면 hover 제거하고 마지막 클릭 메뉴 복원
    sidebar.addEventListener("mouseleave", () => {
        menuItems.forEach((m) => m.classList.remove("hover", "open"));

        if (lastClickedMenu) {
            lastClickedMenu.classList.add("active", "open");
        }
        if (lastClickedSubItem) {
            lastClickedSubItem.classList.add("active"); // 클릭했던 서브메뉴만 강조
        }
    });

    // 메뉴 활성화 함수
    function setActiveMenu(menuEl, subEl) {
        console.log("Setting active menu:", menuEl);
        console.log("Setting active smenu:", subEl);

        // 모든 대메뉴/서브 a 초기화
        menuItems.forEach((m) => m.classList.remove("active", "open"));
        document.querySelectorAll(".submenu a").forEach((a) => a.classList.remove("active"));

        // 요소 그대로 저장
        lastClickedMenu = menuEl;
        lastClickedSubItem = subEl;

        // 클릭한 메뉴만 active 추가
        // 대메뉴 강조
        menuEl.classList.add("active", "open");

        // 서브메뉴 클릭 시 해당 a만 강조
        if (subEl) subEl.classList.add("active");

        //새고해도 메뉴 열린 채로 있도록 세션스토리지에 저장
        sessionStorage.setItem("openedMenu", menuEl.dataset.menu);
        sessionStorage.setItem("openedSubMenu", subEl ? subEl.parentElement.dataset.submenu : "");
    }
});

//로고 클릭시 메인 이동
function goMain() {
    location.href = "./main.html";
}

</script>
