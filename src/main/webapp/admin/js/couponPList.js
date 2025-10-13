//개별지급목록 페이지로 이동 
function goIndiCpList() {
	location.href = "/admin/couponIndiList";
};

//쿠폰 발행 버튼 클릭시 발행 페이지로 이동 
function cpPublBtn() {
	location.href = "/admin/couponPublWrite";
};

//쿠폰 상세보기 버튼 클릭시 
function goPcpDetail(num) {
	location.href = "/admin/couponPublDetail?num=" + num;
};

document.addEventListener("DOMContentLoaded", function() {
	// 라디오버튼 변경 시 쿠폰정보 세팅
	document.querySelectorAll('input[name="pCouponRdo"]').forEach(radio => {
		radio.addEventListener('change', function() {
			const cpId = this.value;
			const cname = this.dataset.cname;
			const amount = this.dataset.amount;
			const start = this.dataset.start;
			const end = this.dataset.end;
			const provision = this.dataset.provision;
			const reason = this.dataset.reason;
			
			document.querySelector('#modalCouponId').value = cpId;
			document.querySelector('#modalCouponName').value = cname;
			document.querySelector('#modalCouponAmount').value = amount;
			document.querySelector('#modalCouponStart').value = start;
			document.querySelector('#modalCouponEnd').value = end;
			document.querySelector('#modalCouponReason').value = reason;
			
			if(provision == "ALL") {
				document.querySelector('#modalCouponProvision').value = "모든회원"
			} else if(provision == "NORMAL") {
				document.querySelector('#modalCouponProvision').value = "일반"
			} else if (provision == "INDIVIDUAL") {
				document.querySelector('#modalCouponProvision').value = "개별회원"
			} else {
				document.querySelector('#modalCouponProvision').value = provision;
			}

			// 지급방식에 따라 "지급대상" 영역 표시/숨김
			const individualSection = document.querySelector('#indiCpModal .individual-only');
			if (provision === 'INDIVIDUAL') {
				individualSection.style.display = 'block';
			} else {
				individualSection.style.display = 'none';
			}
		});
	});
	
	//ajax 전송
	const sendAjax = (data) => {
		return fetch("/admin/couponProvision", {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded" },
			body: new URLSearchParams(data)
		}).then(res => res.json());
	};
	const dialogHandlers = {
		indiCpModal: {
			전송: async () => {
				// indiCpModal 전송 버튼 클릭 시에는 Ajax 전송하지 않고,
				// 확인 모달(submitCkDialog)만 띄운다
				openDialog("submitCkDialog", {
					title: "이대로 지급하시겠습니까?",
					message: "지급 처리 후 회수 불가합니다.",
					target: "indiCpModal" // 어떤 모달에서 호출됐는지 정보 전달
				});
			}
		},
		submitCkDialog: {
			전송: async () => {
				// 확인 모달에서 전송 버튼 눌렀을 때 실제 Ajax 실행
				const dialog = document.getElementById("indiCpModal");
				const couponId = dialog.querySelector("#modalCouponId").value;
				const provisionGrade = dialog.querySelector("#modalCouponProvision").value;
				const startDate = dialog.querySelector("#modalCouponStart").value;
				const reason = dialog.querySelector("#modalCouponReason").value;
				
				const result = await sendAjax({
					action: "couponProvision",
					couponId, provisionGrade, startDate, reason 
				});

				if (result.status === "ok") {
					showAlert("success", result.title, result.message);
					setTimeout(() => location.reload(), 3000);
				} else {
					showAlert("error", result.title, result.message);
				}
			}
		}
	};

	// 전역 이벤트 리스너
	document.addEventListener("dialogAction", function(e) {
		const { id, action } = e.detail;
		dialogHandlers[id]?.[action]?.();
	});
	
	
	// 개별지급 버튼 클릭 시 라디오 선택여부 확인
	document.querySelector('#openIndiBtn').addEventListener('click', function(e) {
		const selected = document.querySelector('input[name="pCouponRdo"]:checked');
		if (!selected) {
			showAlert("warning", '', '지급할 쿠폰을 선택해 주세요.'); // 2초간 토스트
			e.preventDefault(); //모달 띄움 방지 
			e.stopPropagation();
			return false; // 이벤트 전파 완전 차단
		}
		
		openDialog("indiCpModal")
	});
	
	//개별회원 검색 버튼 클릭시 회원검색 모달 띄우기
	const userSearchBtn = document.getElementById("userSearchBtn");
	if (userSearchBtn) {
		userSearchBtn.addEventListener("click", () => openDialog("userSearchModal"));
	}
	
	//회원검색
	const modalSearchBtn = document.getElementById("modalSearchBtn");
	const searchInput = document.getElementById("modalSearchKeyword");
	
	function handleMemberSearch() {
		// 검색 조건 데이터 수집
		const searchCondition = document.getElementById("hiddenSearchCondition")?.value || "";
		const searchKeyword = searchInput?.value || "";
		
		const hasTotalSearch = searchCondition.trim() !== "";
		const hasKeyword = searchKeyword.trim() !== "";

		// 한쪽만 입력된 경우 막기
		if ((hasTotalSearch && !hasKeyword) || (!hasTotalSearch && hasKeyword)) {
			showAlert("warning", '', '검색어 입력시 검색 조건과 검색어를 모두 입력해야 합니다.'); // 2초간 토스트
			return;
		}

		const data = {
			searchCondition: searchCondition,
			searchKeyword: searchKeyword
		};
		
	    fetch("/admin/memberSearch", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: new URLSearchParams(data)
	    })
	    .then(res => res.json())
	    .then(result => {
	        console.log(result);

			if (result.status === "ok") {
				//검색결과 테이블 표시 
				const modalTable = document.querySelector(".modal_table");
				const tbody = modalTable.querySelector("tbody");
				
				// 기존 내용 초기화
				tbody.innerHTML = "";

				const members = result.memberList || [];

				if (members.length === 0) {
					tbody.innerHTML = `
						<tr>
							<td colspan="6">일치하는 검색 결과가 없습니다.</td>
						</tr>
					`;
				} else {
					members.forEach((member, index) => {
						const row = document.createElement("tr");
						row.innerHTML = `
							<td><input type="checkbox" name="memberCheck" value="${member.memberId}"></td>
							<td>${index + 1}</td>
							<td>${member.email}</td>
							<td>${member.name}</td>
							<td>${member.grade}</td>
							<td>${member.birth}</td>
						`;
						tbody.appendChild(row);
					});
				}

				// 숨김 해제
				modalTable.classList.remove("hidden");
				
			} else if (result.status === "fail") {
				showAlert("error", result.title, result.message);
				
			} else {
				showAlert("error", "오류", "예상치 못한 응답입니다.");
			}
	    })
	    .catch(err => console.error("검색 오류:", err));
	}
	
	// 버튼 클릭 시 실행
	if (modalSearchBtn) {
	    modalSearchBtn.addEventListener("click", handleMemberSearch);
	}
	// Enter 키 입력 시 실행
	if (searchInput) {
	    searchInput.addEventListener("keydown", (event) => {
	        if (event.key === "Enter") {
	            event.preventDefault(); // 폼 기본 제출 막기
	            handleMemberSearch();
	        }
	    });
	}
});	
