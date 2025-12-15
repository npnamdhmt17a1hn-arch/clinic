-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 12, 2025 lúc 03:57 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `clinic_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `specialty_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `doctor_id`, `specialty_id`, `department_id`, `appointment_date`, `appointment_time`, `status`, `date`, `time`) VALUES
(15, 2, 3, 3, 2, '2025-12-10', '17:34:00', 'pending', '0000-00-00', '00:00:00'),
(16, 2, 3, 3, 2, '2025-12-10', '17:34:00', 'pending', '0000-00-00', '00:00:00'),
(17, 2, 3, 3, 2, '2025-12-10', '16:47:00', 'cancelled', '0000-00-00', '00:00:00'),
(18, 2, 3, 3, 2, '2025-12-10', '16:47:00', 'confirmed', '0000-00-00', '00:00:00'),
(19, 2, 3, 3, 2, '2025-12-11', '18:46:00', 'confirmed', '0000-00-00', '00:00:00'),
(20, 2, 3, 3, 2, '2025-12-17', '20:10:00', 'confirmed', '0000-00-00', '00:00:00'),
(21, 2, 4, 6, 5, '2025-12-11', '02:49:00', 'pending', '0000-00-00', '00:00:00'),
(22, 2, 1, 1, 1, '2026-01-10', '20:06:00', 'confirmed', '0000-00-00', '00:00:00'),
(23, 2, 4, 6, 5, '2025-12-17', '20:07:00', 'pending', '0000-00-00', '00:00:00'),
(24, 2, 1, 1, 1, '2025-12-11', '20:00:00', 'pending', '0000-00-00', '00:00:00'),
(25, 2, 4, 6, 5, '2025-12-25', '21:35:00', 'confirmed', '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`) VALUES
(1, 'Nội tổng hợp', NULL),
(2, 'Ngoại tổng hợp', NULL),
(3, 'Nhi', NULL),
(4, 'Tai-Mũi-Họng', NULL),
(5, 'Răng', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `specialty_id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `doctors`
--

INSERT INTO `doctors` (`id`, `specialty_id`, `fullname`, `email`, `phone`, `description`) VALUES
(1, 1, 'BS. Nguyễn Văn A', 'bs_a@example.com', '0901234567', NULL),
(2, 2, 'BS. Trần Thị B', 'bs_b@example.com', '0907654321', NULL),
(3, 3, 'BS. Lê Hoàng C', 'bs_c@example.com', '0912345678', NULL),
(4, 6, 'BS. Lee', 'le@gmail.com', '038122345', ''),
(11, 2, 'BS. Lee2', 'le2@gmail.com', '0386136588', ''),
(12, 4, 'BS. Hạnh', 'hanhnh@gmail.com', '012421412552', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `patients`
--

INSERT INTO `patients` (`id`, `user_id`, `fullname`, `phone`, `address`) VALUES
(1, 5, 'Nguyen Van A', '0123456789', NULL),
(2, 10, NULL, NULL, NULL),
(3, 11, NULL, NULL, NULL),
(4, 12, NULL, NULL, NULL),
(5, 13, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `specialties`
--

CREATE TABLE `specialties` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `specialties`
--

INSERT INTO `specialties` (`id`, `department_id`, `name`, `description`) VALUES
(1, 1, 'Nội tim mạch', NULL),
(2, 1, 'Nội tiết', NULL),
(3, 2, 'Ngoại thần kinh', NULL),
(4, 4, 'Viêm xoang', NULL),
(5, 5, 'Niềm Răng', ''),
(6, 5, 'Hàn Răng', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('patient','doctor','admin') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`, `is_active`) VALUES
(1, 'admin_sys', 'admin@clinic.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 'admin', '2025-12-04 07:11:10', 1),
(2, 'dr_thao', 'thao.nguyen@clinic.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'doctor', '2025-12-04 07:11:10', 1),
(3, 'dr_minh', 'minh.hoang@clinic.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 'doctor', '2025-12-04 07:11:10', 1),
(4, 'dr_lan', 'lan.le@clinic.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 'doctor', '2025-12-04 07:11:10', 1),
(5, 'benhnhan_test', 'test@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'patient', '2025-12-04 07:11:10', 1),
(6, 'nguyenvana', 'nguyenvana@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 'patient', '2025-12-08 14:58:22', 1),
(10, 'nguyenvana2', 'nguyenvana2@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 'patient', '2025-12-10 07:17:59', 1),
(11, 'nguyenvana1', 'nguyenvana1@gmail.com', '$2y$10$3ykg5aEhGNBWG0YYyDhRT.R/3tq/N/HNGAfFIau1zn06Hhc7qhduW', 'patient', '2025-12-11 04:49:16', 1),
(12, 'nguyenvanb', 'nguyenvanb@gmail.com', '$2y$10$qjwnlIU7pnGOzDYsUQOF.eEnLBH2uWEbR7sfYY7mrASBCguBIW4mC', 'patient', '2025-12-11 11:17:49', 1),
(13, 'nguyenvanb1', 'nguyenvanb1@gmail.com', '$2y$10$BUm14iS8tyhDB0Sw7zLc3eAyzd6iKUtvm.RIx5GupPADXI74ujRwq', 'patient', '2025-12-11 11:37:13', 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `specialty_id` (`specialty_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Chỉ mục cho bảng `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Chỉ mục cho bảng `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`),
  ADD CONSTRAINT `appointments_ibfk_4` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Các ràng buộc cho bảng `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `specialties`
--
ALTER TABLE `specialties`
  ADD CONSTRAINT `specialties_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
