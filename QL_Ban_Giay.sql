CREATE DATABASE QL_Ban_Giay;
GO
USE QL_Ban_Giay;
GO

-- Tạo bảng Màu sắc
CREATE TABLE MauSac (
    MaMauSac NVARCHAR(20) PRIMARY KEY NOT NULL,
    TenMauSac NVARCHAR(100) NOT NULL
);
GO

-- Tạo bảng Kích cỡ
CREATE TABLE KichCo (
    MaKichCo NVARCHAR(20) PRIMARY KEY NOT NULL,
    TenKichCo NVARCHAR(100) NOT NULL
);
GO

-- Tạo bảng Sản phẩm
CREATE TABLE SanPham (
    MaSanPham NVARCHAR(20) PRIMARY KEY NOT NULL,
    TenSanPham NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(255),
    Gia MONEY NOT NULL,
    HinhAnh NVARCHAR(255) NOT NULL,
    SoLuongTonKho INT NOT NULL,
    ThuongHieu NVARCHAR(255) NOT NULL,
    MaMauSac NVARCHAR(20) NOT NULL,
    MaKichCo NVARCHAR(20) NOT NULL,
    FOREIGN KEY (MaMauSac) REFERENCES MauSac(MaMauSac),
    FOREIGN KEY (MaKichCo) REFERENCES KichCo(MaKichCo)
);
GO

-- Tạo bảng Khách hàng
CREATE TABLE KhachHang (
    MaKhachHang NVARCHAR(20) PRIMARY KEY NOT NULL,
    TenKhachHang NVARCHAR(100) NOT NULL,
    DiaChiEmail NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(20) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL
);
GO

-- Tạo bảng Đơn hàng
CREATE TABLE DonHang (
    MaDonHang NVARCHAR(20) PRIMARY KEY NOT NULL,
    MaKhachHang NVARCHAR(20) NOT NULL,
    NgayDatHang DATE NOT NULL,
    TongSoTien MONEY NOT NULL,
    TrangThaiDonHang NVARCHAR(50) NOT NULL,
    PhuongThucThanhToan NVARCHAR(50) NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);
GO

-- Tạo bảng Chi tiết đơn hàng
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang NVARCHAR(20) PRIMARY KEY NOT NULL,
    MaDonHang NVARCHAR(20) NOT NULL,
    MaSanPham NVARCHAR(20) NOT NULL,
    SoLuong INT NOT NULL,
    Gia MONEY NOT NULL,
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);
GO

-- Tạo bảng Doanh Thu
CREATE TABLE DoanhThu (
    MaDoanhThu NVARCHAR(20) PRIMARY KEY NOT NULL,
    MaSanPham NVARCHAR(20) NOT NULL,
    DoanhThu MONEY NOT NULL DEFAULT 0,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);
GO

-- Tạo bảng Nhân viên
CREATE TABLE NhanVien (
    MaNhanVien NVARCHAR(20) PRIMARY KEY NOT NULL,
    TenNhanVien NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    CCCD NVARCHAR(20) NOT NULL,  -- Chỉnh thành NVARCHAR để nhất quán
    TrangThai BIT NOT NULL, -- 1 đang làm 0 đã nghỉ
    GioiTinh NVARCHAR(10) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL
);
GO

-- Tạo bảng User
CREATE TABLE UserAccounts (
    UserID int identity(1,1) PRIMARY KEY,
	TaiKhoan  NVARCHAR(255) NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL UNIQUE,
    ResetToken VARCHAR(255),
    TokenExpiry TIMESTAMP
);

GO

