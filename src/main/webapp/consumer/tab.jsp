<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- ================================
Tab 컴포넌트

속성(Props)
• tabs: 탭 목록 (배열) - 예: ["탭1", "탭2", "탭3"]
• activeTab: 현재 활성화된 탭 인덱스 (0부터 시작)
• tabId: 탭 그룹의 고유 ID

사용법 예시
<c:import url="/tab.jsp">
    <c:param name="tabs" value="스킨케어,메이크업,헤어케어,바디케어" />
    <c:param name="activeTab" value="0" />
    <c:param name="tabId" value="categoryTabs" />
</c:import>
================================ --%>

<%-- 파라미터 기본값 처리 --%>
<c:set var="tabList" value="${fn:split(param.tabs, ',')}" />
<c:set var="activeTab" value="${param.activeTab != null ? param.activeTab : 0}" />
<c:set var="tabId" value="${param.tabId != null ? param.tabId : 'defaultTabs'}" />

<%-- JSTL functions 사용을 위한 taglib 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="tab-container" id="${tabId}">
    <c:forEach var="tab" items="${tabList}" varStatus="status">
        <button class="tab-item ${status.index == activeTab ? 'active' : ''}" 
                onclick="selectTab('${tabId}', ${status.index})"
                data-tab-index="${status.index}">
            <c:out value="${tab}" />
        </button>
    </c:forEach>
</div>