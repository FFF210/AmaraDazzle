<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- 
  속성 (Props)
  • recentList : 최근 본 상품 리스트 (List<ProductVO> 형태 가정)
    - ProductVO: brand, title, isSale, hasOption, originPrice, saleRate, finalPrice, tags
--%>
<%@ attribute name="recentList" required="true"%>

<%-- 전체 개수 계산 --%>
<c:set var="totalCount" value="${fn:length(recentList)}" />
<c:set var="pageSize" value="4" />
<c:set var="pageCount" value="${(totalCount + pageSize - 1) / pageSize}" />

<div id="recent-modal" class="recent-modal hidden">
  <div class="recent-overlay"></div>

  <div class="recent-content">
    <!-- 헤더 -->
    <div class="recent-header">
      <span class="recent-count">전체 ${totalCount}개</span>
      <button class="recent-clear">전체삭제</button>
    </div>

    <!-- 본문 -->
    <div class="recent-body">
      <div class="product-grid" id="recent-grid">
        <c:forEach var="p" items="${recentList}" varStatus="status">
          <c:if test="${status.index < pageSize}">
            <my:productCard 
              brand="테스트브랜드" 
              title="${p}" 
              isSale="true" 
              originPrice="10000" 
              saleRate="10" 
              finalPrice="9000">
              <my:tag color="red" size="sm" text="세일" />
            </my:productCard>
          </c:if>
        </c:forEach>
      </div>
    </div>

    <!-- 페이지네이션 -->
    <div class="recent-pagination" id="recent-pagination">
      <c:forEach var="i" begin="1" end="${pageCount}">
        <button class="page-btn ${i == 1 ? 'active' : ''}" data-page="${i}">${i}</button>
      </c:forEach>
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("recent-modal");
  const btn = document.getElementById("recent-btn");   // 헤더에서 최근 본 상품 버튼
  const overlay = document.querySelector(".recent-overlay");
  const clearBtn = document.querySelector(".recent-clear");

  // 열기
  if (btn) {
    btn.addEventListener("click", () => modal.classList.remove("hidden"));
  }

  // 배경 클릭 → 닫기
  if (overlay) {
    overlay.addEventListener("click", () => modal.classList.add("hidden"));
  }

  // 전체삭제
  if (clearBtn) {
    clearBtn.addEventListener("click", () => {
      document.getElementById("recent-grid").innerHTML = "";
      document.querySelector(".recent-count").textContent = "전체 0개";
      document.getElementById("recent-pagination").innerHTML = "";
    });
  }
});
</script>
