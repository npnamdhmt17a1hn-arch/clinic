// public/js/appointment.js
const token = localStorage.getItem('token');
const userRole = localStorage.getItem('userRole');
const appointmentsTableBody = document.querySelector('#appointmentsTable tbody');
const appointmentMessage = document.getElementById('appointmentMessage');
const loadingMessage = document.getElementById('loadingMessage');
const createAppointmentSection = document.getElementById('createAppointmentSection');
const roleBasedHeader = document.getElementById('roleBasedHeader');
const logoutBtn = document.getElementById('logoutBtn');


// -----------------------------------------------------
// KIỂM TRA XÁC THỰC VÀ THIẾT LẬP GIAO DIỆN
// -----------------------------------------------------
if (!token) {
    alert('Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại.');
    window.location.href = 'login.html';
}

// Điều chỉnh giao diện theo vai trò
if (userRole === 'patient') {
    createAppointmentSection.style.display = 'block';
    roleBasedHeader.textContent = 'ID Bác Sĩ';
} else if (userRole === 'doctor') {
    createAppointmentSection.style.display = 'none';
    roleBasedHeader.textContent = 'ID Bệnh Nhân';
} else {
    // Ẩn form nếu không phải vai trò xác định (Admin có thể xem cả hai)
    createAppointmentSection.style.display = 'none'; 
    roleBasedHeader.textContent = 'ID Bệnh Nhân';
}

// Chức năng Đăng xuất
logoutBtn.addEventListener('click', () => {
    localStorage.removeItem('token');
    localStorage.removeItem('userRole');
    window.location.href = 'login.html';
});


// -----------------------------------------------------
// 1. CHỨC NĂNG LẤY LỊCH HẸN
// -----------------------------------------------------
async function fetchAppointments() {
    loadingMessage.textContent = 'Đang tải lịch hẹn...';
    appointmentsTableBody.innerHTML = ''; 

    try {
        const response = await fetch('/api/appointments', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        const data = await response.json();

        if (response.ok) {
            loadingMessage.style.display = 'none';
            if (data.length === 0) {
                appointmentsTableBody.innerHTML = '<tr><td colspan="5">Không có lịch hẹn nào.</td></tr>';
                return;
            }

            // Hiển thị dữ liệu
            data.forEach(appointment => {
                const row = appointmentsTableBody.insertRow();
                row.insertCell().textContent = appointment.id;
                // Hiển thị ID người liên quan
                if (userRole === 'patient') {
                    row.insertCell().textContent = appointment.doctor_id;
                } else {
                    row.insertCell().textContent = appointment.patient_id;
                }
                
                row.insertCell().textContent = new Date(appointment.appointment_date).toLocaleString();
                row.insertCell().textContent = appointment.reason;
                row.insertCell().textContent = appointment.status;
            });
        } else {
            loadingMessage.textContent = 'Lỗi khi tải lịch hẹn: ' + (data.message || 'Lỗi không xác định.');
        }

    } catch (error) {
        console.error('Lỗi mạng:', error);
        loadingMessage.textContent = 'Lỗi kết nối server.';
    }
}


// -----------------------------------------------------
// 2. CHỨC NĂNG ĐẶT LỊCH HẸN (Chỉ dành cho Patient)
// -----------------------------------------------------
if (userRole === 'patient') {
    document.getElementById('appointmentForm').addEventListener('submit', async function(event) {
        event.preventDefault();

        const doctor_id = document.getElementById('doctor_id').value;
        const appointment_date = document.getElementById('appointment_date').value;
        const reason = document.getElementById('reason').value;

        appointmentMessage.textContent = 'Đang gửi...';
        appointmentMessage.style.color = 'black';

        try {
            const response = await fetch('/api/appointments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ doctor_id, appointment_date, reason })
            });

            const data = await response.json();

            if (response.ok) {
                appointmentMessage.textContent = data.message;
                appointmentMessage.style.color = 'green';
                fetchAppointments(); // Tải lại danh sách
            } else {
                appointmentMessage.textContent = data.message || 'Đặt lịch thất bại.';
                appointmentMessage.style.color = 'red';
            }
        } catch (error) {
            appointmentMessage.textContent = 'Lỗi kết nối server.';
            appointmentMessage.style.color = 'red';
        }
    });
}


// Chạy hàm lấy lịch hẹn khi trang được tải
fetchAppointments();