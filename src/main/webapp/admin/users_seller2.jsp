<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>Users 사업자회원</title>
<link rel="stylesheet" href="../css/admin/user_seller.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:layout>
		<%@ include file="./main_content/users_seller_content.jsp"%>
	</my:layout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- 정보수정 & 로그아웃 팝업 -->
	<%@ include file="../modals/login_popup.jsp"%>
	<!-- 정보수정 & 로그아웃 팝업 end -->


	<!-- JS부분 -->
	<!-- JS부분 end -->

</body>
</html>