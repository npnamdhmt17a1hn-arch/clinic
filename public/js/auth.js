// public/js/auth.js
document.addEventListener('DOMContentLoaded', function() {
    // -----------------------------------------------------
    // LOGIC ĐĂNG KÝ (Chỉ chạy trên index.html)
    // -----------------------------------------------------
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', async function(event) {
            event.preventDefault();

            const username = document.getElementById('reg_username').value;
            const password = document.getElementById('reg_password').value;
            const email = document.getElementById('reg_email').value;
            const role = document.getElementById('reg_role').value;
            const messageElement = document.getElementById('registerMessage');
            messageElement.textContent = 'Đang xử lý...';
            messageElement.style.color = 'black';

            try {
                const response = await fetch('/api/auth/register', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password, email, role })
                });

                const data = await response.json();

                if (response.ok) {
                    messageElement.textContent = 'Đăng ký thành công! Chuyển hướng đến Đăng nhập...';
                    messageElement.style.color = 'green';
                    setTimeout(() => {
                        window.location.href = 'login.html'; 
                    }, 1500);
                } else {
                    messageElement.textContent = data.message || 'Đăng ký thất bại.';
                    messageElement.style.color = 'red';
                }
            } catch (error) {
                messageElement.textContent = 'Lỗi kết nối server.';
                messageElement.style.color = 'red';
            }
        });
    }

    // -----------------------------------------------------
    // LOGIC ĐĂNG NHẬP (Chỉ chạy trên login.html)
    // -----------------------------------------------------
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', async function(event) {
            event.preventDefault();

            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const messageElement = document.getElementById('message');
            messageElement.textContent = 'Đang đăng nhập...';
            messageElement.style.color = 'black';

            try {
                const response = await fetch('/api/auth/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password })
                });

                const data = await response.json();

                if (response.ok) {
                    // LƯU TOKEN VÀ ROLE
                    localStorage.setItem('token', data.token);
                    localStorage.setItem('userRole', data.role);
                    
                    messageElement.textContent = 'Đăng nhập thành công! Đang chuyển hướng...';
                    messageElement.style.color = 'green';
                    
                    window.location.href = 'appointment.html'; 

                } else {
                    messageElement.textContent = data.message || 'Đăng nhập thất bại.';
                    messageElement.style.color = 'red';
                }
            } catch (error) {
                messageElement.textContent = 'Lỗi kết nối server.';
                messageElement.style.color = 'red';
            }
        });
    }
});