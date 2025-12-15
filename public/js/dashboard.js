// Simple client-side dashboard placeholders
document.addEventListener('DOMContentLoaded', function(){
    // Sample stats (replace with API calls later)
    const stats = {
        appointments: 6,
        patients: 124,
        doctors: 8,
        pending: 3
    };

    document.getElementById('stat-appointments').textContent = stats.appointments;
    document.getElementById('stat-patients').textContent = stats.patients;
    document.getElementById('stat-doctors').textContent = stats.doctors;
    document.getElementById('stat-pending').textContent = stats.pending;

    // Sample upcoming appointments
    const upcoming = [
        {time: '09:00 07/12/2025', patient: 'Nguyễn Văn A', doctor: 'Bs. Lê Thảo', status: 'Đã xác nhận'},
        {time: '10:30 07/12/2025', patient: 'Trần Thị B', doctor: 'Bs. Phạm Hùng', status: 'Chờ'},
        {time: '14:00 07/12/2025', patient: 'Lê Văn C', doctor: 'Bs. Lê Thảo', status: 'Đã xác nhận'}
    ];

    const tbody = document.getElementById('appointmentsBody');
    upcoming.forEach(a => {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td>${a.time}</td><td>${a.patient}</td><td>${a.doctor}</td><td>${a.status}</td>`;
        tbody.appendChild(tr);
    });

    // Mobile menu toggle
    const mobileBtn = document.getElementById('mobileMenuBtn');
    const mainNav = document.getElementById('mainNav');
    if (mobileBtn && mainNav) {
        mobileBtn.addEventListener('click', () => {
            mainNav.classList.toggle('mobile-open');
            // toggle aria-expanded for accessibility
            const expanded = mainNav.classList.contains('mobile-open');
            mobileBtn.setAttribute('aria-expanded', expanded);
        });
    }
});

// Exported function stubs for future integration with backend
function refreshDashboard() {
    // TODO: fetch('/api/dashboard').then(...)
}

window.refreshDashboard = refreshDashboard;
