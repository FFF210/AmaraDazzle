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
			const orderCardTitle = isMonth ? "당월 총 주문건수 | Month" : "당일 총 주문건수 | Today";
			const orderFrom = isMonth ? "from lastMonth" : "from yesterday";
			
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
			const memberFrom = isMonth ? "from lastMonth" : "from yesterday";
			
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
		//BEST SELLER TOP5
		const pdTable = data.productStats;
		const container = document.querySelector("#bestPdTable");
	    container.innerHTML = "";

	    pdTable.forEach((item, idx) => {
      		const diffSign = item.diff_percent > 0 ? "▲" : (item.diff_percent < 0 ? "▼" : "-");
	      	const diffColor = item.diff_percent > 0 ? "green" : (item.diff_percent < 0 ? "red" : "gray");

	      	const tr = document.createElement("tr");
	      	tr.innerHTML = `
				<td>${idx + 1}</td>
				<td class="title_cell" title="${item.product_name}">${item.product_name}</td>
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
		
		//BEST BRAND TOP5
		const brandTable = data.brandStats;
		const container2 = document.querySelector("#bestBrandTable");
	    container2.innerHTML = "";

	    brandTable.forEach((item, idx) => {
      		const diffSign = item.diff_percent > 0 ? "▲" : (item.diff_percent < 0 ? "▼" : "-");
	      	const diffColor = item.diff_percent > 0 ? "green" : (item.diff_percent < 0 ? "red" : "gray");

	      	const tr = document.createElement("tr");
	      	tr.innerHTML = `
				<td>${idx + 1}</td>
				<td title="${item.brand_name}">${item.brand_name}</td>
				<td>${Number(item.this_month_sales).toLocaleString()}</td>
				<td>${Number(item.last_month_sales).toLocaleString()}</td>
				<td style="color:${diffColor}; font-weight:600;">
				    ${diffSign}${item.diff_percent}%
				</td>
		      `;
	      	container2.appendChild(tr);
	    });
		
		
		//판매상품 카테고리별 비율 (doughnutChart)
		const doughnutChart = document.getElementById("doughnutChart");
		const doughnut = data.categoryRatio;
		const cateLabels = doughnut.map(item => item.categoryName);
		const cateValues = doughnut.map(item => item.ratioPercent);

		const data1 = {
			labels: cateLabels,
			datasets: [
				{
					label: "카테고리 상품 분포 비율",
					data: cateValues,
					backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'],
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
						text: '카테고리별 상품 비율'
					},
				},
			},
		};
		const profitDoughnutChart = new Chart(doughnutChart, doughnutConfig);
	
		
		//판매상품 카테고리별 비율 (pieChart)
		const pieChart = document.getElementById("pieChart");
		const pie = data.skinRatio;
		const skinLabels = pie.map(item => item.skinType);
		const skinValues = pie.map(item => item.ratioPercent);
		const data2 = {
			labels: skinLabels,
			datasets: [
				{
					label: "My First Dataset",
					data: skinValues,
					backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'],
					hoverOffset: 4,
				},
			],
		};

		const pieConfig = {
			type: "pie",
			data: data2,
			options: {
				responsive: true,
				plugins: {
					title: {
						display: true,
						text: "피부타입 비율 (전체 회원 기준)",
					},
					legend: {
						position: 'top'
					},
					tooltip: {
						callbacks: {
							title: function(context) {
								return `${context.label}: ${context.formattedValue}%`;
							},
						},
					},
				},
			},
		};
		const profitPieChart = new Chart(pieChart, pieConfig);
	
	
	})
	.catch(err => console.error("통계 로드 실패:", err));



	// lineChart
	const barChart = document.getElementById("barChart");
	const barConfig = new Chart(barChart, {
		type: 'bar',
		data: {
			labels: ["2025-1", "2025-2", "2025-3", "2025-4", "2025-5", "2025-6", "2025-7", "2025-8", "2025-9", "2025-10", "2025-11", "2025-12"],
			datasets: [{
				label: "메인 배너 수익",
				data: [12, 19, 13, 25, 12, 33, 15, 38, 24, 17, 22, 12],
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
				data: [32, 13, 23, 65, 52, 23, 15, 34, 42, 27, 25, 31],
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
				data: [12, 19, 30, 50, 20, 30, 50, 41, 40, 17, 20, 48],
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



	

	





});