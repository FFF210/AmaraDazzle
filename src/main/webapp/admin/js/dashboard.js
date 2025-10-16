let orderViewType = "day";  // 주문 카드용 상태 변수(현재 주문 카드가 day 기준인지 month 기준인지 저장)
let memberViewType = "day"; // 멤버 카드용 상태 변수

function cardChange(part){

	if(part=='order') {
		orderViewType = orderViewType === "day" ? "month" : "day"; // 상태 토글
		
		fetch("/admin/dashboard", {
			method: "GET",
		})
		.then(res => res.json())
		.then(data => {
			
			const order = data.orderStats;
			
			const isMonth = orderViewType === "month";
			const totalOrderCnt = isMonth ? order.this_month_order_count : order.today_order_count;
			const orderDiffPercent = isMonth ? order.month_order_diff_percent : order.day_order_diff_percent;
			const orderCardTitle = isMonth ? "당월 총 주문건수 | Month" : "당일 총 주문건수 | toDay";
			const orderFrom = isMonth ? "from LastMonth" : "from yesterday";
			
			document.getElementById("orderCardTitle").textContent = orderCardTitle;
			document.getElementById("totalOrderCnt").textContent = totalOrderCnt + "건";
			document.getElementById("orderFrom").textContent = orderFrom;
			
			const orderDiffEl = document.getElementById("orderDiffPercent");
			if (orderDiffPercent > 0) orderDiffEl.textContent = "+" + orderDiffPercent + " %";
			else if (orderDiffPercent < 0) orderDiffEl.textContent = orderDiffPercent + " %";
			else orderDiffEl.textContent = "0 %";
			
		})
		.catch(err => console.error("오더통계 로드 실패:", err));	
		
	}else if(part=='member') {
		memberViewType = memberViewType === "day" ? "month" : "day"; // 상태 토글
		
		fetch("/admin/dashboard", {
			method: "GET",
		})
		.then(res => res.json())
		.then(data => {
			
			const member = data.memberStats;
			const isMonth = memberViewType === "month";
			const totalMemberCnt = isMonth ? member.this_month_member_count : member.today_member_count;
			const memberDiffPercent = isMonth ? member.month_member_diff_percent : member.day_member_diff_percent;
			const memberCardTitle = isMonth ? "당월 신규가입자 수 | Month" : "당일 신규가입자 수 | Today";
			const memberFrom = isMonth ? "from LastMonth" : "from yesterday";
			
			document.getElementById("memberCardTitle").textContent = memberCardTitle;
			document.getElementById("totalMemberCnt").textContent = totalMemberCnt + "건";
			document.getElementById("memberFrom").textContent = memberFrom;
			
			const memberDiffEl = document.getElementById("memberDiffPercent");
			if (memberDiffPercent > 0) memberDiffEl.textContent = "+" + memberDiffPercent + " %";
			else if (diffPercent < 0) memberDiffEl.textContent = memberDiffPercent + " %";
			else memberDiffEl.textContent = "0 %";
			
		})
		.catch(err => console.error("멤버통계 로드 실패:", err));	
		
	}
}



