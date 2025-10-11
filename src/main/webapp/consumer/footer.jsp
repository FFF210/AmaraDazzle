<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<footer class="site-footer" role="contentinfo">
	<div class="footer-inner">
		<!-- 왼쪽: 로고 -->
		<div class="footer-col footer-brand">
			<a href="<c:url value='/'/>" class="footer-logo" aria-label="홈">
				<img src="<c:url value='/image/logo_black_sidelower.svg'/>"
				alt="AD ADARA DAZZLE">
			</a>
		</div>

		<!-- 가운데: 사업자 정보 -->
		<div class="footer-wrapper">
			<div class="footer-container">
				<div class="footer-col footer-company">
					<h2 class="ft-title">AmaraDazzle</h2>
					<ul class="company-list">
						<li>대표이사: 홍길동 | 사업자등록번호: 809-81-01574</li>
						<li>주소: (04323) 서울특별시 용산구 한강대로 372, 24층 (동자동, KDB타워)</li>
						<li>이메일: oliveweb@cj.net</li>
					</ul>
				</div>

				<!-- 오른쪽: 링크 -->
				<div class="footer-col footer-links">
					<h2 class="ft-title links">
						<a href="<c:url value='/brand/login'/>">입점문의</a>
					</h2>
					<ul class="link-list">
						<li>이용약관법적고지</li>
						<li>개인정보처리방침</li>
						<li>청소년보호방침</li>
						<li>이메일무단수집거부</li>
					</ul>
				</div>
			</div>

			<!-- 하단 고지 문구 -->
			<div class="footer-notice">
				이 페이지에서 판매되는 상품 중에는 입점한 개별 판매자가 판매하는
				상품이 포함되어 있습니다. 개별 판매자의 판매 상품의 경우, 통신판매중개자로서 본 쇼핑몰은 당사자가 아니며 판매자가 등록한
				상품정보 및 거래 등에 대하여 책임을 부담하지 않습니다.
			</div>
		</div>
	</div>
</footer>