<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>포인트 지급</title>
<link rel="stylesheet" href="./css/boards_write.css?v=1" />
<link rel="stylesheet" href="./css/coupon.css?v=1" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<%@ include file="./main_content/promotion_point_write_content.jsp"%>
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- 정보수정 & 로그아웃 팝업 -->
	<%@ include file="../modals/login_popup.jsp"%>
	<!-- 정보수정 & 로그아웃 팝업 end -->


	<!-- JS부분 -->
	<%@ include file="../js/admin/common/adminHeader.js"%>
	<!-- JS부분 end -->

</body>
</html>