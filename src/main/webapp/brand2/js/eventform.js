// 토스트 메시지 함수
function showToast(message) {
  const toast = document.getElementById("toast");
  toast.textContent = message;
  toast.classList.add("show");
  setTimeout(() => toast.classList.remove("show"), 2500);
}

// 상품코드 칩 추가/삭제
const addProductBtn = document.getElementById("addProduct");
const productInput = document.getElementById("productInput");
const productChips = document.getElementById("productChips");

addProductBtn.addEventListener("click", () => {
  const value = productInput.value.trim();
  if (!value) return;

  const chip = document.createElement("div");
  chip.className = "chip";
  chip.textContent = value;

  const removeBtn = document.createElement("span");
  removeBtn.textContent = "×";
  removeBtn.className = "remove";
  removeBtn.addEventListener("click", () => chip.remove());

  chip.appendChild(removeBtn);
  productChips.appendChild(chip);
  productInput.value = "";
});

// 쿠폰 발급 여부 라디오에 따라 쿠폰 입력 활성/비활성
const couponBox = document.getElementById("couponBox");
document.querySelectorAll("input[name='couponIssue']").forEach(radio => {
  radio.addEventListener("change", () => {
    const disabled = radio.value === "N";
    couponBox.querySelectorAll("input").forEach(el => {
      el.disabled = disabled;
    });
    couponBox.classList.toggle("disabled", disabled);
  });
});

// 신청하기 버튼
document.getElementById("btnSubmit").addEventListener("click", () => {
  const form = document.getElementById("eventForm");
  let valid = true;

  // 필수값 체크 (required 속성이 붙은 input/select만)
  form.querySelectorAll("[required]").forEach(el => {
    if (!el.value.trim()) {
      valid = false;
    }
  });

  if (!valid) {
    showToast("모든 입력사항을 입력해야 신청 가능합니다.");
    return;
  }

  // 실제 서비스에서는 서버에 등록 요청 후 성공 응답 시 이동
  window.location.href = "eventComplete.jsp";
});
