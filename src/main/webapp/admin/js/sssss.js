input.addEventListener("change", () => {
	const file = input.files[0];
	if (!file) return;

	// 이미지 파일인지 확인
	if (!file.type.startsWith("image/")) {
		alert("이미지 파일만 업로드 가능합니다.");
		input.value = "";
		return;
	}

	const reader = new FileReader();
	reader.onload = e => {
		// 기존 placeholder 숨김
		placeholder.style.display = "none";

		// 미리보기 요소 생성
		const previewDiv = document.createElement("div");
		previewDiv.classList.add("image-preview");

		previewDiv.innerHTML = `
        <img src="${e.target.result}" alt="preview" style="max-width:100%;height:auto;border-radius:8px;"/>
        <button type="button" class="remove-btn" style="display:block;margin-top:5px;">&times;</button>
      `;

		wrapper.appendChild(previewDiv);

		// 삭제 버튼 클릭 시
		previewDiv.querySelector(".remove-btn").addEventListener("click", () => {
			input.value = "";
			previewDiv.remove();
			placeholder.style.display = "flex";
		});
	};

	reader.readAsDataURL(file);
});