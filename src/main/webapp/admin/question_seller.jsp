<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp" %>

<title>일대일문의 사업자회원</title>
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<%@ include file="./main_content/question_seller_content.jsp"%>
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