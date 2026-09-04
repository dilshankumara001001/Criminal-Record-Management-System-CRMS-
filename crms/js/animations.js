// ===== PAGE LOAD ANIMATIONS =====
document.addEventListener('DOMContentLoaded', function() {
    // Animate all fade-in elements on scroll
    const fadeElements = document.querySelectorAll('.stat-card, .chart-box, .report-card, .table-container');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.1 });

    fadeElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94)';
        observer.observe(el);
    });
});

// ===== COUNTER ANIMATION =====
function animateCounter(element, target, duration = 2000) {
    let start = 0;
    const step = Math.max(1, Math.floor(target / 60));
    const interval = duration / 60;

    const timer = setInterval(() => {
        start += step;
        if (start >= target) {
            start = target;
            clearInterval(timer);
        }
        element.textContent = start;
    }, interval);
}

// Run counters on page load
document.addEventListener('DOMContentLoaded', function() {
    const statNumbers = document.querySelectorAll('.stat-info p');
    // You can change these numbers dynamically from your backend
    const targets = [156, 89, 34, 12];
    
    statNumbers.forEach((el, index) => {
        if (targets[index]) {
            animateCounter(el, targets[index]);
        }
    });
});

// ===== HOVER GLOW EFFECT =====
document.querySelectorAll('.stat-card, .chart-box, .report-card').forEach(el => {
    el.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.02)';
        this.style.boxShadow = '0 12px 40px rgba(0,0,0,0.12)';
    });
    el.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
        this.style.boxShadow = '';
    });
});

// ===== TABLE ROW HOVER ANIMATION =====
document.querySelectorAll('table tbody tr').forEach(row => {
    row.addEventListener('mouseenter', function() {
        this.style.transition = 'all 0.2s ease';
        this.style.transform = 'scale(1.005)';
    });
    row.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
    });
});

// ===== SIDEBAR TOGGLE (for mobile) =====
// Uncomment this if you want a hamburger menu
/*
document.querySelector('.menu-toggle')?.addEventListener('click', function() {
    document.querySelector('.sidebar').classList.toggle('collapsed');
});
*/