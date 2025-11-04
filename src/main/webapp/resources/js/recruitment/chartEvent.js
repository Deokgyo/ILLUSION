
function pieChart(canvasId){
	const ctx = document.getElementById(canvasId);
	
	  new Chart(ctx, {
	    type: 'pie',
	    data: {
	      labels: ['남성', '여성'],
	      datasets: [{
	        label: '',
	        data: [12, 19],
	        borderWidth: 1
	      }]
	    },
	    options: {
	      scales: {
	      }
	    }
	  });
	}

function barChart(canvasId){
	const ctx = document.getElementById(canvasId);
	
	  new Chart(ctx, {
	    type: 'bar',
	    data: {
	      labels: ['신입', '1~3년차', '4~7년차', '8+년차', '경력무관', '인턴', '계약직'],
	      datasets: [{
	        label: '인원 수',
	        data: [10, 6, 5, 3, 2, 2, 1],
	        borderWidth: 1
	      }]
	    },
	    options: {
	      scales: {
	        y: {
	          beginAtZero: true
	        }
	      }
	    }
	  });
	}
  
  