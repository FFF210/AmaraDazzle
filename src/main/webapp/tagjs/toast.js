function showToast(type, message, title = "") {
  const container = document.getElementById("toast-container");
  if (!container) return;

  const toast = document.createElement("div");
  toast.className = `alert alert--${type}`;

  const icons = {
    success: '<i class="bi bi-check-circle-fill"></i>',
    error:   '<i class="bi bi-x-circle-fill"></i>',
    warning: '<i class="bi bi-exclamation-triangle-fill"></i>',
    info:    '<i class="bi bi-info-circle-fill"></i>'
  };

  toast.innerHTML = `
    <div class="alert-icon">${icons[type] || ""}</div>
    <div class="alert-content">
      ${title ? `<div class="alert-title">${title}</div>` : ""}
      <div class="alert-message">${message}</div>
    </div>
  `;

  container.appendChild(toast);

  // 자동 제거
  setTimeout(() => {
    toast.classList.add("fade-out");
    setTimeout(() => toast.remove(), 300);
  }, 2000);
}

// 페이지 로드 후 LocalStorage에서 메시지 확인
window.addEventListener("load", () => {
  const toastData = localStorage.getItem("toast");
  if (toastData) {
    const { type, title, message } = JSON.parse(toastData);
    showToast(type, message, title);
    localStorage.removeItem("toast"); // 1회성 사용
  }
});
