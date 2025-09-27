<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>공지 내용보기</title>

<link rel="stylesheet" href="../tagcss/tag.css?v=2" />
<link rel="stylesheet" href="./css/myApplications.css?v=2" />
<link rel="stylesheet" href="./css/boards_detailview.css?v=2" />

<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<%@ include file="./main_content/notice_detail_content.jsp"%>
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- 정보수정 & 로그아웃 팝업 -->
	<%@ include file="./modals/login_popup.jsp"%>
	<!-- 정보수정 & 로그아웃 팝업 end -->


</body>
</html>