document.addEventListener('DOMContentLoaded', () => {

    // 차트 색상 설정 (global.css 변수와 유사하게)
    const mainChartColor = '#FFE585';
    const mainChartColorTransparent = 'rgba(255, 229, 133, 0.2)'; // 메인 색상의 반투명 버전

    /**
     * 라인 차트를 생성하는 공통 함수
     * @param {string} canvasId - 차트를 그릴 캔버스 요소의 ID
     * @param {string} label - 차트 데이터셋의 라벨
     * @param {string} borderColor - 라인 색상
     * @param {string} backgroundColor - 라인 아래 채우기 색상
     */
    function createLineChart(canvasId, label, borderColor, backgroundColor) {
        const ctx = document.getElementById(canvasId);
        if (!ctx) return;

        // 차트에 사용할 임의의 데이터 생성
        const dataPoints = Array.from({ length: 50 }, () => Math.random() * 50 + 20);
        const labels = Array(50).fill('');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: label,
                    data: dataPoints,
                    borderColor: borderColor,
                    backgroundColor: backgroundColor,
                    fill: true, // 라인 아래 영역 채우기
                    borderWidth: 2,
                    pointRadius: 2, // 데이터 포인트 점 크기
                    pointBackgroundColor: borderColor,
                    tension: 0.4 // 라인을 부드럽게
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false // 범례 숨기기
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#f0f0f0' // y축 그리드 라인 색상
                        }
                    },
                    x: {
                        grid: {
                            display: false // x축 그리드 라인 숨기기
                        }
                    }
                }
            }
        });
    }

    // "매출액 추이" 차트 생성
    createLineChart('salesChart', '매출액', mainChartColor, mainChartColorTransparent);

    // "AI 이용 건수 추이" 차트 생성
    createLineChart('aiUsageChart', 'AI 이용 건수', mainChartColor, mainChartColorTransparent);

});