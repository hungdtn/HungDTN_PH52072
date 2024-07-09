CREATE DATABASE Quan_LiBanGiay;
GO

USE Quan_LiBanGiay;
GO

-- Tạo bảng Danh mục sản phẩm
CREATE TABLE DanhMucSanPham (
    MaDanhMuc INT PRIMARY KEY NOT NULL,
    TenDanhMuc VARCHAR(255) NOT NULL,
    MoTa TEXT
);
GO

-- Tạo bảng Sản phẩm
CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY NOT NULL,
    TenSanPham VARCHAR(255) NOT NULL,
    MoTa TEXT,
    Gia DECIMAL(10, 2) NOT NULL,
    MaDanhMuc INT NOT NULL,
    KichCo VARCHAR(50) NOT NULL,
    MauSac VARCHAR(50) NOT NULL,
    HinhAnh VARCHAR(255) NOT NULL,
    SoLuongTonKho INT NOT NULL,
    ThuongHieu VARCHAR(255) NOT NULL,
    FOREIGN KEY (MaDanhMuc) REFERENCES DanhMucSanPham(MaDanhMuc)
);
GO

-- Tạo bảng Khách hàng
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY NOT NULL,
    TenKhachHang VARCHAR(255) NOT NULL,
    DiaChiEmail VARCHAR(255) NOT NULL,
    SoDienThoai VARCHAR(20) NOT NULL,
    DiaChi TEXT NOT NULL
);
GO

-- Tạo bảng Đơn hàng
CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY NOT NULL,
    MaKhachHang INT NOT NULL,
    NgayDatHang DATE NOT NULL,
    TongSoTien DECIMAL(10, 2) NOT NULL,
    TrangThaiDonHang VARCHAR(50) NOT NULL,
    PhuongThucThanhToan VARCHAR(50) NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);
GO

-- Tạo bảng Chi tiết đơn hàng
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang INT PRIMARY KEY NOT NULL,
    MaDonHang INT NOT NULL,
    MaSanPham INT NOT NULL,
    SoLuong INT NOT NULL,
    Gia DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);
GO

-- Tạo bảng Giỏ hàng
CREATE TABLE GioHang (
    MaGioHang INT PRIMARY KEY NOT NULL,
    MaKhachHang INT NOT NULL,
    TongSoTien DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);
GO

-- Tạo bảng Đánh giá
CREATE TABLE DanhGia (
    MaDanhGia INT PRIMARY KEY NOT NULL,
    MaSanPham INT NOT NULL,
    MaKhachHang INT NOT NULL,
    DanhGia INT,
    BinhLuan TEXT,
    NgayDanhGia DATE,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);
GO

-- Chèn dữ liệu vào bảng DanhMucSanPham
INSERT INTO DanhMucSanPham (MaDanhMuc, TenDanhMuc, MoTa) VALUES
(1, 'Giày Nam', 'Danh mục giày dành cho nam giới'),
(2, 'Giày Nữ', 'Danh mục giày dành cho nữ giới'),
(3, 'Giày Trẻ Em', 'Danh mục giày dành cho trẻ em'),
(4, 'Giày Thể Thao', 'Danh mục giày thể thao'),
(5, 'Giày Da', 'Danh mục giày da'),
(6, 'Giày Lười', 'Danh mục giày lười'),
(7, 'Giày Cao Gót', 'Danh mục giày cao gót');
GO

-- Chèn dữ liệu vào bảng SanPham
INSERT INTO SanPham (MaSanPham, TenSanPham, MoTa, Gia, MaDanhMuc, KichCo, MauSac, HinhAnh, SoLuongTonKho, ThuongHieu) VALUES
(1, 'Giày Thể Thao Nike', 'Giày thể thao cao cấp của Nike', 1000000, 1, '42', 'Đen', 'nike_black.jpg', 100, 'Nike'),
(2, 'Giày Da Nam', 'Giày da nam lịch lãm', 1500000, 2, '43', 'Nâu', 'daman_brown.jpg', 50, 'Zara'),
(3, 'Giày Cao Gót Đỏ', 'Giày cao gót cho nữ', 800000, 3, '37', 'Đỏ', 'red_heels.jpg', 200, 'Gucci'),
(4, 'Giày Lười Nữ', 'Giày lười phong cách cho nữ', 600000, 4, '38', 'Trắng', 'loafers_white.jpg', 150, 'H&M'),
(5, 'Giày Sandal Trẻ Em', 'Giày sandal cho trẻ em', 300000, 5, '30', 'Xanh', 'sandal_kids.jpg', 120, 'Adidas'),
(6, 'Giày Tây Nam', 'Giày tây công sở cho nam', 1300000, 6, '44', 'Đen', 'formal_black.jpg', 80, 'Clarks'),
(7, 'Giày Bóng Đá', 'Giày bóng đá chuyên nghiệp', 2000000, 7, '42', 'Xanh Lá', 'football_green.jpg', 70, 'Puma');
GO

