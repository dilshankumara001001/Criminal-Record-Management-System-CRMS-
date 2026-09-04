// ===== DASHBOARD CHARTS =====
document.addEventListener('DOMContentLoaded', function() {
    // Only run if chart canvases exist
    const crimeChart = document.getElementById('crimeChart');
    const crimeTypeChart = document.getElementById('crimeTypeChart');
    
    if (crimeChart) {
        createCrimeChart();
    }
    if (crimeTypeChart) {
        createCrimeTypeChart();
    }
});

// ===== CRIME CHART (Bar Chart) =====
function createCrimeChart() {
    const ctx = document.getElementById('crimeChart').getContext('2d');
    return new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Crimes Reported',
                data: [12, 19, 15, 22, 18, 25, 30, 28, 20, 16, 14, 10],
                backgroundColor: 'rgba(79, 195, 247, 0.7)',
                borderColor: '#0288d1',
                borderWidth: 2,
                borderRadius: 6,
                hoverBackgroundColor: 'rgba(79, 195, 247, 0.9)'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0,0,0,0.05)' },
                    ticks: { stepSize: 5 }
                },
                x: {
                    grid: { display: false }
                }
            },
            animation: {
                duration: 1500,
                easing: 'easeInOutQuart'
            }
        }
    });
}

// ===== CRIME TYPE CHART (Doughnut) =====
function createCrimeTypeChart() {
    const ctx = document.getElementById('crimeTypeChart').getContext('2d');
    return new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Homicide', 'Drug Trafficking', 'Burglary', 'Cyber Crime', 'Traffic', 'Other'],
            datasets: [{
                data: [45, 68, 32, 55, 28, 40],
                backgroundColor: [
                    '#ef5350',
                    '#66bb6a',
                    '#ffa726',
                    '#42a5f5',
                    '#ab47bc',
                    '#78909c'
                ],
                borderWidth: 0,
                hoverOffset: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 16,
                        usePointStyle: true,
                        pointStyle: 'circle',
                        font: { size: 12 }
                    }
                }
            },
            cutout: '70%',
            animation: {
                animateRotate: true,
                duration: 2000
            }
        }
    });
}

// ===== GRAVE CRIME CHART =====
function createGraveCrimeChart(elementId) {
    const ctx = document.getElementById(elementId)?.getContext('2d');
    if (!ctx) return null;
    
    return new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Murder', 'Drugs', 'Robbery', 'Assault', 'Burglary', 'Cyber'],
            datasets: [{
                label: 'Grave Crimes (26 Categories)',
                data: [45, 68, 32, 55, 28, 40],
                backgroundColor: [
                    '#ef5350', '#ff7043', '#ffa726', 
                    '#66bb6a', '#42a5f5', '#ab47bc'
                ],
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

// ===== STATION WISE COMPARISON CHART =====
function createStationChart(elementId) {
    const ctx = document.getElementById(elementId)?.getContext('2d');
    if (!ctx) return null;
    
    return new Chart(ctx, {
        type: 'radar',
        data: {
            labels: ['Colombo', 'Galle', 'Kandy', 'Jaffna', 'Kurunegala'],
            datasets: [{
                label: 'Crime Rate per 1000',
                data: [65, 42, 38, 25, 30],
                backgroundColor: 'rgba(79, 195, 247, 0.2)',
                borderColor: '#0288d1',
                pointBackgroundColor: '#0288d1',
                fill: true
            }]
        },
        options: {
            responsive: true,
            scales: {
                r: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });
}