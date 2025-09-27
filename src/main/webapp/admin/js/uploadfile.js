(function() {
	const dropper = document.getElementById("fileDropper");
	const input = document.getElementById("fileInput");
	const preview = document.getElementById("previewArea");

	let previews = [];
	let idSeq = 0;

// ------------------ 공통 처리 ------------------
	//미리보기 파일 추가
	function addFiles(files) {
		Array.from(files).forEach((file) => {
//			if (!file.type.startsWith("image/")) return alert("이미지 파일만 선택 가능");
			const url = URL.createObjectURL(file);
			previews.push({ id: idSeq++, url, file });
		});
		render();
	}

	//미리보기 삭제
	function removePreview(id) {
		const idx = previews.findIndex((p) => p.id === id);
		if (idx > -1) {
			URL.revokeObjectURL(previews[idx].url);
			previews.splice(idx, 1);
			render();
		}
	}

	function render() {
		preview.innerHTML = "";
		previews.forEach((p) => {
			const card = document.createElement("div");
			card.className = "preview-card";

			const img = document.createElement("img");
			img.className = "preview-thumb";
			img.src = p.url;
			img.alt = p.file.name;

			const meta = document.createElement("div");
			meta.className = "preview-meta";
			meta.innerHTML = `<div><strong>${escapeHtml(p.file.name)}</strong></div>
	          <div>${formatBytes(p.file.size)}</div>`;

			const btn = document.createElement("button");
			btn.type = "button";
			btn.className = "remove-btn";
			btn.textContent = `<i class="bi bi-x"></i>`;
			btn.addEventListener("click", () => removePreview(p.id));

			card.append(img, meta, btn);
			preview.appendChild(card);
		});
	}

	// ------------------ 클릭으로 파일 선택 ------------------
	dropper.addEventListener("click", () => {
		input.value = "";
		input.click();
	});
	dropper.addEventListener("keydown", (e) => {
		if (e.key === "Enter" || e.key === " ") {
			e.preventDefault();
			input.click();
		}
	});
	input.addEventListener("change", (e) => {
		if (e.target.files.length) addFiles(e.target.files);
	});

	// ------------------ 드래그앤드롭 ------------------
	dropper.addEventListener("dragenter", (e) => {
		e.preventDefault();
		dropper.classList.add("dragover");
	});
	dropper.addEventListener("dragover", (e) => {
		e.preventDefault(); // 중요: 기본 파일 열기 방지
	});
	dropper.addEventListener("dragleave", (e) => {
		if (e.target === dropper) dropper.classList.remove("dragover");
	});
	dropper.addEventListener("drop", (e) => {
		e.preventDefault();
		dropper.classList.remove("dragover");
		if (e.dataTransfer.files.length) addFiles(e.dataTransfer.files);
	});

	// ------------------ 유틸 ------------------
	function formatBytes(b) {
		if (b < 1024) return b + " B";
		const u = ["KB", "MB", "GB"];
		let i = -1;
		do {
			b /= 1024;
			i++;
		} while (b >= 1024 && i < u.length - 1);
		return b.toFixed(i ? 1 : 0) + " " + u[i];
	}
	function escapeHtml(s) {
		return s.replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
	}
})();