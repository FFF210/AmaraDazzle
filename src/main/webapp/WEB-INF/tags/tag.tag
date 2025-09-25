<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
     Tag 커스텀 태그
     
     속성(Props)
     • color : yellow | green | blue | red | gray (기본값 green)
     • size  : sm | md | lg (기본값 md)
     • text  : 태그 안에 표시할 문자열 (기본값 label)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:tag 
       color="green" 
       size="md" 
       text="세일" />
================================ --%>

<%@ attribute name="color" required="false"%>
<%@ attribute name="size" required="false"%>
<%@ attribute name="text" required="false"%>

<c:set var="color" value="${empty color ? 'green' : color}" />
<c:set var="size" value="${empty size ? 'md' : size}" />
<c:set var="text" value="${empty text ? 'label' : text}" />

<span class="tag ${color} ${size}"> ${text} </span>