-- Tạo bảng trung gian giữa Nhân viên và Đơn hàng
CREATE TABLE NhanVien_DonHang (
    MaNhanVien NVARCHAR(20) NOT NULL,
    MaDonHang NVARCHAR(20) NOT NULL,
    PRIMARY KEY (MaNhanVien, MaDonHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
);
GO

-- Tạo bảng Voucher
CREATE TABLE Voucher (
    MaVoucher NVARCHAR(10) PRIMARY KEY,
    TenVoucher NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(255) NOT NULL,
    Gia MONEY NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    DieuKienSuDung NVARCHAR(255) NOT NULL,
    MaSanPham NVARCHAR(20),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);
GO

USE QL_Ban_Giay;
GO

-- Chèn dữ liệu vào bảng Màu sắc
INSERT INTO MauSac (MaMauSac, TenMauSac) VALUES
('M01', 'Đen'),
('M02', 'Trắng'),
('M03', 'Đỏ'),
('M04', 'Xanh Dương'),
('M05', 'Xanh Lá'),
('M06', 'Vàng'),
('M07', 'Cam'),
('M08', 'Hồng'),
('M09', 'Tím'),
('M10', 'Nâu');
GO

-- Chèn dữ liệu vào bảng Kích cỡ
INSERT INTO KichCo (MaKichCo, TenKichCo) VALUES
('K01', '36'),
('K02', '37'),
('K03', '38'),
('K04', '39'),
('K05', '40'),
('K06', '41'),
('K07', '42'),
('K08', '43'),
('K09', '44'),
('K10', '45');
GO

-- Chèn dữ liệu vào bảng Sản phẩm
INSERT INTO SanPham (MaSanPham, TenSanPham, MoTa, Gia, HinhAnh, SoLuongTonKho, ThuongHieu, MaMauSac, MaKichCo) VALUES
('SP01', 'Giày Thể Thao Nam', 'Giày thể thao nam chất lượng cao', 1200000, 'sp01.jpg', 50, 'Nike', 'M01', 'K05'),
('SP02', 'Giày Thể Thao Nữ', 'Giày thể thao nữ năng động', 1100000, 'sp02.jpg', 40, 'Adidas', 'M02', 'K04'),
('SP03', 'Giày Tây Nam', 'Giày tây nam lịch lãm', 1500000, 'sp03.jpg', 30, 'Louis Vuitton', 'M01', 'K05'),
('SP04', 'Giày Cao Gót Nữ', 'Giày cao gót nữ thời trang', 800000, 'sp04.jpg', 25, 'Gucci', 'M03', 'K03'),
('SP05', 'Giày Lười Nam', 'Giày lười nam thoải mái', 900000, 'sp05.jpg', 20, 'Puma', 'M04', 'K06'),
('SP06', 'Giày Sandal Nữ', 'Giày sandal nữ thoáng mát', 700000, 'sp06.jpg', 15, 'Dior', 'M05', 'K07'),
('SP07', 'Giày Boot Nam', 'Giày boot nam bền đẹp', 1800000, 'sp07.jpg', 10, 'Timberland', 'M06', 'K08'),
('SP08', 'Giày Bệt Nữ', 'Giày bệt nữ dễ thương', 650000, 'sp08.jpg', 35, 'Chanel', 'M07', 'K09'),
('SP09', 'Giày Cao Cổ Nam', 'Giày cao cổ nam phong cách', 1600000, 'sp09.jpg', 12, 'Dr. Martens', 'M08', 'K10'),
('SP10', 'Giày Moccasin Nữ', 'Giày moccasin nữ nhẹ nhàng', 950000, 'sp10.jpg', 18, 'Hermes', 'M09', 'K01');
GO

-- Chèn dữ liệu vào bảng Khách hàng
INSERT INTO KhachHang (MaKhachHang, TenKhachHang, DiaChiEmail, SoDienThoai, DiaChi) VALUES
('KH01', 'Nguyễn Văn A', 'nguyenvana@example.com', '0901234567', '123 Đường A, Quận 1, TP.HCM'),
('KH02', 'Trần Thị B', 'tranthib@example.com', '0912345678', '456 Đường B, Quận 3, TP.HCM'),
('KH03', 'Lê Văn C', 'levanc@example.com', '0923456789', '789 Đường C, Quận 5, TP.HCM'),
('KH04', 'Phạm Thị D', 'phamthid@example.com', '0934567890', '321 Đường D, Quận 7, TP.HCM'),
('KH05', 'Hoàng Văn E', 'hoangvane@example.com', '0945678901', '654 Đường E, Quận 9, TP.HCM'),
('KH06', 'Vũ Thị F', 'vuthif@example.com', '0956789012', '987 Đường F, Quận 2, TP.HCM'),
('KH07', 'Đặng Văn G', 'dangvang@example.com', '0967890123', '159 Đường G, Quận 4, TP.HCM'),
('KH08', 'Đỗ Thị H', 'dothih@example.com', '0978901234', '753 Đường H, Quận 6, TP.HCM'),
('KH09', 'Lý Văn I', 'lyvani@example.com', '0989012345', '852 Đường I, Quận 8, TP.HCM'),
('KH10', 'Phan Thị J', 'phanthij@example.com', '0990123456', '951 Đường J, Quận 10, TP.HCM');
GO

-- Chèn dữ liệu vào bảng Đơn hàng
INSERT INTO DonHang (MaDonHang, MaKhachHang, NgayDatHang, TongSoTien, TrangThaiDonHang, PhuongThucThanhToan) VALUES
('DH01', 'KH01', '2024-07-01', 2400000, 'Đã giao', 'Thanh toán khi nhận hàng'),
('DH02', 'KH02', '2024-07-05', 1500000, 'Đang xử lý', 'Chuyển khoản'),
('DH03', 'KH03', '2024-07-10', 800000, 'Đã hủy', 'Thanh toán khi nhận hàng'),
('DH04', 'KH04', '2024-07-12', 900000, 'Đã giao', 'Thanh toán khi nhận hàng'),
('DH05', 'KH05', '2024-07-15', 1800000, 'Đang xử lý', 'Chuyển khoản'),
('DH06', 'KH06', '2024-07-18', 700000, 'Đã giao', 'Thanh toán khi nhận hàng'),
('DH07', 'KH07', '2024-07-20', 650000, 'Đang xử lý', 'Chuyển khoản'),
('DH08', 'KH08', '2024-07-22', 1600000, 'Đã hủy', 'Thanh toán khi nhận hàng'),
('DH09', 'KH09', '2024-07-25', 950000, 'Đã giao', 'Thanh toán khi nhận hàng'),
('DH10', 'KH10', '2024-07-28', 1200000, 'Đang xử lý', 'Chuyển khoản');
GO

-- Chèn dữ liệu vào bảng Chi tiết đơn hàng
INSERT INTO ChiTietDonHang (MaChiTietDonHang, MaDonHang, MaSanPham, SoLuong, Gia) VALUES
('CTDH01', 'DH01', 'SP01', 1, 1200000),
('CTDH02', 'DH01', 'SP03', 1, 1200000),
('CTDH03', 'DH02', 'SP03', 1, 1500000),
('CTDH04', 'DH03', 'SP04', 1, 800000),
('CTDH05', 'DH04', 'SP05', 1, 900000),
('CTDH06', 'DH05', 'SP07', 1, 1800000),
('CTDH07', 'DH06', 'SP06', 1, 700000),
('CTDH08', 'DH07', 'SP08', 1, 650000),
('CTDH09', 'DH08', 'SP09', 1, 1600000),
('CTDH10', 'DH09', 'SP10', 1, 950000);
GO

-- Chèn dữ liệu vào bảng Doanh Thu
INSERT INTO DoanhThu (MaDoanhThu, MaSanPham, DoanhThu) VALUES
('DT01', 'SP01', 1200000),
('DT02', 'SP02', 0),
('DT03', 'SP03', 2700000),
('DT04', 'SP04', 800000),
('DT05', 'SP05', 900000),
('DT06', 'SP06', 700000),
('DT07', 'SP07', 1800000),
('DT08', 'SP08', 650000),
('DT09', 'SP09', 1600000),
('DT10', 'SP10', 950000);
GO

-- Chèn dữ liệu vào bảng Nhân viên
INSERT INTO NhanVien (MaNhanVien, TenNhanVien, NgaySinh, CCCD, TrangThai, GioiTinh, DiaChi) VALUES
('NV01', 'Nguyễn Văn D', '1990-01-01', 123456789, 1, 'Nam', '123 Đường X, TP.HCM'),
('NV02', 'Trần Thị E', '1992-02-02', 234567890, 1, 'Nữ', '456 Đường Y, TP.HCM'),
('NV03', 'Lê Văn F', '1994-03-03', 345678901, 1, 'Nam', '789 Đường Z, TP.HCM'),
('NV04', 'Phạm Thị G', '1996-04-04', 456789012, 1, 'Nữ', '123 Đường A, TP.HCM'),
('NV05', 'Hoàng Văn H', '1998-05-05', 567890123, 1, 'Nam', '456 Đường B, TP.HCM'),
('NV06', 'Vũ Thị I', '2000-06-06', 678901234, 1, 'Nữ', '789 Đường C, TP.HCM'),
('NV07', 'Đặng Văn J', '2002-07-07', 789012345, 1, 'Nam', '123 Đường D, TP.HCM'),
('NV08', 'Đỗ Thị K', '2004-08-08', 890123456, 1, 'Nữ', '456 Đường E, TP.HCM'),
('NV09', 'Lý Văn L', '2006-09-09', 901234567, 1, 'Nam', '789 Đường F, TP.HCM'),
('NV10', 'Phan Thị M', '2008-10-10', 123456789, 1, 'Nữ', '123 Đường G, TP.HCM');
GO


GO
DROP TABLE UserAccounts;
-- Chèn dữ liệu vào bảng NhanVien_DonHang
INSERT INTO NhanVien_DonHang (MaNhanVien, MaDonHang) VALUES
('NV01', 'DH01'),
('NV02', 'DH02'),
('NV03', 'DH03'),
('NV04', 'DH04'),
('NV05', 'DH05'),
('NV06', 'DH06'),
('NV07', 'DH07'),
('NV08', 'DH08'),
('NV09', 'DH09'),
('NV10', 'DH10');
GO

-- Chèn dữ liệu vào bảng Voucher
INSERT INTO Voucher (MaVoucher, TenVoucher, MoTa, Gia, NgayBatDau, NgayKetThuc, DieuKienSuDung, MaSanPham) VALUES
('V01', 'Giảm giá 10%', 'Giảm giá 10% cho sản phẩm bất kỳ', 100000, '2024-07-01', '2024-07-31', 'Áp dụng cho đơn hàng từ 500000 trở lên', 'SP01'),
('V02', 'Giảm giá 20%', 'Giảm giá 20% cho sản phẩm bất kỳ', 200000, '2024-07-05', '2024-07-31', 'Áp dụng cho đơn hàng từ 1000000 trở lên', 'SP02'),
('V03', 'Giảm giá 15%', 'Giảm giá 15% cho sản phẩm bất kỳ', 150000, '2024-07-10', '2024-07-31', 'Áp dụng cho đơn hàng từ 750000 trở lên', 'SP03'),
('V04', 'Giảm giá 5%', 'Giảm giá 5% cho sản phẩm bất kỳ', 50000, '2024-07-15', '2024-07-31', 'Áp dụng cho đơn hàng từ 300000 trở lên', 'SP04'),
('V05', 'Giảm giá 25%', 'Giảm giá 25% cho sản phẩm bất kỳ', 250000, '2024-07-20', '2024-07-31', 'Áp dụng cho đơn hàng từ 1250000 trở lên', 'SP05'),
('V06', 'Giảm giá 30%', 'Giảm giá 30% cho sản phẩm bất kỳ', 300000, '2024-07-25', '2024-07-31', 'Áp dụng cho đơn hàng từ 1500000 trở lên', 'SP06'),
('V07', 'Giảm giá 50%', 'Giảm giá 50% cho sản phẩm bất kỳ', 500000, '2024-07-01', '2024-07-31', 'Áp dụng cho đơn hàng từ 2500000 trở lên', 'SP07'),
('V08', 'Giảm giá 40%', 'Giảm giá 40% cho sản phẩm bất kỳ', 400000, '2024-07-05', '2024-07-31', 'Áp dụng cho đơn hàng từ 2000000 trở lên', 'SP08'),
('V09', 'Giảm giá 35%', 'Giảm giá 35% cho sản phẩm bất kỳ', 350000, '2024-07-10', '2024-07-31', 'Áp dụng cho đơn hàng từ 1750000 trở lên', 'SP09'),
('V10', 'Giảm giá 45%', 'Giảm giá 45% cho sản phẩm bất kỳ', 450000, '2024-07-15', '2024-07-31', 'Áp dụng cho đơn hàng từ 2250000 trở lên', 'SP10');
GO




























































-- Tạo bảng Kho hàng
/*
CREATE TABLE KhoHang (
	MaKho NVARCHAR(20) PRIMARY KEY NOT NULL,
    TenKho NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL
);
GO

-- Tạo bảng Nhập Kho
CREATE TABLE NhapKho (
    MaNhapKho NVARCHAR(20) PRIMARY KEY NOT NULL,
    MaSanPham NVARCHAR(20) NOT NULL,
    MaKho NVARCHAR(20) NOT NULL,
    NgayNhap DATE NOT NULL,
    SoLuong INT NOT NULL,
    GiaNhap MONEY NOT NULL,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
    FOREIGN KEY (MaKho) REFERENCES KhoHang(MaKho)
);
GO

-- Tạo bảng Xuất Kho
CREATE TABLE XuatKho (
    MaXuatKho NVARCHAR(20) PRIMARY KEY NOT NULL,
    MaSanPham NVARCHAR(20) NOT NULL,
    MaKho NVARCHAR(20) NOT NULL,
    NgayXuat DATE NOT NULL,
    SoLuong INT NOT NULL,
    GiaXuat MONEY NOT NULL,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
    FOREIGN KEY (MaKho) REFERENCES KhoHang(MaKho)
);

GO

-- Trigger để cập nhật số lượng tồn kho khi xuất kho
CREATE TRIGGER trg_CapNhatSoLuongTonKho_XuatKho
ON XuatKho
AFTER INSERT
AS
BEGIN
    UPDATE SanPham
    SET SoLuongTonKho = SoLuongTonKho - inserted.SoLuong
    FROM inserted
    WHERE SanPham.MaSanPham = inserted.MaSanPham;
END;
GO

-- Trigger để cập nhật số lượng tồn kho khi nhập kho
CREATE TRIGGER trg_CapNhatSoLuongTonKho_NhapKho
ON NhapKho
AFTER INSERT
AS
BEGIN
    UPDATE SanPham
    SET SoLuongTonKho = SoLuongTonKho + inserted.SoLuong
    FROM inserted
    WHERE SanPham.MaSanPham = inserted.MaSanPham;
END;
GO

-- Trigger để cập nhật doanh thu khi có đơn hàng mới
CREATE TRIGGER trg_CapNhatDoanhThu_DonHang
ON DonHang
AFTER INSERT
AS
BEGIN
    UPDATE DoanhThu
    SET DoanhThu = DoanhThu + (inserted.TongSoTien / (SELECT COUNT(*) FROM ChiTietDonHang WHERE ChiTietDonHang.MaDonHang = inserted.MaDonHang))
    FROM inserted
    WHERE DoanhThu.MaSanPham IN (SELECT ChiTietDonHang.MaSanPham FROM ChiTietDonHang WHERE ChiTietDonHang.MaDonHang = inserted.MaDonHang);
END;
GO

-- Trigger để kiểm tra và cập nhật trạng thái sản phẩm khi số lượng tồn kho thấp hơn ngưỡng
CREATE TRIGGER trg_CapNhatTrangThaiSanPham_SoLuongTonKho
ON SanPham
AFTER UPDATE
AS
BEGIN
    UPDATE SanPham
    SET MoTa = 'Sản phẩm sắp hết hàng'
    WHERE SanPham.SoLuongTonKho < 10;
END;
GO

-- Trigger để kiểm tra và cập nhật trạng thái sản phẩm khi số lượng tồn kho cao hơn ngưỡng
CREATE TRIGGER trg_CapNhatTrangThaiSanPham_SoLuongTonKho_High
ON SanPham
AFTER UPDATE
AS
BEGIN
    UPDATE SanPham
    SET MoTa = 'Sản phẩm còn nhiều hàng'
    WHERE SanPham.SoLuongTonKho >= 10;
END;
GO
*/