<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>


<nav class="mypage-menu" aria-label="마이페이지">
  <h2 class="mypage-menu_title">마이페이지</h2>
  <section class="menu-groups">

  <!-- 그룹 1: 마이 쇼핑 -->
  <section class="menu-group">
    <h3 class="menu-group_title">마이 쇼핑</h3>
    <ul class="menu-list">
      <li><a class="menu-item ${currentMenu eq 'orders' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/orderList'/>">주문/배송 조회</a></li>
      <li><a class="menu-item ${currentMenu eq 'returns' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/history'/>">취소/반품/교환 내역</a></li>
      <li><a class="menu-item ${currentMenu eq 'cart' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/cart'/>">장바구니</a></li>
      <li><a class="menu-item ${currentMenu eq 'likes' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/like'/>">좋아요</a></li>
      <li><a class="menu-item ${currentMenu eq 'coupon' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/myCoupoint'/>">쿠폰/포인트</a></li>
    </ul>
  </section>

  <!-- 그룹 2: 마이 활동 -->
  <section class="menu-group">
    <h3 class="menu-group_title">마이 활동</h3>
    <ul class="menu-list">
      <li><a class="menu-item ${currentMenu eq 'tickets' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/tickets'/>">1:1 문의내역</a></li>
      <li><a class="menu-item ${currentMenu eq 'reviews' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/myReview'/>">리뷰</a></li>
    </ul>
  </section>

  <!-- 그룹 3: 마이 정보 -->
  <section class="menu-group">
    <h3 class="menu-group_title">마이 정보</h3>
    <ul class="menu-list">
      <li><a class="menu-item ${currentMenu eq 'profile' ? 'is-active' : ''}"
             href="<c:url value='/store/mypage/profile'/>">회원정보수정</a></li>
    </ul>
  </section>
  </section>
</nav>
