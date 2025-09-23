// lineChart
const lineChart = document.getElementById("lineChart");
const lineConfig = {
    type: "line",
    data: {
        labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
        datasets: [
            {
                label: "메인 배너 수익",
                data: [12, 19, 3, 5, 2, 3],
                borderWidth: 1,
            },
            {
                label: "프리미엄 구독 수익",
                data: [120, 190, 30, 50, 20, 3, 120, 190, 30, 50, 20, 3],
                borderWidth: 1,
            },
            {
                label: "플랫폼 순이익",
                data: [125, 192, 37, 53, 25, 30, 121, 194, 33, 52, 22, 34],
                borderWidth: 1,
            },
        ],
    },
    options: {
        scales: {
            y: {
                beginAtZero: true,
            },
        },
        Responseive: false,
        maintainAspectRatio: false,
    },
};

const profitLineChart = new Chart(lineChart, lineConfig);

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
                    generateLabels: function (chart) {
                        // Get the default label list
                        const original = Chart.overrides.pie.plugins.legend.labels.generateLabels;
                        const labelsOriginal = original.call(this, chart);

                        // Build an array of colors used in the datasets of the chart
                        let datasetColors = chart.data.datasets.map(function (e) {
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
                onClick: function (mouseEvent, legendItem, legend) {
                    // toggle the visibility of the dataset from what it currently is
                    legend.chart.getDatasetMeta(legendItem.datasetIndex).hidden = legend.chart.isDatasetVisible(
//                        legendItem.datasetIndex,
                    );
                    legend.chart.update();
                },
            },
            tooltip: {
                callbacks: {
                    title: function (context) {
                        const labelIndex = context[0].datasetIndex * 2 + context[0].dataIndex;
                        return context[0].chart.data.labels[labelIndex] + ": " + context[0].formattedValue;
                    },
                },
            },
        },
    },
};

const profitPieChart = new Chart(pieChart, pieConfig);

//radarChart
const radarChart = document.getElementById("radarChart");

const data3 = {
    labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
    datasets: [
        {
            label: "My First Dataset",
            data: [65, 59, 90, 81, 56, 55, 40],
            fill: true,
            backgroundColor: "rgba(255, 99, 132, 0.2)",
            borderColor: "rgb(255, 99, 132)",
            pointBackgroundColor: "rgb(255, 99, 132)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgb(255, 99, 132)",
        },
        {
            label: "My Second Dataset",
            data: [28, 48, 40, 19, 96, 27, 100],
            fill: true,
            backgroundColor: "rgba(54, 162, 235, 0.2)",
            borderColor: "rgb(54, 162, 235)",
            pointBackgroundColor: "rgb(54, 162, 235)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgb(54, 162, 235)",
        },
    ],
};

const radarConfig = {
    type: "radar",
    data: data3,
    options: {
        responsive: false,
        plugins: {
            title: {
                display: true,
                text: "Chart.js Radar Skip Points Chart",
            },
        },
    },
};

const profitRadarChart = new Chart(radarChart, radarConfig);
