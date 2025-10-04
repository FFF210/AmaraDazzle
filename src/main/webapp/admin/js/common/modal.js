/* ==========================
   Dialog (Modal) 공통 제어 스크립트
   ========================== */

/**
 * 다이얼로그 열기
 * @param {string} id - 다이얼로그 ID
 */
function openDialog(id) {
  const el = document.getElementById(id);
  if (el) {
    el.classList.add("show");
  }
}

/**
 * 다이얼로그 닫기
 * @param {string} id - 다이얼로그 ID
 */
function closeDialog(id) {
  const el = document.getElementById(id);
  if (el) {
    el.classList.remove("show");
  }
}

document.addEventListener("DOMContentLoaded", function() {
  // 모든 다이얼로그에 대해 공통 이벤트 바인딩
  document.querySelectorAll(".modal").forEach(function(modal) {
    var overlay = modal.querySelector(".modal-overlay");

    // 오버레이 클릭 시 닫기
    if (overlay) {
      overlay.addEventListener("click", function() {
        closeDialog(modal.id);
      });
    }

    // 버튼(data-action 속성 있는 경우) 클릭 이벤트
    modal.querySelectorAll("button[data-action]").forEach(function(btn) {
      btn.addEventListener("click", function() {
        // CustomEvent 발행 → 외부 JSP에서 이벤트 처리 가능
        var event = new CustomEvent("dialogAction", {
          detail: { id: modal.id, action: btn.dataset.action }
        });
        document.dispatchEvent(event);

        // 기본 동작: 다이얼로그 닫기
        closeDialog(modal.id);
      });
    });
  });
});



