<%@ tag description="파일 업로더" pageEncoding="UTF-8"%>
<%@ attribute name="size" required="true" %> <!-- lg / md / sm -->
<%@ attribute name="id" required="true" %>   <!-- file input id -->
<%@ attribute name="label" required="false" %> <!-- 상단 문구 (기본: Click to upload) -->
<%@ attribute name="desc" required="false" %>  <!-- 하단 문구 (기본: 또는 파일을 이 영역으로 드래그하세요) -->

<%-- ================================
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<link rel="stylesheet" href="./css/uploader.css" />

<!-- 대형 업로더 -->
<my:uploader size="lg" id="fileInput1" label="Click to upload" desc="또는 파일을 이 영역으로 드래그하세요"/>

<!-- 중형 업로더 -->
<my:uploader size="md" id="fileInput2"/>

<!-- 소형 업로더 -->
<my:uploader size="sm" id="fileInput3"/>
================================ --%>


<div class="uploader uploader-${size}" tabindex="0" role="button" aria-label="파일 업로드 영역">
  <div>
    <div class="uploader-title">${empty label ? "Click to upload" : label}</div>
    <div class="uploader-muted">${empty desc ? "또는 파일을 이 영역으로 드래그하세요" : desc}</div>
  </div>
  <input id="${id}" class="sr-only" type="file" multiple />
</div>