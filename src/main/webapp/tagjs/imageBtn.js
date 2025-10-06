document.addEventListener("DOMContentLoaded", () => {
	document.querySelectorAll(".image-button").forEach(wrapper => {
		const input = wrapper.querySelector("input[type='file']");
		const placeholder = wrapper.querySelector(".image-placeholder");

		input.addEventListener("change", () => {
			const file = input.files[0];
			if (!file) return;

			if (!file.type.startsWith("image/")) {
				alert("이미지 파일만 업로드 가능합니다.");
				input.value = "";
				return;
			}

			const reader = new FileReader();
			reader.addEventListener("load", e => {
				placeholder.style.display = "none";

				let previewDiv = wrapper.querySelector(".image-preview");
				if (previewDiv) previewDiv.remove();

				previewDiv = document.createElement("div");
				previewDiv.classList.add("image-preview");

				previewDiv.innerHTML = `
          <img src="${e.target.result}" alt="preview" style="max-width:100%;height:auto;border-radius:8px;"/>
          <button type="button" class="remove-btn" style="display:block;margin-top:5px;">&times;</button>
        `;

				wrapper.appendChild(previewDiv);

				previewDiv.querySelector(".remove-btn").addEventListener("click", () => {
					input.value = "";
					previewDiv.remove();
					placeholder.style.display = "flex";
				});
			});

			reader.readAsDataURL(file);
		});
	});
});
