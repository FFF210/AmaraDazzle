<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>ADMIN - 공지게시판</title>

<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<%@ include file="./main_content/notice_platform_content.jsp"%>
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->



	<!-- JS부분 -->
	<!-- JS부분 end -->

</body>
</html>