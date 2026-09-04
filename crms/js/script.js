// ===== UTILITY FUNCTIONS =====

// Format date to local string
function formatDate(date) {
    return new Date(date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    });
}

// Get current time
function getCurrentTime() {
    return new Date().toLocaleTimeString('en-US', {
        hour: '2-digit',
        minute: '2-digit'
    });
}

// Generate random ID
function generateId(prefix = 'CR') {
    const num = Math.floor(Math.random() * 10000).toString().padStart(4, '0');
    return `${prefix}-${num}`;
}

// ===== TABLE FILTER FUNCTION =====
function filterTable(tableId, searchInputId) {
    const input = document.getElementById(searchInputId);
    if (!input) return;
    
    const filter = input.value.toLowerCase();
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const rows = table.getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName('td');
        let found = false;
        
        for (let j = 0; j < cells.length; j++) {
            const text = cells[j].textContent.toLowerCase();
            if (text.includes(filter)) {
                found = true;
                break;
            }
        }
        
        rows[i].style.display = found ? '' : 'none';
    }
}

// ===== CONFIRM DELETE =====
function confirmDelete(message = 'Are you sure you want to delete this record?') {
    return confirm(message);
}

// ===== TOAST NOTIFICATION =====
function showToast(message, type = 'success') {
    const colors = {
        success: '#66bb6a',
        error: '#ef5350',
        warning: '#ffa726',
        info: '#42a5f5'
    };
    
    const toast = document.createElement('div');
    toast.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        padding: 16px 28px;
        background: ${colors[type] || colors.success};
        color: #fff;
        border-radius: 12px;
        font-family: 'Poppins', sans-serif;
        font-weight: 500;
        box-shadow: 0 8px 30px rgba(0,0,0,0.2);
        z-index: 9999;
        animation: slideUp 0.4s ease;
        max-width: 400px;
    `;
    toast.textContent = message;
    
    document.body.appendChild(toast);
    
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transition = 'opacity 0.4s ease';
        setTimeout(() => toast.remove(), 400);
    }, 3000);
}

// ===== SIDEBAR TOGGLE FOR MOBILE =====
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    
    if (sidebar.style.width === '70px') {
        sidebar.style.width = '260px';
        mainContent.style.marginLeft = '260px';
        // Show text
        document.querySelectorAll('.sidebar-menu a span, .sidebar-brand span, .sidebar-footer a span')
            .forEach(el => el.style.display = 'inline');
    } else {
        sidebar.style.width = '70px';
        mainContent.style.marginLeft = '70px';
        document.querySelectorAll('.sidebar-menu a span, .sidebar-brand span, .sidebar-footer a span')
            .forEach(el => el.style.display = 'none');
    }
}

// ===== PRINT FUNCTION =====
function printPage() {
    window.print();
}

// ===== EXPORT TABLE TO CSV =====
function exportToCSV(tableId, filename = 'export.csv') {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    let csv = [];
    const rows = table.querySelectorAll('tr');
    
    rows.forEach(row => {
        const cells = row.querySelectorAll('th, td');
        const rowData = [];
        cells.forEach(cell => {
            let text = cell.textContent.trim();
            // Remove extra spaces and commas
            text = text.replace(/,/g, ';');
            rowData.push(text);
        });
        csv.push(rowData.join(','));
    });
    
    const blob = new Blob([csv.join('\n')], { type: 'text/csv' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    link.click();
}

// ===== LOADING SPINNER =====
function showLoading() {
    const overlay = document.createElement('div');
    overlay.id = 'loadingOverlay';
    overlay.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(255,255,255,0.8);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        backdrop-filter: blur(4px);
    `;
    overlay.innerHTML = `
        <div style="text-align:center;">
            <i class="fas fa-spinner fa-spin" style="font-size:48px;color:#0288d1;"></i>
            <p style="margin-top:12px;color:#1a2a4a;font-weight:500;">Loading...</p>
        </div>
    `;
    document.body.appendChild(overlay);
}

function hideLoading() {
    document.getElementById('loadingOverlay')?.remove();
}