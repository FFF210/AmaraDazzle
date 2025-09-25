<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- //JSP 처리 로직// 
<%
    // 세션에서 로그인 사용자 정보 가져오기
    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
    
    // 로그인된 사용자의 장바구니 개수 조회
    int cartCount = 0;
    if (loginUser != null) {
        // MyBatis를 통한 장바구니 개수 조회
        cartCount = cartService.getCartCount(loginUser.getId());
    }
    
    request.setAttribute("loginUser", loginUser);
    request.setAttribute("cartCount", cartCount);
%>--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AMARA DAZZLE</title>
    <link rel="stylesheet" href="<c:url value='/css/header.css'/>">
    <!-- search 돋보기 아이콘 cdn 방식 -->
    <link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>
    <div class="header-background">
    <header class="header">
        <!-- 상단 영역 -->
        <div class="header-top">
            <!-- 검색 영역 -->
            <div class="search-area">
                <button class="search-btn" aria-label="검색">                   
                     <i class="bi bi-search" aria-hidden="true"></i>
                     </button>
                <form action="<c:url value='/productList'/>" method="get" style="display:flex;width:100%;">
                    <!-- 숨김 라벨 -->
                    <label for="keyword" class="sr-only">검색어</label>
                    <input id="keyword"
                     type="text"
                     name="keyword"
                     class="search-input"
                     placeholder="상품, 브랜드 검색"
                     value="${param.keyword}">                  
                </form>
            </div>
            
            <!-- 로고 -->
            <div class="logo">
                 <a href="<c:url value='/'/>">
                 <img src="<c:url value='/images/logo_black.svg'/>" alt="AD 로고">
                 </a>
            </div>
            
            <!-- 사용자 메뉴 -->
            <div class="user-shortcut">
                <c:choose>
                    <c:when test="${not empty loginUser}">
                        <!-- 로그인 상태 -->
                        <span class="username">${loginUser.name}님</span>
                        <a href="<c:url value='/store/logout'/>">로그아웃</a>
                        
                        <!-- 장바구니 (배지 포함) -->
                        <a href="<c:url value='/store/cart'/>" class="cart-link">
                         장바구니
                         <c:if test="${cartCount > 0}">
                           <span class="cart-count">${cartCount}</span>
                         </c:if>
                        </a>                      
                    </c:when>
                    <c:otherwise>
                        <!-- 비로그인 상태 -->
                        <a href="<c:url value='/store/join'/>">회원가입</a>
                        <a href="<c:url value='/store/login'/>">로그인</a>
                         <a href="<c:url value='/store/cart'/>" class="cart-link">장바구니</a>
                    </c:otherwise>
                </c:choose>
                
                 <!-- ✅ 최근 본 상품: 링크가 아니라 토글 버튼 -->
                 <button type="button" class="recent-toggle" aria-controls="recent-drawer" aria-expanded="false">
                  최근 본 상품
                 </button>
                </div>
              </div>
                
        
        <!-- 네비게이션 영역 -->
        <nav class="header-nav">
            <div class="nav-container">
                <!-- 메인 카테고리 -->
                <ul class="main-nav">
                    <li><a href="<c:url value='/productList?categoryId=1'/>">스킨케어</a></li>
                    <li><a href="<c:url value='/productList?categoryId=2'/>">메이크업</a></li>
                    <li><a href="<c:url value='/productList?categoryId=3'/>">헤어케어</a></li>
                    <li><a href="<c:url value='/productList?categoryId=4'/>">바디케어</a></li>
                    <li><a href="<c:url value='/productList?categoryId=5'/>">향수</a></li>
                    <li><a href="<c:url value='/productList?categoryId=6'/>">맨즈케어</a></li>
                </ul>
                
                <!-- 서브 메뉴 -->
                <ul class="sub-nav">
                    <li><a href="<c:url value='/productList?ranking=true'/>">랭킹</a></li>
                    <li><a href="<c:url value='/productList?sale=true'/>">세일</a></li>
                    <li><a href="<c:url value='/store/'/>">기획</a></li>
                    <li><a href="<c:url value='/store/event'/>">이벤트</a></li>
                    <li><a href="<c:url value='/store/coupon'/>">쿠폰</a></li>
                </ul>
            </div>
        </nav>
        
         <!-- ✅ 최근 본 상품 드로어 -->
         <div id="recent-overlay" class="recent-overlay" hidden></div>

       <section id="recent-drawer" class="recent-drawer" aria-hidden="true" >
          <div class="drawer-head">
           <strong>최근 본 상품<span id="recent-count"></span></strong>
           <div class="actions">
             <button id="recent-clear" type="button" class="link-btn">전체 삭제</button>
             <button id="recent-close" type="button" class="close-btn" aria-label="닫기">×</button>
           </div>
        </div>
        <div id="recent-grid" class="recent-grid">JS가 카드 렌더링</div>
       </section> 
              
  </header>
