// DOM이 완전히 로드된 뒤 실행되도록 처리
document.addEventListener("DOMContentLoaded", () => {
  const ctx = document.getElementById("salesChart");

  if (!ctx) {
    console.warn("salesChart 캔버스를 찾을 수 없습니다.");
    return;
  }

  // JSP에서 JSON으로 전달된 데이터 사용
  // 예: controller에서 salesList를 JSON으로 변환해서 ${salesListJson}으로 넘겨줌
  // <script>const salesData = ${salesListJson};</script> 로 JSP 안에 삽입해야 함
  if (typeof salesData === "undefined") {
    console.error("salesData 변수가 정의되지 않았습니다. JSP에서 전달 필요!");
    return;
  }

  new Chart(ctx, {
    type: "bar",
    data: {
      labels: salesData.map(s => s.date),
      datasets: [
        {
          label: "이번년도",
          data: salesData.map(s => s.thisYear),
          backgroundColor: "#3b82f6",
          borderRadius: 8
        },
        {
          label: "전년도",
          data: salesData.map(s => s.lastYear),
          backgroundColor: "#cbd5e1",
          borderRadius: 8
        }
      ]
    },
    options: {
      responsive: true,
      plugins: {
        tooltip: {
          backgroundColor: "#333",
          titleColor: "#fff",
          bodyColor: "#fff",
          callbacks: {
            label: function(context) {
              return context.dataset.label + ": " + context.formattedValue + "원";
            }
          }
        },
        legend: {
          position: "bottom",
          labels: {
            color: "#444"
          }
        }
      },
      scales: {
        x: {
          ticks: { color: "#555" },
          grid: { display: false }
        },
        y: {
          ticks: { color: "#555" },
          grid: { color: "#eee" }
        }
      }
    }
  });
});
