<%@ tag description="파일 업로더" pageEncoding="UTF-8"%>
<%@ attribute name="size" required="false"%> <!-- lg / md / sm -->
<%@ attribute name="id" required="false"%> <!-- file input id -->
<%@ attribute name="name" required="false"%> <!-- file input name -->
<%@ attribute name="label" required="false"%> <!-- 상단 문구 (기본: Click to upload) -->
<%@ attribute name="desc" required="false"%> <!-- 하단 문구 (기본: 또는 파일을 이 영역으로 드래그하세요) -->
<%@ attribute name="multiple" required="false"%>

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

<div class="fileAttatch">
	<div id="fileDropper" class="uploader uploader-${size}" 
			tabindex="0" role="button" aria-label="파일 업로드 영역">
		<div class="hint">
			<div class="uploader-title">${empty label ? "Click to upload" : label}</div>
			<div class="uploader-muted">${empty desc ? "또는 파일을 이 영역으로 드래그하세요" : desc}</div>
		</div>
	</div>
	<input id="fileInput" type="file" name="${name}" class="sr-only" style="display: none" multiple="${empty multiple? 'multiple' : ''}"  />

	<div id="imgPreviewWrapper" class="preview-wrapper hidden">
		<div id="imgPreviewArea" class="preview-area" aria-live="polite"></div>
	</div>
	<div id="docPreviewWrapper" class="preview-wrapper hidden">
		<div id="docPreviewArea" class="preview-area" aria-live="polite"></div>
	</div>
</div>
<script>
(function() {
	const dropper = document.getElementById("fileDropper");
	const input = document.getElementById("fileInput");
	const preview = document.getElementById("imgPreviewArea");
	const preview2 = document.getElementById("docPreviewArea");

	let previews = [];
	let previews2 = [];
	let idSeq = 0;
	
// ------------------ 공통 처리 ------------------
	//파일 미리보기 추가
	function addFiles(files) {
		const MAX = 5;

	    // 현재 미리보기 개수
	    const current = previews.length;
	    const incoming = files.length;
	    const remain = MAX - current;
	
	    // 이미 5개 이상 첨부된 경우
	    if (current >= MAX) {
	        alert(`최대 ${MAX}개까지만 첨부할 수 있습니다.`);
	        return;
	    }
	
	    // 이번에 추가하려는 파일이 남은 개수보다 많을 때
	    if (incoming > remain) {
	        alert(`최대 ${MAX}개까지만 첨부할 수 있습니다.`);
	    }
	
	    // 남은 개수만큼만 추가
	    Array.from(files)
	        .slice(0, remain)
	        .forEach((file) => {
	            const url = URL.createObjectURL(file);
	            previews.push({ id: idSeq++, url, file });
	        });
	
	    render();
	}

	//미리보기 삭제
	function removePreview(id) {
	    const idx = previews.findIndex((p) => p.id === id);
	    if (idx > -1) {
	        // 미리보기 제거
	        URL.revokeObjectURL(previews[idx].url);
	        previews.splice(idx, 1);
	
	        //FileList 재구성
	        const dt = new DataTransfer(); // 새로운 가상의 드래그 데이터
	        previews.forEach(p => dt.items.add(p.file)); // 남아 있는 파일만 추가
	        input.files = dt.files; // input.files 교체
	
	        render();
	    }
	}
	
	//미리보기 렌더링
	const imgWrapper = document.getElementById("imgPreviewWrapper");
	const docWrapper = document.getElementById("docPreviewWrapper");
	
	function render() {
	    preview.innerHTML = "";
	
	    // 첨부 파일이 있으면 wrapper 보이기, 없으면 숨기기
	    if (previews.length > 0) {
	    	imgWrapper.classList.remove("hidden");
	    } else {
	    	imgWrapper.classList.add("hidden");
	    }
	
	    previews.forEach((p) => {
	        const card = document.createElement("div");
	        card.className = "preview-card";
	
	        const img = document.createElement("img");
	        img.className = "preview-thumb";
	        img.src = p.url;
	        img.alt = p.file.name;
	
	        const btn = document.createElement("button");
	        btn.type = "button";
	        btn.className = "remove-btn";
	        btn.title = "파일첨부 삭제";
	        btn.innerHTML = '<i class="bi bi-x"></i>';
	        btn.addEventListener("click", () => removePreview(p.id));
	
	        card.append(img, btn);
	        preview.appendChild(card);
	    });
	}
	
// ------------------ 클릭으로 파일 선택 ------------------
	dropper.addEventListener("click", () => {
		input.value = "";
		input.click();
	});
// 		dropper.addEventListener("keydown", (e) => {
// 			if (e.key === "Enter" || e.key === " ") {
// 				e.preventDefault();
// 				input.click();
// 			}
// 		});
	input.addEventListener("change", (e) => {
		if (e.target.files.length) addFiles(e.target.files);
	});
	
// ------------------ 드래그앤드롭 ------------------
	dropper.addEventListener("dragenter", (e) => {
		e.preventDefault();
		dropper.classList.add("dragover");
	});
	
	dropper.addEventListener("dragover", (e) => {
		e.preventDefault(); //기본 파일 열기 방지
	});
	
	dropper.addEventListener("dragleave", (e) => {
		if (e.target === dropper) dropper.classList.remove("dragover");
	});
	
	dropper.addEventListener("drop", (e) => {
		e.preventDefault();
		dropper.classList.remove("dragover");
		if (e.dataTransfer.files.length) addFiles(e.dataTransfer.files);
	});
	
})();
</script>