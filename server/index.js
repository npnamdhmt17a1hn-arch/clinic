// server/index.js

const express = require('express');
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware đọc dữ liệu từ client (nếu cần)
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Phục vụ toàn bộ giao diện từ folder "public"
app.use(express.static(path.join(__dirname, '..', 'public')));

// Route mặc định → trả về file index.html
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'public', 'index.html'));
});

// Khởi động server
app.listen(PORT, () => {
    console.log(`🚀 Frontend server is running at http://localhost:${PORT}`);
});
