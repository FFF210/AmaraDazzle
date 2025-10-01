<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>

<%-- ================================
     CategoryFilter 커스텀 태그 (3단계 동적)
     Props:
       • selectedLarge  : 현재 선택된 대분류 ID
       • selectedMiddle : 현재 선택된 중분류 ID
       • selectedSmall  : 현재 선택된 소분류 ID
================================ --%>

<%@ attribute name="selectedLarge" required="false" %>
<%@ attribute name="selectedMiddle" required="false" %>
<%@ attribute name="selectedSmall" required="false" %>

<div id="category-filter"
     data-selected-large="${selectedLarge}"
     data-selected-middle="${selectedMiddle}"
     data-selected-small="${selectedSmall}">
  <!-- JS가 카테고리 목록을 채움 -->
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("category-filter");
  const selectedLarge = container.dataset.selectedLarge;
  const selectedMiddle = container.dataset.selectedMiddle;
  const selectedSmall = container.dataset.selectedSmall;

  // 카테고리 목록 불러오기
  function loadCategories(type, parentId = null, selectedId = null) {
    let url = "<c:url value='/category'/>?type=" + type;
    if (parentId) url += "&parentId=" + parentId;

    fetch(url)
      .then(res => res.json())
      .then(data => {
        container.innerHTML = ""; // 초기화

        // "전체" 버튼
        const allBtn = document.createElement("button");
        allBtn.className = "category-item";
        allBtn.textContent = "전체";
        allBtn.dataset.categoryid = "";
        if (!selectedId) allBtn.classList.add("selected");
        container.appendChild(allBtn);

        // 카테고리 버튼
        data.forEach(cat => {
          const btn = document.createElement("button");
          btn.className = "category-item";
          btn.textContent = cat.name;
          btn.dataset.categoryid = cat.categoryId;
          if (selectedId && selectedId == cat.categoryId) {
            btn.classList.add("selected");
          }
          container.appendChild(btn);
        });

        // 클릭 이벤트 바인딩
        container.querySelectorAll(".category-item").forEach(btn => {
          btn.addEventListener("click", () => {
            const cid = btn.dataset.categoryid || "";
            if (type === "large") {
              if (cid) {
                // 중분류 불러오기
                loadCategories("middle", cid, selectedMiddle);
                updateUrl("category1Id", cid);
              } else {
                updateUrl("category1Id", null);
              }
            } else if (type === "middle") {
              if (cid) {
                // 소분류 불러오기
                loadCategories("small", cid, selectedSmall);
                updateUrl("category2Id", cid);
              } else {
                updateUrl("category2Id", null);
              }
            } else if (type === "small") {
              if (cid) {
                updateUrl("category3Id", cid);
              } else {
                updateUrl("category3Id", null);
              }
            }
          });
        });
      })
      .catch(err => console.error("카테고리 불러오기 실패:", err));
  }

  // URL 갱신 후 페이지 이동
  function updateUrl(paramName, value) {
    const url = new URL(window.location.href);
    url.searchParams.set("page", 1);
    if (value) {
      url.searchParams.set(paramName, value);
    } else {
      url.searchParams.delete(paramName);
    }
    location.href = url.toString();
  }

  // 초기: 대분류 목록 불러오기
  loadCategories("large", null, selectedLarge);
});
</script>
