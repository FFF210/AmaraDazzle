document.addEventListener("DOMContentLoaded", () => {
  // ===== 최근 30일 라인차트(있으면 그려주고, 없어도 무시) =====
  const ctxLine = document.getElementById("salesChart");
  if (ctxLine && Array.isArray(salesData) && salesData.length) {
    const labels = salesData.map(s => s.orderDate);
    const data = salesData.map(s => s.dailySales);
    new Chart(ctxLine, {
      type: "line",
      data: {
        labels,
        datasets: [{
          label: "일별 매출",
          data,
          borderColor: "#3b82f6",
          backgroundColor: "rgba(59,130,246,0.3)",
          fill: true,
          tension: 0.3,
          borderWidth: 2,
          pointRadius: 3,
          pointBackgroundColor: "#3b82f6"
        }]
      },
      options: {
        responsive: true,
        plugins: {
          tooltip: {
            callbacks: {
              label: (ctx) => `${ctx.dataset.label}: ${Number(ctx.raw).toLocaleString()}원`
            }
          },
          legend: { position: "bottom" }
        },
        scales: {
          y: { ticks: { callback: v => v.toLocaleString()+"원" } }
        }
      }
    });
  }

  // ===== 올해 vs 전년도 (한 그래프에 2 dataset) =====
  const ctxBar = document.getElementById("salesCompareChart");
  if (ctxBar) {
    // salesCompareData는 [{month:"01월", thisYear:..., lastYear:...}, ...] (1~12월 길이 보장)
    const labels = salesCompareData.map(r => r.month);
    const thisYear = salesCompareData.map(r => Number(r.thisYear) || 0);
    const lastYear = salesCompareData.map(r => Number(r.lastYear) || 0);

    new Chart(ctxBar, {
      type: "bar",
      data: {
        labels,
        datasets: [
          { label: "올해",    data: thisYear, backgroundColor: "#3b82f6", borderRadius: 6 },
          { label: "전년도",  data: lastYear, backgroundColor: "#cbd5e1", borderRadius: 6 }
        ]
      },
      options: {
        responsive: true,
        plugins: {
          tooltip: {
            callbacks: {
              label: (ctx) => `${ctx.dataset.label}: ${Number(ctx.raw).toLocaleString()}원`
            }
          },
          legend: { position: "bottom" }
        },
        scales: {
          x: { stacked: false },
          y: { ticks: { callback: v => v.toLocaleString()+"원" } }
        }
      }
    });
  } else {
    console.warn("salesCompareChart 캔버스를 찾을 수 없습니다.");
  }
});