-- Chèn dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (MaKhachHang, TenKhachHang, DiaChiEmail, SoDienThoai, DiaChi) VALUES
(1, 'Nguyễn Văn A', 'nguyenvana@example.com', '0901234567', '123 Đường ABC, Quận 1, TP.HCM'),
(2, 'Trần Thị B', 'tranthib@example.com', '0902345678', '456 Đường DEF, Quận 2, TP.HCM'),
(3, 'Lê Văn C', 'levanc@example.com', '0903456789', '789 Đường GHI, Quận 3, TP.HCM'),
(4, 'Phạm Thị D', 'phamthid@example.com', '0904567890', '101 Đường JKL, Quận 4, TP.HCM'),
(5, 'Hoàng Văn E', 'hoangvane@example.com', '0905678901', '102 Đường MNO, Quận 5, TP.HCM'),
(6, 'Vũ Thị F', 'vuthif@example.com', '0906789012', '103 Đường PQR, Quận 6, TP.HCM'),
(7, 'Đỗ Văn G', 'dovang@example.com', '0907890123', '104 Đường STU, Quận 7, TP.HCM');
GO

-- Chèn dữ liệu vào bảng DonHang
INSERT INTO DonHang (MaDonHang, MaKhachHang, NgayDatHang, TongSoTien, TrangThaiDonHang, PhuongThucThanhToan) VALUES
(1, 1, '2023-01-01', 3000000, 'Đã giao', 'Thanh toán khi nhận hàng'),
(2, 2, '2023-02-01', 1500000, 'Đang xử lý', 'Chuyển khoản ngân hàng'),
(3, 3, '2023-03-01', 2000000, 'Đã giao', 'Thanh toán khi nhận hàng'),
(4, 4, '2023-04-01', 1000000, 'Đang xử lý', 'Chuyển khoản ngân hàng'),
(5, 5, '2023-05-01', 2500000, 'Đã giao', 'Thanh toán khi nhận hàng'),
(6, 6, '2023-06-01', 1800000, 'Đang xử lý', 'Chuyển khoản ngân hàng'),
(7, 7, '2023-07-01', 2200000, 'Đã giao', 'Thanh toán khi nhận hàng');
GO

-- Chèn dữ liệu vào bảng GioHang
INSERT INTO GioHang (MaGioHang, MaKhachHang, TongSoTien) VALUES
(1, 1, 1000000),
(2, 2, 1500000),
(3, 3, 2000000),
(4, 4, 1000000),
(5, 5, 2500000),
(6, 6, 1800000),
(7, 7, 2200000);
GO

-- Chèn dữ liệu vào bảng DanhGia
INSERT INTO DanhGia (MaDanhGia, MaSanPham, MaKhachHang, DanhGia, BinhLuan, NgayDanhGia) VALUES
(1, 1, 1, 5, 'Rất hài lòng với sản phẩm', '2023-01-10'),
(2, 2, 2, 4, 'Giày rất đẹp và vừa vặn', '2023-02-10'),
(3, 3, 3, 3, 'Tạm được, không quá xuất sắc', '2023-03-10'),
(4, 4, 4, 5, 'Sản phẩm tuyệt vời', '2023-04-10'),
(5, 5, 5, 4, 'Giày đẹp nhưng giao hàng chậm', '2023-05-10'),
(6, 6, 6, 5, 'Chất lượng tốt, đáng tiền', '2023-06-10'),
(7, 7, 7, 3, 'Không hài lòng về màu sắc', '2023-07-10');
GO

-- Chèn dữ liệu vào bảng ChiTietDonHang
INSERT INTO ChiTietDonHang (MaChiTietDonHang, MaDonHang, MaSanPham, SoLuong, Gia) VALUES
(1, 1, 1, 1, 1000000),
(2, 2, 2, 1, 1500000),
(3, 3, 3, 2, 1600000),
(4, 4, 4, 1, 1000000),
(5, 5, 5, 2, 500000),
(6, 6, 6, 1, 1300000),
(7, 7, 7, 1, 2000000);
GO

