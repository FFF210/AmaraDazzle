<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
    ImageButton 커스텀 태그

    동작
    • 기본 상태: + 아이콘
    • 클릭 → 파일 선택 → 이미지 미리보기
    • X 버튼 클릭 → 초기화
    
    속성
    • name : input name (필수)
    • id   : input id (기본 name)
    • value : 기존 이미지 경로 (수정 모드 시 미리보기)

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <!-- 대표 이미지 -->
	<my:imageBtn name="thumbnail" value="${product.thumbPath}/${product.thumbFile}" />

	<!-- 추가 이미지 -->
	<my:imageBtn name="image1" value="${product.image1Path}/${product.image1File}" />
	<my:imageBtn name="image2" value="${product.image2Path}/${product.image2File}" />
================================ --%>

<%@ attribute name="name" required="true"%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="value" required="false"%>

<c:set var="id" value="${empty id ? name : id}" />

<div class="image-button" id="wrapper-${id}">
	<input type="file" id="${id}" name="${name}" accept="image/*" hidden />

	<c:choose>
		<c:when test="${not empty value}">
			<%-- 기존 이미지가 있으면 미리보기 상태로 보여줌 --%>
			<div class="image-preview">
				<img src="${value}" alt="preview" />
				<button type="button" class="remove-btn">&times;</button>
			</div>
		</c:when>
		<c:otherwise>
			<%-- 신규 업로드 상태 --%>
			<label for="${id}" class="image-placeholder">
				<span class="plus">＋</span>
			</label>
		</c:otherwise>
	</c:choose>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const wrapper = document.getElementById("wrapper-${id}");
    const input = wrapper.querySelector("input[type='file']");

    // 파일 선택 → 미리보기
    input.addEventListener("change", () => {
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = e => {
          wrapper.innerHTML = `
            <input type="file" id="${id}" name="${name}" accept="image/*" hidden />
            <div class="image-preview">
              <img src="${e.target.result}" alt="preview" />
              <button type="button" class="remove-btn">&times;</button>
            </div>
          `;
          addRemoveHandler(wrapper);
        };
        reader.readAsDataURL(input.files[0]);
      }
    });

    // 초기 remove-btn 이벤트 바인딩 (수정모드 미리보기 포함)
    addRemoveHandler(wrapper);

    function addRemoveHandler(wrapper) {
      const btn = wrapper.querySelector(".remove-btn");
      const input = wrapper.querySelector("input[type='file']");
      if(btn){
        btn.addEventListener("click", () => {
          wrapper.innerHTML = `
            <input type="file" id="${id}" name="${name}" accept="image/*" hidden />
            <label for="${id}" class="image-placeholder">
              <span class="plus">＋</span>
            </label>
          `;
        });
      }
    }
  });
</script>