document.addEventListener("DOMContentLoaded", () => {
	fetch("/admin/dashboard", {
		method: "GET",
	})
	.then(res => res.json())
	.then(data => {
		console.log("서버 응답:", data);
		
		// ****** 카드 섹션 *******
		//주문수카드
		const order = data.orderStats;
		const dayOrderDiff = order.day_order_diff_percent;
		const dayOrderDiffEl = document.querySelector("#orderDiffPercent");

		document.querySelector("#totalOrderCnt").textContent = order.today_order_count + "건";

		if (dayOrderDiff > 0) dayOrderDiffEl.textContent = "+" + dayOrderDiff + " %";
		else if (dayOrderDiff < 0) dayOrderDiffEl.textContent = dayOrderDiff + " %";
		else dayOrderDiffEl.textContent = "0 %";
		
		//가입자수 카드
		const member = data.memberStats;
		const dayMemberDiff = order.day_member_diff_percent;
		const dayMemberDiffEl = document.querySelector("#memberDiffPercent");
		document.querySelector("#totalMemberCnt").textContent = member.today_member_count + "건";
		
		if (dayMemberDiff > 0) dayMemberDiffEl.textContent = "+" + dayMemberDiff + " %";
		else if (dayMemberDiff < 0) dayMemberDiffEl.textContent = dayMemberDiff + " %";
		else dayMemberDiffEl.textContent = "0 %";
		 
		
		// ****** 테이블 섹션 *******
		const pdTable = data.productStats;
		const container = document.querySelector("#bestPdTable");
	    container.innerHTML = "";

	    pdTable.forEach((item, idx) => {
      		const diffSign = item.diff_percent > 0 ? "▲" : (item.diff_percent < 0 ? "▼" : "-");
	      	const diffColor = item.diff_percent > 0 ? "green" : (item.diff_percent < 0 ? "red" : "gray");

	      	const tr = document.createElement("tr");
	      	tr.innerHTML = `
				<td>${idx + 1}</td>
				<td class="title_cell">${item.product_name}</td>
				<td>${item.brand_name}</td>
				<td>${Number(item.product_price).toLocaleString()}</td>
				<td>${item.this_month_qty.toLocaleString()}</td>
				<td>${item.last_month_qty.toLocaleString()}</td>
				<td style="color:${diffColor}; font-weight:600;">
				    ${diffSign}${item.diff_percent}%
				</td>
		      `;
	      	container.appendChild(tr);
	    });
	})
	.catch(err => console.error("통계 로드 실패:", err));



	// lineChart
	const barChart = document.getElementById("barChart");
	const barConfig = new Chart(barChart, {
		type: 'bar',
		data: {
			labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
			datasets: [{
				label: "메인 배너 수익",
				data: [12, 19, 3, 5, 2, 3, 5, 8, 4, 17, 2, 12],
				backgroundColor: [
					'rgba(255, 99, 132, 0.5)'

				],
				borderColor: [
					'rgba(255, 99, 132, 1)'

				],
				borderWidth: 1
			},
			{
				label: "프리미엄 구독 수익",
				data: [12, 19, 3, 5, 2, 3, 5, 8, 4, 17, 2, 12],
				backgroundColor: [
					'rgba(54, 162, 235, 0.5)'
				],
				borderColor: [
					'rgba(54, 162, 235, 1)'
				],
				borderWidth: 1
			},
			{
				label: "플랫폼 순이익",
				data: [12, 19, 3, 5, 2, 3, 5, 8, 4, 17, 2, 12],
				backgroundColor: [
					'rgba(255, 206, 86, 0.5)'
				],
				borderColor: [
					'rgba(255, 206, 86, 1)'
				],
				borderWidth: 1
			}]
		},
		options: {
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			},
			Responseive: true,
			maintainAspectRatio: true,
		}
	});



	//doughnutChart
	const doughnutChart = document.getElementById("doughnutChart");

	const data1 = {
		labels: ["Red", "Blue", "Yellow"],
		datasets: [
			{
				label: "My First Dataset",
				data: [300, 50, 100],
				backgroundColor: ["rgb(255, 99, 132)", "rgb(54, 162, 235)", "rgb(255, 205, 86)"],
				hoverOffset: 4,
			},
		],
	};

	const doughnutConfig = {
		type: "doughnut",
		data: data1,
		options: {
			responsive: false,
			plugins: {
				legend: {
					position: "top",
				},
				title: {
					display: true,
					text: "Chart.js Doughnut Chart",
				},
			},
		},
	};

	const profitDoughnutChart = new Chart(doughnutChart, doughnutConfig);

	//pieChart
	const pieChart = document.getElementById("pieChart");

	const data2 = {
		labels: ["Red", "Blue", "Yellow"],
		datasets: [
			{
				label: "My First Dataset",
				data: [300, 50, 100],
				backgroundColor: ["rgb(255, 99, 132)", "rgb(54, 162, 235)", "rgb(255, 205, 86)"],
				hoverOffset: 4,
			},
		],
	};

	const pieConfig = {
		type: "pie",
		data: data2,
		options: {
			responsive: false,
			plugins: {
				title: {
					display: true,
					text: "Chart.js Pie Chart",
				},
				legend: {
					labels: {
						generateLabels: function(chart) {
							// Get the default label list
							const original = Chart.overrides.pie.plugins.legend.labels.generateLabels;
							const labelsOriginal = original.call(this, chart);

							// Build an array of colors used in the datasets of the chart
							let datasetColors = chart.data.datasets.map(function(e) {
								return e.backgroundColor;
							});
							datasetColors = datasetColors.flat();

							// Modify the color and hide state of each label
							labelsOriginal.forEach((label) => {
								// There are twice as many labels as there are datasets. This converts the label index into the corresponding dataset index
								label.datasetIndex = (label.index - (label.index % 2)) / 2;

								// The hidden state must match the dataset's hidden state
								label.hidden = !chart.isDatasetVisible(label.datasetIndex);

								// Change the color to match the dataset
								label.fillStyle = datasetColors[label.index];
							});

							return labelsOriginal;
						},
					},
					onClick: function(mouseEvent, legendItem, legend) {
						// toggle the visibility of the dataset from what it currently is
						legend.chart.getDatasetMeta(legendItem.datasetIndex).hidden = legend.chart.isDatasetVisible(
							//                        legendItem.datasetIndex,
						);
						legend.chart.update();
					},
				},
				tooltip: {
					callbacks: {
						title: function(context) {
							const labelIndex = context[0].datasetIndex * 2 + context[0].dataIndex;
							return context[0].chart.data.labels[labelIndex] + ": " + context[0].formattedValue;
						},
					},
				},
			},
		},
	};

	const profitPieChart = new Chart(pieChart, pieConfig);





});