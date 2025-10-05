<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="admin-header">
    <button class="icon-btn" title="알림">
        <i class="bi bi-bell"></i>
    </button>

    <button class="icon-btn" title="내 프로필">
        <i class="bi bi-person"></i>
    </button>

    <c:choose>
        <c:when test="${not empty sessionScope.brandId}">
            <button class="btn btn-outline btn-sm"
                onclick="location.href='/store/brandDetail?brandId=${sessionScope.brandId}'">
                내 브랜드 스토어 보기
            </button>
        </c:when>
        <c:otherwise>
            <button class="btn btn-outline btn-sm"
                onclick="alert('브랜드 정보가 없습니다. 로그인 상태를 확인하세요.');">
                내 브랜드 스토어 보기
            </button>
        </c:otherwise>
    </c:choose>
</div>
