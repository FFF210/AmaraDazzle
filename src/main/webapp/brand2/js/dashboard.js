document.addEventListener("DOMContentLoaded", () => {
  const ctxBar = document.getElementById("salesCompareChart");
  if (ctxBar && Array.isArray(salesCompareData) && salesCompareData.length) {
    // [{month:"01월", thisYear:..., lastYear:...}, ...]
    const labels = salesCompareData.map(r => r.month);
    const thisYear = salesCompareData.map(r => Number(r.thisYear) || 0);
    const lastYear = salesCompareData.map(r => Number(r.lastYear) || 0);

    new Chart(ctxBar, {
      type: "bar",
      data: {
        labels: labels, // "01월" ~ "12월"
        datasets: [
          {
            label: "올해 매출액",
            data: thisYear,
            backgroundColor: "#3b82f6",
            borderRadius: 4
          },
          {
            label: "전년도 매출액",
            data: lastYear,
            backgroundColor: "#f97316",
            borderRadius: 4
          }
        ]
      },
      options: {
        responsive: true,
        plugins: {
          tooltip: {
            callbacks: {
              label: (ctx) =>
                `${ctx.dataset.label}: ${Number(ctx.raw).toLocaleString()}원`
            }
          },
          legend: {
            position: "bottom",
            labels: { color: "#444" }
          }
        },
        scales: {
          x: {
            stacked: false, // ✅ 나란히 표시
            ticks: { color: "#555" },
            grid: { display: false }
          },
          y: {
            stacked: false,
            ticks: {
              color: "#555",
              callback: (value) => value.toLocaleString() + "원"
            },
            grid: { color: "#eee" }
          }
        }
      }
    });
  } else {
    console.warn("salesCompareChart 캔버스를 찾을 수 없습니다.");
  }
});