</div>
    
<script>
// 검색 기능 향상 - 엔터로 제출
document.querySelector('.search-input').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        this.closest('form').submit();
    }
});

//===== 최근 본 상품 드로어 =====
const BASE = '<c:url value="/"/>';          // 컨텍스트 패스 안전하게
const KEY  = 'recentProductIds';
const MAX  = 20;

const btnToggle = document.querySelector('.recent-toggle');
const drawer    = document.getElementById('recent-drawer');
const overlay   = document.getElementById('recent-overlay');
const grid      = document.getElementById('recent-grid');
const countEl   = document.getElementById('recent-count');
const btnClose  = document.getElementById('recent-close');
const btnClear  = document.getElementById('recent-clear');

function openDrawer(){
	 drawer.classList.add('open');
	  drawer.setAttribute('aria-hidden','false');
	  overlay.classList.add('show');
	  renderRecent(); // ← 여기서 목록 렌더
}
function closeDrawer(){
//   drawer.classList.remove('open');
//   drawer.setAttribute('aria-hidden','true');
//   drawer.style.display = "none";  
//   overlay.setAttribute('hidden','');
	drawer.classList.remove('open');
	  drawer.setAttribute('aria-hidden','true');
	  overlay.classList.remove('show');
}

btnToggle?.addEventListener('click', () => {
  drawer.classList.contains('open') ? closeDrawer() : openDrawer();
});
btnClose?.addEventListener('click', closeDrawer);
overlay?.addEventListener('click', closeDrawer);
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeDrawer(); });

function getIds(){
  try { return JSON.parse(localStorage.getItem(KEY) || '[]'); }
  catch { return []; }
}
function setIds(ids){ localStorage.setItem(KEY, JSON.stringify(ids)); }

btnClear?.addEventListener('click', () => { setIds([]); renderRecent(); });

function renderRecent(){
  const ids = getIds().slice(0, 20);
  countEl.textContent = ids.length ? `(${ids.length})` : '';
  if (!ids.length){
    grid.innerHTML = '<div class="empty">최근 본 상품이 없습니다.</div>';
    return;
  }

  // 1) API 없을 때: 임시 카드(링크만)
  grid.innerHTML = ids.map(id => `
    <a class="card" href="${BASE}productDetail?id=${id}">
      <div class="thumb"><img src="${BASE}images/placeholder.png" alt="상품 #${id}"></div>
      <div class="name">상품 #${id}</div>
    </a>`).join('');

  // 2) API 있으면 이걸로 교체
  // fetch(`${BASE}api/products/mini?ids=${ids.join(',')}`)
  //   .then(r => r.json())
  //   .then(list => {
  //     grid.innerHTML = list.map(it => `
  //       <a class="card" href="${BASE}productDetail?id=${it.id}">
  //         <div class="thumb"><img src="${it.thumbUrl}" alt="${it.name}"></div>
  //         <div class="name">${it.name}</div>
  //         <div class="price">${it.priceFormatted}</div>
  //       </a>`).join('');
  //   });
}

// 장바구니 개수 업데이트 함수 (다른 페이지에서 호출 가능)
function updateCartCount() {
    <c:if test="${not empty loginUser}">
    fetch('/api/cart/count')
        .then(response => response.json())
        .then(data => {
            const countElement = document.querySelector('.cart-count');
            if (data.count > 0) {
                if (countElement) {
                    countElement.textContent = data.count;
                } else {
                    // 카운트 엘리먼트가 없으면 생성
                    const cartLink = document.querySelector('.cart-link');
                    const countSpan = document.createElement('span');
                    countSpan.className = 'cart-count';
                    countSpan.textContent = data.count;
                    cartLink.appendChild(countSpan);
                }
            } else if (countElement) {
                countElement.remove();
            }
        });
    </c:if>
}
</script>