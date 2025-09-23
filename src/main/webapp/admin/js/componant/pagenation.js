// // Configuration
// const totalPages = 123; // 예시: 총 페이지 수
// let currentPage = 1;

// const pagesEl = document.getElementById("pages");
// const btnPrev = document.getElementById("btnPrev");
// const btnNext = document.getElementById("btnNext");

// function clamp(n, a, b) {
//     return Math.max(a, Math.min(b, n));
// }

// // Render pagination with ellipses and mid-area
// function renderPagination(total, current) {
//     pagesEl.innerHTML = "";

//     const createPage = (num) => {
//         const el = document.createElement("button");
//         el.className = "page-item";
//         el.type = "button";
//         el.textContent = String(num);
//         el.setAttribute("aria-label", "Page " + num);
//         if (num === current) el.classList.add("active");
//         el.addEventListener("click", () => {
//             goToPage(num);
//         });
//         return el;
//     };

//     const createDots = () => {
//         const el = document.createElement("button");
//         el.className = "dots";
//         el.type = "button";
//         el.textContent = "...";
//         el.title = "Jump to page";
//         el.addEventListener("click", showJumpInput);
//         return el;
//     };

//     // Always show first and last. Show a window around current.
//     const windowSize = 2; // number of pages on each side of current
//     const pages = new Set();
//     pages.add(1);
//     pages.add(total);
//     for (let i = current - windowSize; i <= current + windowSize; i++) {
//         if (i >= 1 && i <= total) pages.add(i);
//     }
//     // also include first few and last few for better UX
//     for (let i = 2; i <= 3; i++) if (i <= total - 1) pages.add(i);
//     for (let i = total - 2; i <= total - 1; i++) if (i > 1) pages.add(i);

//     // Convert to sorted array
//     const arr = Array.from(pages).sort((a, b) => a - b);

//     // Build elements with dots where gaps exist
//     for (let i = 0; i < arr.length; i++) {
//         const p = arr[i];
//         const prev = arr[i - 1];
//         if (i > 0 && p - prev > 1) {
//             // gap -> show dots
//             pagesEl.appendChild(createDots());
//         }
//         pagesEl.appendChild(createPage(p));
//     }
// }

// function showJumpInput(e) {
//     const dotsBtn = e.currentTarget;
//     // Replace dots button with an input element temporarily
//     const input = document.createElement("input");
//     input.type = "number";
//     input.min = 1;
//     input.max = totalPages;
//     input.placeholder = "page";
//     input.className = "jump-input";
//     input.value = "";

//     // When enter or blurred, jump
//     input.addEventListener("keydown", (ev) => {
//         if (ev.key === "Enter") {
//             const v = parseInt(input.value, 10);
//             if (!isNaN(v)) goToPage(clamp(v, 1, totalPages));
//         } else if (ev.key === "Escape") {
//             renderPagination(totalPages, currentPage);
//         }
//     });
//     input.addEventListener("blur", () => {
//         // tiny delay to allow click handlers if needed
//         setTimeout(() => renderPagination(totalPages, currentPage), 120);
//     });

//     dotsBtn.replaceWith(input);
//     input.focus();
// }

// function goToPage(n) {
//     currentPage = clamp(n, 1, totalPages);
//     // update UI
//     renderPagination(totalPages, currentPage);
//     // optional: emit event or call callback here
//     console.log("Go to page", currentPage);
//     // update Prev/Next disabled state
//     updateNavButtons();
// }

// function updateNavButtons() {
//     btnPrev.disabled = currentPage === 1;
//     btnNext.disabled = currentPage === totalPages;
//     btnPrev.setAttribute("aria-disabled", btnPrev.disabled);
//     btnNext.setAttribute("aria-disabled", btnNext.disabled);
// }

// btnPrev.addEventListener("click", () => {
//     if (currentPage > 1) goToPage(currentPage - 1);
// });
// btnNext.addEventListener("click", () => {
//     if (currentPage < totalPages) goToPage(currentPage + 1);
// });

// // Initialize
// renderPagination(totalPages, currentPage);
// updateNavButtons();

// // Expose a helper for demos / integration
// window.pagination = {
//     goToPage: (n) => goToPage(n),
//     setTotal: (t) => {
//         totalPages = t;
//         renderPagination(totalPages, currentPage);
//         updateNavButtons();
//     },
// };
