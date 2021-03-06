USE [master]
GO
/****** Object:  Database [QLPM_Karaoke]    Script Date: 7/11/2019 3:29:56 PM ******/
CREATE DATABASE [QLPM_Karaoke]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLPM_Karaoke', FILENAME = N'D:\DATA\QLPM_Karaoke.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLPM_Karaoke_log', FILENAME = N'D:\DATA\QLPM_Karaoke_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QLPM_Karaoke] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLPM_Karaoke].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLPM_Karaoke] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLPM_Karaoke] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLPM_Karaoke] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLPM_Karaoke] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLPM_Karaoke] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET RECOVERY FULL 
GO
ALTER DATABASE [QLPM_Karaoke] SET  MULTI_USER 
GO
ALTER DATABASE [QLPM_Karaoke] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLPM_Karaoke] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLPM_Karaoke] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLPM_Karaoke] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLPM_Karaoke] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLPM_Karaoke] SET QUERY_STORE = OFF
GO
USE [QLPM_Karaoke]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [QLPM_Karaoke]
GO
/****** Object:  User [anvt2]    Script Date: 7/11/2019 3:29:57 PM ******/
CREATE USER [anvt2] FOR LOGIN [anvt2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [anvt]    Script Date: 7/11/2019 3:29:57 PM ******/
CREATE USER [anvt] FOR LOGIN [anvt] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [anvt2]
GO
ALTER ROLE [db_datareader] ADD MEMBER [anvt2]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [anvt2]
GO
ALTER ROLE [db_owner] ADD MEMBER [anvt]
GO
ALTER ROLE [db_datareader] ADD MEMBER [anvt]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [anvt]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToUnsign]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ConvertToUnsign] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [char](5) NOT NULL,
	[HoTenNV] [nvarchar](30) NULL,
	[NgaySinh] [datetime] NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[DienThoai] [char](10) NULL,
	[DiaChi] [nvarchar](10) NULL,
	[HinhAnhNV] [char](100) NULL,
	[LoaiNV] [char](9) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuThaoTac]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuThaoTac](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaNVTT] [char](5) NOT NULL,
	[MaTT] [char](5) NOT NULL,
	[GhiChu] [nvarchar](100) NULL,
	[ThoiGian] [datetime] NOT NULL,
 CONSTRAINT [PK_LichSuThaoTac] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiThaoTac]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiThaoTac](
	[MaTT] [char](5) NOT NULL,
	[TenThaoTac] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
 CONSTRAINT [PK_ThaoTac] PRIMARY KEY CLUSTERED 
(
	[MaTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VIEW_LichSuThaoTac]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VIEW_LichSuThaoTac]
as
select nv.HoTenNV,l.TenThaoTac,ls.GhiChu,ls.ThoiGian
from NhanVien nv , LichSuThaoTac ls , LoaiThaoTac l
where nv.MaNV = ls.MaNVTT and ls.MaTT = l.MaTT
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHD] [char](5) NOT NULL,
	[MaPhong] [char](5) NOT NULL,
	[GioVao] [time](7) NULL,
	[GioRa] [time](7) NULL,
	[NhanVienMoPhong] [char](5) NULL,
	[NhanVienLapHDTT] [char](5) NULL,
	[NhanVienLapHD] [char](5) NULL,
	[TongTien] [bigint] NOT NULL,
	[NgayLap] [datetime] NULL,
	[TienGio] [int] NULL,
	[TienPhut] [int] NULL,
	[GioSuDung] [int] NULL,
	[PhutSuDung] [int] NULL,
	[DaThanhToan] [int] NULL,
	[TrangThai] [nchar](10) NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongHat]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongHat](
	[MaPH] [char](5) NOT NULL,
	[TenPH] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[LoaiPhong] [char](5) NOT NULL,
	[TinhTrang] [char](5) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_PhongHat] PRIMARY KEY CLUSTERED 
(
	[MaPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VIEW_ThongKeHoaDon]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_ThongKeHoaDon]
as
select hd.MaHD,ph.TenPH,hd.GioVao,hd.GioRa,hd.TongTien,nv.HoTenNV,hd.NgayLap,hd.DaThanhToan
from HoaDon hd,PhongHat ph,NhanVien nv
where hd.MaPhong = ph.MaPH and hd.NhanVienLapHD = nv.MaNV
GO
/****** Object:  Table [dbo].[DichVu]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DichVu](
	[MaDV] [char](5) NOT NULL,
	[TenDV] [nvarchar](50) NOT NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[DonGiaBan] [int] NOT NULL,
	[DonGiaBanHienTai] [int] NULL,
	[SoLuong] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
	[MaLoaiDV] [char](9) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_DichVu_1] PRIMARY KEY CLUSTERED 
(
	[MaDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaHD] [char](5) NOT NULL,
	[MaDV] [char](5) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaBan] [nchar](10) NULL,
	[ThanhTien] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietHoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VIEW_InHoaDon]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_InHoaDon]
AS
SELECT        hd.MaHD, ph.TenPH, hd.GioVao, hd.GioRa, dv.TenDV, CTHD.SoLuong, CTHD.GiaBan, CTHD.ThanhTien, nv.HoTenNV, hd.NgayLap
FROM            dbo.HoaDon AS hd INNER JOIN
                         dbo.ChiTietHoaDon AS CTHD ON hd.MaHD = CTHD.MaHD INNER JOIN
                         dbo.PhongHat AS ph ON hd.MaPhong = ph.MaPH INNER JOIN
                         dbo.NhanVien AS nv ON hd.NhanVienLapHD = nv.MaNV INNER JOIN
                         dbo.DichVu AS dv ON CTHD.MaDV = dv.MaDV
GO
/****** Object:  Table [dbo].[LoaiDichVu]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiDichVu](
	[MaLoaiDV] [char](9) NOT NULL,
	[TenLoaiDV] [nvarchar](50) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_LoaiDichVu] PRIMARY KEY CLUSTERED 
(
	[MaLoaiDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiNhanVien]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiNhanVien](
	[MaLoaiNV] [char](9) NOT NULL,
	[ChucVu] [nvarchar](50) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_LoaiNhanVien] PRIMARY KEY CLUSTERED 
(
	[MaLoaiNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhongHat]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPhongHat](
	[MaLoai] [char](5) NOT NULL,
	[TenPhong] [nvarchar](50) NOT NULL,
	[GioBinhThuong] [int] NOT NULL,
	[GioCaoDiem] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_LoaiPhongHat] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiTaiKhoan]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiTaiKhoan](
	[MaLoaiTK] [char](9) NOT NULL,
	[TenMaLoaiTK] [nvarchar](50) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_LoaiTaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaLoaiTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [char](5) NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[MatKhau] [nchar](50) NOT NULL,
	[MaNV] [char](5) NULL,
	[LoaiTaiKhoan] [char](9) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinhTrangPhong]    Script Date: 7/11/2019 3:29:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrangPhong](
	[MaTinhTrang] [char](5) NOT NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_TinhTrangPhong] PRIMARY KEY CLUSTERED 
(
	[MaTinhTrang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD001', N'DV001', 355, N'1666.667  ', 591666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD001', N'DV002', 5, N'10000     ', 50000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD001', N'DV011', 7, N'10000     ', 70000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD002', N'DV001', 299, N'1666.667  ', 498333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD002', N'DV013', 6, N'20000     ', 120000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD003', N'DV001', 310, N'1333.333  ', 413333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD003', N'DV003', 5, N'10000     ', 50000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD003', N'DV009', 6, N'10000     ', 60000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD004', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD004', N'DV007', 2, N'5000      ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD004', N'DV012', 3, N'14000     ', 42000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD005', N'DV001', 220, N'1333.333  ', 293333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD005', N'DV009', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD006', N'DV001', 95, N'1333.333  ', 126666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD006', N'DV008', 2, N'8000      ', 16000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD007', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD008', N'DV001', 15, N'1333.333  ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD009', N'DV001', 2, N'1666.667  ', 3333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD009', N'DV007', 2, N'5000      ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD009', N'DV008', 2, N'8000      ', 16000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD010', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD010', N'DV008', 2, N'8000      ', 16000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD011', N'DV001', 2, N'166.667   ', 333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD011', N'DV015', 2, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD012', N'DV001', 1, N'2000      ', 2000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD012', N'DV009', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD012', N'DV015', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD013', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD013', N'DV011', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD014', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD014', N'DV007', 2, N'5000      ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD015', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD015', N'DV009', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD016', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD016', N'DV006', 2, N'5000      ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD017', N'DV001', 1, N'2000      ', 2000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD017', N'DV002', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD018', N'DV001', 2, N'166.667   ', 333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD019', N'DV001', 1, N'2000      ', 2000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD019', N'DV011', 2, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD020', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD021', N'DV001', 39, N'2000      ', 78000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD021', N'DV003', 4, N'10000     ', 40000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD021', N'DV006', 1, N'5000      ', 25000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD021', N'DV016', 6, N'10000     ', 60000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD022', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD022', N'DV011', 4, N'10000     ', 40000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD022', N'DV014', 6, N'8000      ', 48000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD022', N'DV025', 6, N'15000     ', 90000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD023', N'DV001', 1, N'166.667   ', 166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD023', N'DV022', 4, N'4000      ', 16000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD023', N'DV023', 1, N'4000      ', 4000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD024', N'DV001', 1, N'2000      ', 2000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD024', N'DV006', 4, N'5000      ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD024', N'DV008', 2, N'8000      ', 16000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD025', N'DV001', 1, N'2000      ', 2000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD026', N'DV001', 1, N'2000      ', 2000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD026', N'DV002', 8, N'10000     ', 80000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD026', N'DV006', 5, N'5000      ', 25000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD026', N'DV007', 7, N'5000      ', 35000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD026', N'DV010', 6, N'5000      ', 30000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD026', N'DV012', 5, N'14000     ', 70000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD027', N'DV001', 40, N'1666.667  ', 66666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD028', N'DV001', 40, N'1333.333  ', 53333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD028', N'DV002', 4, N'10000     ', 40000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD028', N'DV003', 7, N'10000     ', 70000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD028', N'DV007', 6, N'5000      ', 30000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD029', N'DV001', 23, N'1666.667  ', 38333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD029', N'DV002', 8, N'10000     ', 80000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD029', N'DV003', 8, N'10000     ', 80000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD029', N'DV004', 9, N'10000     ', 90000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV001', 223, N'1333.333  ', 297333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV003', 3, N'10000     ', 10000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV005', 4, N'15000     ', 60000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV006', 6, N'5000      ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV007', 11, N'5000      ', 25000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV009', 13, N'10000     ', 60000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD030', N'DV013', 13, N'20000     ', 160000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD031', N'DV001', 64, N'1333.333  ', 85333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD031', N'DV003', 4, N'10000     ', 40000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD031', N'DV007', 6, N'5000      ', 20000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD031', N'DV008', 6, N'8000      ', 48000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD031', N'DV010', 6, N'5000      ', 30000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD032', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD033', N'DV001', 152, N'1666.667  ', 253333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD033', N'DV002', 3, N'10000     ', 30000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD033', N'DV003', 1, N'10000     ', 210000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD033', N'DV007', 18, N'5000      ', 65000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD033', N'DV009', 7, N'10000     ', 10000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD033', N'DV010', 19, N'5000      ', 120000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD034', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV001', 76, N'1333.333  ', 101333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV002', 3, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV003', 3, N'10000     ', 10000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV004', 5, N'10000     ', 30000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV005', 3, N'15000     ', 645000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV006', 0, N'5000      ', 5000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV007', 8, N'5000      ', 15000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD035', N'DV009', 5, N'10000     ', 50000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD036', N'DV001', 180, N'1333.333  ', 239999, 1)
GO
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD037', N'DV001', 3, N'1333.333  ', 4000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD037', N'DV008', 2, N'8000      ', 8000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD038', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD038', N'DV008', 2, N'8000      ', 8000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD039', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD039', N'DV008', 2, N'8000      ', 8000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD040', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD040', N'DV008', 2, N'8000      ', 8000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD041', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD041', N'DV008', 2, N'8000      ', 8000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD041', N'DV009', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD042', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD042', N'DV008', 1, N'8000      ', 16000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD042', N'DV009', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD043', N'DV001', 21, N'1333.333  ', 27999, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD044', N'DV001', 2, N'1333.333  ', 2666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD044', N'DV008', 3, N'8000      ', 16000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD045', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD045', N'DV009', 2, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD046', N'DV001', 14, N'1333.333  ', 18666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD046', N'DV009', 3, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD047', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD047', N'DV009', 3, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD048', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD049', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD050', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD051', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD052', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD053', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD054', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD055', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD056', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD057', N'DV001', 2, N'1666.667  ', 3333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD057', N'DV005', 1, N'15000     ', 15000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD057', N'DV013', 1, N'20000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD057', N'DV014', 1, N'8000      ', 8000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD058', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD059', N'DV001', 24, N'1666.667  ', 40000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD059', N'DV012', 6, N'14000     ', 84000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD060', N'DV001', 223, N'1500      ', 334500, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD060', N'DV011', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD060', N'DV024', 13, N'4000      ', 24000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD061', N'DV001', 95, N'1833.333  ', 174166, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD061', N'DV003', 2, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD061', N'DV005', 10, N'15000     ', 75000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD061', N'DV007', 10, N'5000      ', 50000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD061', N'DV008', 10, N'8000      ', 80000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD062', N'DV001', 9, N'1333.333  ', 12000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD062', N'DV013', 3, N'20000     ', 60000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD062', N'DV014', 5, N'8000      ', 40000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD063', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD064', N'DV001', 1, N'1333.333  ', 1333, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD065', N'DV001', 11, N'2000      ', 22000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD065', N'DV010', 10, N'5000      ', 25000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD065', N'DV011', 5, N'10000     ', 40000, 0)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD065', N'DV015', 1, N'10000     ', 10000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD066', N'DV001', 3, N'2000      ', 6000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD066', N'DV002', 4, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD066', N'DV003', 2, N'10000     ', 20000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD067', N'DV001', 1, N'1666.667  ', 1666, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD067', N'DV003', 6, N'10000     ', 30000, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHD], [MaDV], [SoLuong], [GiaBan], [ThanhTien], [TrangThai]) VALUES (N'HD067', N'DV010', 4, N'5000      ', 20000, 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV001', N'Giờ Hát', N'Phút', 9999, 9999, 9999, N'', N'LOAIDV003', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV002', N'Bánh Ngọt', N'Bịch', 10000, 17000, 50, N'', N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV003', N'Bánh Snack', N'Bịch', 10000, 20000, 46, NULL, N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV004', N'Cơm Cháy', N'Bịch', 10000, 15000, 50, NULL, N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV005', N'Bò Khô', N'Bịch', 15000, 30000, 50, NULL, N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV006', N'Đậu Phộng', N'Bịch', 5000, 10000, 50, NULL, N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV007', N'Phồng Tôm', N'Bịch', 5000, 10000, 50, NULL, N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV008', N'Coca Cola', N'Lon', 8000, 12000, 50, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV009', N'Pepsi', N'Lon', 10000, 15000, 50, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV010', N'Nước suối', N'Chai', 5000, 10000, 50, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV011', N'Bia Sài Gòn', N'Lon', 10000, 14000, 500, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV012', N'Bia Tiger', N'Lon', 14000, 18000, 500, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV013', N'Bia Heineken', N'Lon', 20000, 24000, 500, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV014', N'Sting', N'Lon', 8000, 12000, 50, NULL, N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV015', N'Nước Aquafina Lít Rưỡi', N'Chai', 10000, 20000, 50, N'', N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV016', N'Bún Bò', N'Tô', 10000, 20000, 30, N'', N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV017', N'Nước cam ép', N'Ly', 10000, 30000, 50, N'', N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV019', N'Sprite', N'Lon', 8000, 12000, 50, N'', N'LOAIDV002', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV020', N'Mirinda', N'Chai', 15000, 20000, 20, N'', N'LOAIDV001', 0)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV021', N'Bánh Donut', N'Cái', 6000, 10000, 20, N'Ngọt, mềm', N'LOAIDV001', 0)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV022', N'Bánh Poca vị muối', N'Cái', 4000, 10000, 20, N'', N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV023', N'Bánh Poca vị bò', N'cái', 4000, 10000, 20, N'', N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV024', N'Bánh Poca vị tảo biển', N'cái', 4000, 10000, 20, N'', N'LOAIDV001', 1)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGiaBan], [DonGiaBanHienTai], [SoLuong], [MoTa], [MaLoaiDV], [TrangThai]) VALUES (N'DV025', N'StrongBow vị Dâu', N'Lon', 15000, 30000, 24, N'', N'LOAIDV002', 1)
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD001', N'PH002', CAST(N'03:19:36' AS Time), CAST(N'09:14:54' AS Time), NULL, NULL, N'NV001', 661667, CAST(N'2019-07-05T03:19:36.770' AS DateTime), 3, 19, 9, 14, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD002', N'PH001', CAST(N'03:19:41' AS Time), NULL, NULL, NULL, N'NV001', 1000000, CAST(N'2019-07-05T03:19:41.353' AS DateTime), 3, 19, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD003', N'PH003', CAST(N'03:19:46' AS Time), CAST(N'08:29:50' AS Time), NULL, NULL, N'NV001', 30000, CAST(N'2019-07-05T03:19:46.027' AS DateTime), 3, 19, 8, 29, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD004', N'PH003', CAST(N'08:31:15' AS Time), CAST(N'08:31:40' AS Time), NULL, NULL, N'NV001', 200000, CAST(N'2019-07-05T08:31:15.570' AS DateTime), 8, 31, 8, 31, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD005', N'PH003', CAST(N'09:15:35' AS Time), CAST(N'11:04:36' AS Time), NULL, NULL, N'NV001', 155333, CAST(N'2019-07-05T09:15:35.980' AS DateTime), 9, 15, 11, 4, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD006', N'PH010', CAST(N'09:27:29' AS Time), CAST(N'00:00:00' AS Time), NULL, NULL, N'NV001', 0, CAST(N'2019-07-05T09:27:29.033' AS DateTime), 9, 27, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD007', N'PH010', CAST(N'12:39:06' AS Time), NULL, N'NV001', NULL, N'NV001', 0, CAST(N'2019-07-05T12:39:06.993' AS DateTime), 12, 39, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD008', N'PH006', CAST(N'12:40:18' AS Time), CAST(N'00:00:00' AS Time), N'NV010', N'     ', N'NV010', 0, CAST(N'2019-07-05T12:40:18.093' AS DateTime), 12, 40, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD009', N'PH010', CAST(N'14:29:03' AS Time), NULL, N'NV001', NULL, N'NV001', 0, CAST(N'2019-07-05T14:29:03.223' AS DateTime), 14, 29, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD010', N'PH010', CAST(N'14:06:11' AS Time), CAST(N'14:06:46' AS Time), N'NV001', N'NV001', N'NV001', 16167, CAST(N'2019-07-07T14:06:11.117' AS DateTime), 14, 6, 14, 6, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD011', N'PH010', CAST(N'14:43:16' AS Time), CAST(N'00:00:00' AS Time), N'NV001', N'     ', N'NV001', 0, CAST(N'2019-07-07T14:43:16.893' AS DateTime), 14, 43, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD012', N'PH001', CAST(N'14:59:03' AS Time), CAST(N'15:00:51' AS Time), N'NV001', N'NV010', N'NV001', 22000, CAST(N'2019-07-07T14:59:03.557' AS DateTime), 14, 59, 15, 0, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD013', N'PH010', CAST(N'15:03:42' AS Time), CAST(N'15:03:57' AS Time), N'NV001', NULL, N'NV001', 10167, CAST(N'2019-07-07T15:03:42.273' AS DateTime), 15, 3, 15, 3, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD014', N'PH006', CAST(N'15:05:46' AS Time), CAST(N'15:06:00' AS Time), N'NV001', NULL, N'NV001', 10167, CAST(N'2019-07-07T15:05:46.267' AS DateTime), 15, 5, 15, 6, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD015', N'PH006', CAST(N'15:06:12' AS Time), CAST(N'15:06:28' AS Time), N'NV001', NULL, N'NV001', 10167, CAST(N'2019-07-07T15:06:12.180' AS DateTime), 15, 6, 15, 6, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD016', N'PH010', CAST(N'15:08:05' AS Time), CAST(N'15:08:17' AS Time), N'NV001', NULL, N'NV001', 10167, CAST(N'2019-07-07T15:08:05.013' AS DateTime), 15, 8, 15, 8, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD017', N'PH001', CAST(N'15:22:17' AS Time), CAST(N'15:23:21' AS Time), N'NV001', N'NV010', N'NV001', 12000, CAST(N'2019-07-07T15:22:17.360' AS DateTime), 15, 22, 15, 23, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD018', N'PH010', CAST(N'15:27:42' AS Time), CAST(N'15:29:05' AS Time), N'NV001', N'NV001', N'NV001', 333, CAST(N'2019-07-07T15:27:42.560' AS DateTime), 15, 27, 15, 29, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD019', N'PH009', CAST(N'15:30:44' AS Time), CAST(N'15:32:05' AS Time), N'NV010', N'NV010', N'NV010', 22000, CAST(N'2019-07-07T15:30:44.240' AS DateTime), 15, 30, 15, 32, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD020', N'PH010', CAST(N'15:36:40' AS Time), NULL, N'NV001', NULL, NULL, 0, CAST(N'2019-07-07T15:36:40.413' AS DateTime), 15, 36, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD021', N'PH001', CAST(N'15:38:53' AS Time), CAST(N'00:36:46' AS Time), N'NV001', NULL, N'NV001', 183000, CAST(N'2019-07-08T00:36:46.000' AS DateTime), 15, 38, 0, 36, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD022', N'PH005', CAST(N'15:42:59' AS Time), CAST(N'00:36:24' AS Time), N'NV001', NULL, N'NV001', 178167, CAST(N'2019-07-08T00:36:24.000' AS DateTime), 15, 42, 0, 36, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD023', N'PH006', CAST(N'15:43:06' AS Time), CAST(N'00:35:55' AS Time), N'NV001', NULL, N'NV001', 20167, CAST(N'2019-07-08T00:35:55.000' AS DateTime), 15, 43, 0, 35, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD024', N'PH004', CAST(N'16:09:44' AS Time), CAST(N'00:36:32' AS Time), N'NV001', NULL, N'NV001', 38000, CAST(N'2019-07-08T00:36:32.000' AS DateTime), 16, 9, 0, 36, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD025', N'PH002', CAST(N'16:11:10' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 16, 11, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD026', N'PH002', CAST(N'16:17:41' AS Time), CAST(N'00:36:39' AS Time), N'NV001', NULL, N'NV001', 242000, CAST(N'2019-07-08T00:36:39.000' AS DateTime), 16, 17, 0, 36, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD027', N'PH001', CAST(N'00:36:52' AS Time), CAST(N'01:16:38' AS Time), N'NV001', NULL, N'NV001', 66667, CAST(N'2019-07-08T01:16:38.000' AS DateTime), 0, 36, 1, 16, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD028', N'PH003', CAST(N'00:36:57' AS Time), CAST(N'01:17:07' AS Time), N'NV001', NULL, N'NV001', 193333, CAST(N'2019-07-08T01:17:07.000' AS DateTime), 0, 36, 1, 17, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD029', N'PH004', CAST(N'00:54:22' AS Time), CAST(N'01:17:22' AS Time), N'NV001', NULL, N'NV001', 288333, CAST(N'2019-07-08T01:17:22.000' AS DateTime), 0, 54, 1, 17, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD030', N'PH005', CAST(N'00:58:57' AS Time), CAST(N'04:41:57' AS Time), N'NV001', NULL, N'NV001', 717333, CAST(N'2019-07-08T04:41:57.000' AS DateTime), 0, 58, 4, 41, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD031', N'PH006', CAST(N'01:16:24' AS Time), CAST(N'02:20:20' AS Time), N'NV001', N'NV001', N'NV001', 115333, CAST(N'2019-07-08T02:20:20.000' AS DateTime), 1, 16, 2, 20, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD032', N'PH004', CAST(N'01:56:47' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 1, 56, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD033', N'PH004', CAST(N'02:09:18' AS Time), CAST(N'04:41:40' AS Time), N'NV001', NULL, N'NV001', 378333, CAST(N'2019-07-08T04:41:40.000' AS DateTime), 2, 9, 4, 41, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD034', N'PH003', CAST(N'02:09:22' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 2, 9, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD035', N'PH006', CAST(N'03:26:38' AS Time), CAST(N'04:42:07' AS Time), N'NV001', NULL, N'NV001', 131333, CAST(N'2019-07-08T04:42:07.000' AS DateTime), 3, 26, 4, 42, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD036', N'PH003', CAST(N'04:43:16' AS Time), CAST(N'07:43:59' AS Time), N'NV001', N'NV001', N'NV001', 240000, CAST(N'2019-07-08T07:43:59.000' AS DateTime), 4, 43, 7, 43, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD037', N'PH010', CAST(N'07:42:06' AS Time), CAST(N'07:45:21' AS Time), N'NV001', N'NV001', N'NV001', 20000, CAST(N'2019-07-08T07:45:21.000' AS DateTime), 7, 42, 7, 45, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD038', N'PH010', CAST(N'07:45:43' AS Time), CAST(N'07:46:10' AS Time), N'NV001', NULL, N'NV001', 17333, CAST(N'2019-07-08T07:46:10.000' AS DateTime), 7, 45, 7, 46, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD039', N'PH010', CAST(N'07:49:10' AS Time), CAST(N'07:49:31' AS Time), N'NV001', NULL, N'NV001', 17333, CAST(N'2019-07-08T07:49:31.000' AS DateTime), 7, 49, 7, 49, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD040', N'PH010', CAST(N'07:51:54' AS Time), CAST(N'07:52:21' AS Time), N'NV001', NULL, N'NV001', 17333, CAST(N'2019-07-08T07:52:21.000' AS DateTime), 7, 51, 7, 52, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD041', N'PH006', CAST(N'07:52:47' AS Time), CAST(N'07:53:22' AS Time), N'NV001', NULL, N'NV001', 27333, CAST(N'2019-07-08T07:53:22.000' AS DateTime), 7, 52, 7, 53, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD042', N'PH006', CAST(N'07:55:31' AS Time), CAST(N'07:56:36' AS Time), N'NV001', NULL, N'NV001', 19333, CAST(N'2019-07-08T07:56:36.000' AS DateTime), 7, 55, 7, 56, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD043', N'PH010', CAST(N'08:08:10' AS Time), CAST(N'08:29:35' AS Time), N'NV001', N'     ', N'NV001', 28000, CAST(N'2019-07-08T08:29:35.000' AS DateTime), 8, 8, 8, 29, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD044', N'PH010', CAST(N'08:35:43' AS Time), CAST(N'08:37:30' AS Time), N'NV001', N'NV001', N'NV001', 26667, CAST(N'2019-07-08T08:37:30.000' AS DateTime), 8, 35, 8, 37, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD045', N'PH010', CAST(N'08:38:49' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 8, 38, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD046', N'PH010', CAST(N'08:43:31' AS Time), CAST(N'08:57:41' AS Time), N'NV001', N'NV001', NULL, 48667, CAST(N'2019-07-08T08:57:41.000' AS DateTime), 8, 43, 8, 57, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD047', N'PH010', CAST(N'08:57:59' AS Time), CAST(N'08:58:55' AS Time), N'NV001', N'NV001', N'NV001', 31333, CAST(N'2019-07-08T08:58:55.000' AS DateTime), 8, 57, 8, 58, 1, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD048', N'PH001', CAST(N'10:14:23' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 14, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD049', N'PH001', CAST(N'10:15:58' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 15, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD050', N'PH001', CAST(N'10:17:12' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 17, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD051', N'PH001', CAST(N'10:22:05' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 22, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD052', N'PH010', CAST(N'10:22:15' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 22, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD053', N'PH006', CAST(N'10:22:21' AS Time), NULL, N'NV010', NULL, NULL, 0, NULL, 10, 22, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD054', N'PH008', CAST(N'10:22:30' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 22, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD055', N'PH001', CAST(N'10:24:09' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 10, 24, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD056', N'PH010', CAST(N'10:24:16' AS Time), NULL, N'NV010', NULL, NULL, 0, NULL, 10, 24, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD057', N'PH001', CAST(N'10:36:31' AS Time), NULL, N'NV010', NULL, NULL, 0, NULL, 10, 36, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD058', N'PH003', CAST(N'10:37:16' AS Time), NULL, N'NV010', NULL, NULL, 0, NULL, 10, 37, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD059', N'PH002', CAST(N'13:26:46' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 13, 26, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD060', N'PH005', CAST(N'13:33:05' AS Time), CAST(N'13:34:13' AS Time), N'NV001', N'NV001', NULL, 9667, CAST(N'2019-07-08T13:34:13.000' AS DateTime), 13, 33, 13, 34, 0, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD061', N'PH001', CAST(N'15:41:28' AS Time), CAST(N'17:10:31' AS Time), N'NV001', N'NV001', NULL, 461333, CAST(N'2019-07-08T17:10:31.000' AS DateTime), 15, 41, 17, 10, 0, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD062', N'PH010', CAST(N'16:41:27' AS Time), NULL, N'NV016', NULL, NULL, 0, NULL, 16, 41, 0, 0, 0, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD063', N'PH004', CAST(N'16:45:55' AS Time), NULL, N'NV010', NULL, NULL, 0, NULL, 16, 45, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD064', N'PH006', CAST(N'16:51:53' AS Time), NULL, N'NV010', NULL, NULL, 0, NULL, 16, 51, 0, 0, 1, N'0         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD065', N'PH004', CAST(N'17:06:09' AS Time), CAST(N'17:08:00' AS Time), N'NV010', N'NV010', NULL, 14000, CAST(N'2019-07-08T17:08:00.000' AS DateTime), 17, 6, 17, 8, 0, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD066', N'PH002', CAST(N'17:14:46' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 17, 14, 0, 0, 0, N'1         ')
INSERT [dbo].[HoaDon] ([MaHD], [MaPhong], [GioVao], [GioRa], [NhanVienMoPhong], [NhanVienLapHDTT], [NhanVienLapHD], [TongTien], [NgayLap], [TienGio], [TienPhut], [GioSuDung], [PhutSuDung], [DaThanhToan], [TrangThai]) VALUES (N'HD067', N'PH003', CAST(N'17:16:39' AS Time), NULL, N'NV001', NULL, NULL, 0, NULL, 17, 16, 0, 0, 0, N'1         ')
SET IDENTITY_INSERT [dbo].[LichSuThaoTac] ON 

INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (5, N'NV001', N'TT001', N'', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (6, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (7, N'NV001', N'TT001', N'', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (8, N'NV001', N'TT003', N'Bánh Poca vị bò', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (9, N'NV010', N'TT001', N'', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (10, N'NV010', N'TT001', N'', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (11, N'NV010', N'TT001', N'', CAST(N'2019-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (12, N'NV001', N'TT001', N'', CAST(N'1900-01-01T11:10:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (13, N'NV010', N'TT001', N'', CAST(N'1900-01-01T08:12:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (15, N'NV001', N'TT001', N'', CAST(N'1900-01-01T11:20:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (16, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:24:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (17, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:27:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (18, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-17T11:27:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (19, N'NV001', N'TT003', N'Bánh Ngọt', CAST(N'2019-06-17T11:27:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (20, N'NV010', N'TT001', N'', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (21, N'NV010', N'TT007', N'PH002', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (22, N'NV010', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (23, N'NV010', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (24, N'NV010', N'TT003', N'Bánh Poca vị bò', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (25, N'NV010', N'TT003', N'Bánh Ngọt', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (26, N'NV010', N'TT006', N'PH002', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (27, N'NV010', N'TT006', N'PH001', CAST(N'2019-06-17T11:46:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (28, N'NV010', N'TT001', N'', CAST(N'2019-06-17T11:50:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (29, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:52:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (31, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:54:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (33, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:55:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (35, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:56:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (36, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-17T11:56:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (37, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-17T11:56:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (38, N'NV001', N'TT002', N'StrongBow vị Dâu', CAST(N'2019-06-17T11:56:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (39, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:58:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (40, N'NV001', N'TT001', N'', CAST(N'2019-06-17T11:58:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (42, N'NV003', N'TT001', N'', CAST(N'2019-06-17T11:59:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (43, N'NV010', N'TT001', N'', CAST(N'2019-06-17T12:00:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (45, N'NV001', N'TT001', N'', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (46, N'NV001', N'TT006', N'PH002', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (47, N'NV001', N'TT007', N'PH002', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (48, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (49, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (50, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (51, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (52, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (53, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (54, N'NV001', N'TT006', N'PH002', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (55, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (56, N'NV001', N'TT007', N'PH003', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (57, N'NV001', N'TT006', N'PH003', CAST(N'2019-06-17T12:03:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (58, N'NV001', N'TT001', N'', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (59, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (60, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (61, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (62, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (63, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (64, N'NV001', N'TT002', N'Đậu Phộng', CAST(N'2019-06-17T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (65, N'NV001', N'TT001', N'', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (66, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (67, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (68, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (69, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (70, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (71, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-17T12:21:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (72, N'NV001', N'TT001', N'', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (73, N'NV001', N'TT007', N'PH002', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (74, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (75, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (76, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (77, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (78, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (79, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (80, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (81, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (82, N'NV001', N'TT002', N'Đậu Phộng', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (83, N'NV001', N'TT006', N'PH002', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (84, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-17T12:21:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (85, N'NV001', N'TT001', N'', CAST(N'2019-06-17T15:35:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (86, N'NV001', N'TT009', N'Log History Test chức năng sửa phòng', CAST(N'2019-06-17T15:35:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (87, N'NV001', N'TT001', N'', CAST(N'2019-06-17T15:39:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (88, N'NV001', N'TT001', N'', CAST(N'2019-06-17T15:41:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (89, N'NV001', N'TT009', N'Test LH 2 ', CAST(N'2019-06-17T15:41:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (90, N'NV001', N'TT001', N'', CAST(N'2019-06-17T15:45:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (91, N'NV001', N'TT009', N'Test  Lh 3', CAST(N'2019-06-17T15:45:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (92, N'NV001', N'TT001', N'', CAST(N'2019-06-17T15:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (93, N'NV001', N'TT009', N'test LH 4 chỉnh phòng 1 thành phòng vip', CAST(N'2019-06-17T15:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (94, N'NV001', N'TT001', N'', CAST(N'2019-06-17T15:49:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (95, N'NV001', N'TT009', N'Test LH lần 5', CAST(N'2019-06-17T15:49:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (96, N'NV001', N'TT001', N'', CAST(N'2019-06-18T09:50:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (97, N'NV001', N'TT001', N'', CAST(N'2019-06-18T18:12:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (98, N'NV010', N'TT001', N'', CAST(N'2019-06-18T18:22:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (99, N'NV001', N'TT001', N'', CAST(N'2019-06-18T19:41:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (100, N'NV001', N'TT001', N'', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (101, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (102, N'NV001', N'TT002', N'Nước suối', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (103, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (104, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (105, N'NV001', N'TT002', N'Đậu Phộng', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (106, N'NV001', N'TT002', N'Nước Aquafina Lít Rưỡi', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (107, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (108, N'NV001', N'TT007', N'PH003', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (109, N'NV001', N'TT002', N'Nước Aquafina Lít Rưỡi', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (110, N'NV001', N'TT002', N'Nước cam ép', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (111, N'NV001', N'TT002', N'Nước suối', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (112, N'NV001', N'TT006', N'PH003', CAST(N'2019-06-19T08:44:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (113, N'NV010', N'TT001', N'', CAST(N'2019-06-19T08:47:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (114, N'NV010', N'TT001', N'', CAST(N'2019-06-19T08:49:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (115, N'NV010', N'TT001', N'', CAST(N'2019-06-19T08:52:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (116, N'NV010', N'TT001', N'', CAST(N'2019-06-19T08:54:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (117, N'NV010', N'TT001', N'', CAST(N'2019-06-19T08:58:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (118, N'NV001', N'TT001', N'', CAST(N'2019-06-19T09:26:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (119, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:17:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (120, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T10:17:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (121, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:17:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (122, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-19T10:17:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (123, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:23:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (124, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-19T10:23:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (125, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:23:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (126, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:29:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (127, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T10:29:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (128, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T10:29:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (129, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-19T10:29:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (130, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-19T10:29:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (131, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:35:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (132, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T10:35:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (133, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T10:35:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (134, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:35:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (135, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:35:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (136, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:36:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (137, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T10:36:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (138, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T10:36:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (139, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:36:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (140, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:36:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (141, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:41:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (142, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T10:41:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (143, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:41:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (144, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:41:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (145, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:41:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (146, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:47:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (147, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:48:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (148, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T10:48:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (149, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:48:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (150, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:48:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (151, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T10:48:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (152, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (153, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (154, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (155, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (156, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (157, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (158, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:50:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (159, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T10:50:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (160, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:50:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (161, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:50:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (162, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:50:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (163, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:51:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (164, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T10:51:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (165, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:51:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (166, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:51:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (167, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:51:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (168, N'NV001', N'TT001', N'', CAST(N'2019-06-19T10:59:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (169, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T10:59:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (170, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-19T10:59:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (171, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T10:59:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (172, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T10:59:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (173, N'NV001', N'TT001', N'', CAST(N'2019-06-19T11:00:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (174, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T11:00:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (175, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-19T11:00:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (176, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T11:00:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (177, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-19T11:00:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (178, N'NV001', N'TT001', N'', CAST(N'2019-06-19T11:09:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (179, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T11:09:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (180, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T11:09:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (181, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T11:09:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (182, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T11:09:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (183, N'NV001', N'TT001', N'', CAST(N'2019-06-19T11:10:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (184, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T11:10:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (185, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T11:10:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (186, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-19T11:10:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (187, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T11:10:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (188, N'NV001', N'TT001', N'', CAST(N'2019-06-19T11:12:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (189, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-19T11:12:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (190, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-19T11:12:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (191, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-19T11:12:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (192, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-19T11:12:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (193, N'NV001', N'TT001', N'', CAST(N'2019-06-20T07:29:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (194, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-20T07:29:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (195, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-20T07:29:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (196, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-20T07:29:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (197, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-20T07:29:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (198, N'NV001', N'TT001', N'', CAST(N'2019-06-20T07:31:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (199, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-20T07:31:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (200, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-20T07:31:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (201, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-20T07:31:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (202, N'NV001', N'TT001', N'', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (203, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (204, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (205, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (206, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (207, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (208, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-20T07:34:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (209, N'NV001', N'TT001', N'', CAST(N'2019-06-20T11:17:50.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (210, N'NV001', N'TT001', N'', CAST(N'2019-06-20T11:21:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (211, N'NV001', N'TT001', N'', CAST(N'2019-06-20T11:26:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (212, N'NV001', N'TT001', N'', CAST(N'2019-06-20T11:44:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (213, N'NV001', N'TT001', N'', CAST(N'2019-06-21T08:47:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (214, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T08:47:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (215, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T08:47:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (216, N'NV001', N'TT001', N'', CAST(N'2019-06-21T08:48:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (217, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T08:48:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (218, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T08:48:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (219, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T08:48:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (220, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T08:48:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (221, N'NV001', N'TT001', N'', CAST(N'2019-06-21T08:49:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (222, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T08:49:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (223, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T08:49:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (224, N'NV001', N'TT002', N'Sting', CAST(N'2019-06-21T08:49:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (225, N'NV001', N'TT001', N'', CAST(N'2019-06-21T08:52:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (226, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T08:52:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (227, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T08:52:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (228, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T08:52:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (229, N'NV001', N'TT001', N'', CAST(N'2019-06-21T08:54:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (230, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T08:54:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (231, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T08:54:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (232, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T08:54:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (233, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:02:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (234, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T09:02:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (235, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:03:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (236, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-21T09:03:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (237, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T09:03:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (238, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:06:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (239, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-21T09:06:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (240, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T09:06:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (241, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T09:06:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (242, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:18:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (243, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T09:18:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (244, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T09:18:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (245, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T09:18:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (246, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T09:18:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (247, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:22:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (248, N'NV001', N'TT007', N'PH009', CAST(N'2019-06-21T09:22:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (249, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:24:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (250, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T09:24:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (251, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-21T09:24:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (252, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-21T09:24:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (253, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (254, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (255, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (256, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (257, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (258, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (259, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (260, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (261, N'NV001', N'TT007', N'PH004', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (262, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (263, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (264, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (265, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (266, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (267, N'NV001', N'TT006', N'PH004', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (268, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (269, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-21T09:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (270, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:34:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (271, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (272, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (273, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (274, N'NV001', N'TT007', N'PH004', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (275, N'NV001', N'TT006', N'PH004', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (276, N'NV001', N'TT003', N'Bánh Ngọt', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (277, N'NV001', N'TT007', N'PH004', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (278, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (279, N'NV001', N'TT006', N'PH004', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (280, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T09:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (281, N'NV001', N'TT001', N'', CAST(N'2019-06-21T09:49:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (282, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T09:49:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (283, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-21T09:49:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (284, N'NV010', N'TT001', N'', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (285, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (286, N'NV010', N'TT007', N'PH010', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (287, N'NV010', N'TT002', N'Bia Heineken', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (288, N'NV010', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (289, N'NV010', N'TT002', N'Bia Tiger', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (290, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-21T09:50:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (291, N'NV010', N'TT001', N'', CAST(N'2019-06-21T09:52:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (292, N'NV010', N'TT007', N'PH010', CAST(N'2019-06-21T09:52:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (293, N'NV010', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T09:52:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (294, N'NV010', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T09:52:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (295, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-21T09:52:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (296, N'NV001', N'TT001', N'', CAST(N'2019-06-21T10:03:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (297, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T10:03:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (298, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T10:03:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (299, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-21T10:03:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (300, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T10:03:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (301, N'NV001', N'TT001', N'', CAST(N'2019-06-21T10:13:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (302, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T10:13:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (303, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T10:13:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (304, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T10:13:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (305, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:03:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (306, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:14:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (307, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:33:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (308, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (309, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (310, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (311, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (312, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (313, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (314, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-21T11:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (315, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:39:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (316, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T11:39:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (317, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-21T11:39:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (318, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-21T11:39:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (319, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:42:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (320, N'NV001', N'TT001', N'', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (321, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (322, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (323, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (324, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (325, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (326, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (327, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T11:46:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (328, N'NV001', N'TT001', N'', CAST(N'2019-06-21T18:25:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (329, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T18:25:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (330, N'NV001', N'TT002', N'Nước Aquafina Lít Rưỡi', CAST(N'2019-06-21T18:25:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (331, N'NV001', N'TT002', N'Nước cam ép', CAST(N'2019-06-21T18:25:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (332, N'NV001', N'TT002', N'Nước suối', CAST(N'2019-06-21T18:25:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (333, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-21T18:25:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (334, N'NV001', N'TT001', N'', CAST(N'2019-06-21T18:34:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (335, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-21T18:34:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (336, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-21T18:34:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (337, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-21T18:34:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (338, N'NV001', N'TT001', N'', CAST(N'2019-06-22T09:02:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1338, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:00:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1339, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:03:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1340, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:03:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1341, N'NV010', N'TT001', N'', CAST(N'2019-06-22T12:09:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1342, N'NV010', N'TT001', N'', CAST(N'2019-06-22T12:18:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1343, N'NV010', N'TT007', N'PH009', CAST(N'2019-06-22T12:18:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1344, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:27:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1345, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:32:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1346, N'NV010', N'TT001', N'', CAST(N'2019-06-22T12:35:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1347, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:37:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1348, N'NV010', N'TT001', N'', CAST(N'2019-06-22T12:41:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1349, N'NV010', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-22T12:41:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1350, N'NV010', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-22T12:41:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1351, N'NV010', N'TT001', N'', CAST(N'2019-06-22T12:47:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1352, N'NV010', N'TT001', N'', CAST(N'2019-06-22T12:50:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1353, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1354, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1355, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1356, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1357, N'NV001', N'TT007', N'PH009', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1358, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1359, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1360, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1361, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1362, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-22T12:51:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1363, N'NV001', N'TT001', N'', CAST(N'2019-06-22T12:57:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1364, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T12:57:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1365, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-22T12:57:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1366, N'NV001', N'TT001', N'', CAST(N'2019-06-22T13:11:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1367, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T13:11:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1368, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-22T13:11:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1369, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-22T13:11:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1370, N'NV001', N'TT001', N'', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1371, N'NV001', N'TT007', N'PH009', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1372, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1373, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1374, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1375, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1376, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-22T13:57:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1377, N'NV010', N'TT001', N'', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1378, N'NV010', N'TT007', N'PH010', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1379, N'NV010', N'TT007', N'PH009', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1380, N'NV010', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1381, N'NV010', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1382, N'NV010', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1383, N'NV010', N'TT002', N'Bia Tiger', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1384, N'NV010', N'TT002', N'Bò Khô', CAST(N'2019-06-22T14:20:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1385, N'NV010', N'TT001', N'', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1386, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1387, N'NV010', N'TT006', N'PH009', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1388, N'NV010', N'TT007', N'PH010', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1389, N'NV010', N'TT007', N'PH009', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1390, N'NV010', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1391, N'NV010', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1392, N'NV010', N'TT002', N'Bia Heineken', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1393, N'NV010', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1394, N'NV010', N'TT002', N'Bia Tiger', CAST(N'2019-06-22T14:26:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1395, N'NV001', N'TT001', N'', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1396, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1397, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1398, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1399, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1400, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1401, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T15:07:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1402, N'NV001', N'TT001', N'', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1403, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1404, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1405, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1406, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1407, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1408, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T15:11:54.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1409, N'NV001', N'TT001', N'', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1410, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1411, N'NV001', N'TT007', N'PH009', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1412, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1413, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1414, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1415, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1416, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-22T15:49:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1417, N'NV010', N'TT001', N'', CAST(N'2019-06-22T15:56:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1418, N'NV001', N'TT001', N'', CAST(N'2019-06-22T15:57:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1419, N'NV001', N'TT001', N'', CAST(N'2019-06-22T15:58:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1420, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:01:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1421, N'NV010', N'TT001', N'', CAST(N'2019-06-22T16:02:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1422, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:06:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1423, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T16:06:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1424, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-22T16:06:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1425, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T16:06:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1426, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-22T16:06:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1427, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-22T16:06:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1428, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:16:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1429, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:21:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1430, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T16:21:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1431, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-22T16:21:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1432, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:24:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1433, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:26:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1434, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-22T16:26:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1435, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-22T16:26:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1436, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-22T16:26:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1437, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-22T16:26:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1438, N'NV001', N'TT001', N'', CAST(N'2019-06-22T16:29:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1439, N'NV001', N'TT001', N'', CAST(N'2019-06-23T09:37:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1440, N'NV001', N'TT001', N'', CAST(N'2019-06-23T09:38:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1441, N'NV010', N'TT001', N'', CAST(N'2019-06-23T09:41:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1442, N'NV010', N'TT001', N'', CAST(N'2019-06-23T09:44:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1443, N'NV010', N'TT001', N'', CAST(N'2019-06-23T09:46:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1444, N'NV001', N'TT001', N'', CAST(N'2019-06-23T09:49:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1445, N'NV001', N'TT001', N'', CAST(N'2019-06-24T09:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1446, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-24T09:00:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1447, N'NV001', N'TT002', N'Nước cam ép', CAST(N'2019-06-24T09:01:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1448, N'NV001', N'TT002', N'Nước suối', CAST(N'2019-06-24T09:02:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1449, N'NV001', N'TT002', N'StrongBow vị Dâu', CAST(N'2019-06-24T09:02:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1450, N'NV001', N'TT001', N'', CAST(N'2019-06-24T09:10:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1451, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-24T09:10:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1452, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-24T09:10:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1453, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-24T09:11:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1454, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-24T09:11:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1455, N'NV001', N'TT001', N'', CAST(N'2019-06-24T09:17:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1456, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-24T09:17:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1457, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-24T09:17:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1458, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-24T09:17:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1459, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-24T09:17:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1460, N'NV001', N'TT001', N'', CAST(N'2019-06-24T09:20:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1461, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-24T09:20:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1462, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-24T09:21:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1463, N'NV001', N'TT001', N'', CAST(N'2019-06-24T09:23:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1464, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-24T09:24:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1465, N'NV001', N'TT001', N'', CAST(N'2019-06-25T14:25:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1466, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-25T14:25:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1467, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-25T14:25:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1468, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-25T14:25:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1469, N'NV001', N'TT001', N'', CAST(N'2019-06-25T14:33:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1470, N'NV001', N'TT001', N'', CAST(N'2019-06-25T14:57:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1471, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-25T14:57:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1472, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-25T14:57:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1473, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-25T14:57:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1474, N'NV001', N'TT002', N'Nước Aquafina Lít Rưỡi', CAST(N'2019-06-25T14:58:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1475, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-25T14:57:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1476, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-25T14:57:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1477, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-25T14:58:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1478, N'NV001', N'TT002', N'Đậu Phộng', CAST(N'2019-06-25T14:59:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1479, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-25T14:59:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1480, N'NV001', N'TT001', N'', CAST(N'2019-06-25T15:02:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1481, N'NV001', N'TT001', N'', CAST(N'2019-06-25T15:48:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1482, N'NV001', N'TT006', N'Thêm mới nhân viên NV017', CAST(N'2019-06-25T15:49:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1483, N'NV001', N'TT010', N'', CAST(N'2019-06-25T15:48:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1484, N'NV001', N'TT001', N'', CAST(N'2019-06-27T09:53:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1485, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-27T09:53:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1486, N'NV001', N'TT007', N'PH002', CAST(N'2019-06-27T09:53:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1487, N'NV001', N'TT001', N'', CAST(N'2019-06-27T09:54:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1488, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-27T09:54:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1489, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-27T09:54:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1490, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-06-27T09:54:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1491, N'NV001', N'TT006', N'PH002', CAST(N'2019-06-27T09:54:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1492, N'NV001', N'TT001', N'', CAST(N'2019-06-27T09:54:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1493, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-27T09:54:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1494, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-27T09:55:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1495, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-27T09:55:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1496, N'NV001', N'TT001', N'', CAST(N'2019-06-27T09:57:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1497, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-27T09:57:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1498, N'NV001', N'TT007', N'PH021', CAST(N'2019-06-27T09:57:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1499, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-27T09:58:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1500, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:03:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1501, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T10:04:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1502, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:05:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1503, N'NV001', N'TT002', N'Sting', CAST(N'2019-06-27T10:06:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1504, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:13:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1505, N'NV001', N'TT006', N'PH021', CAST(N'2019-06-27T10:13:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1506, N'NV001', N'TT007', N'PH021', CAST(N'2019-06-27T10:13:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1507, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-27T10:13:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1508, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:19:05.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1509, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T10:19:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1510, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-27T10:19:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1511, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:21:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1512, N'NV001', N'TT006', N'PH021', CAST(N'2019-06-27T10:21:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1513, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T10:21:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1514, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T10:21:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1515, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:28:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1516, N'NV001', N'TT011', N'PH021', CAST(N'2019-06-27T10:28:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1517, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-27T10:29:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1518, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-06-27T10:30:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1519, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:38:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1520, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T10:38:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1521, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T10:38:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1522, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-27T10:38:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1523, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:40:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1524, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T10:40:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1525, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T10:40:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1526, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T10:40:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1527, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:45:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1528, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T10:45:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1529, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T10:45:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1530, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:46:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1531, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T10:46:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1532, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T10:46:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1533, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-27T10:46:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1534, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1535, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-27T10:48:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1536, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T10:48:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1537, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:51:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1538, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T10:51:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1539, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T10:51:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1540, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:55:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1541, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-06-27T10:56:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1542, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-27T10:56:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1543, N'NV001', N'TT001', N'', CAST(N'2019-06-27T10:58:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1544, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-27T10:58:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1545, N'NV001', N'TT001', N'', CAST(N'2019-06-27T11:01:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1546, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-27T11:01:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1547, N'NV001', N'TT001', N'', CAST(N'2019-06-27T11:03:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1548, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T11:03:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1549, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T11:03:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1550, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-27T11:04:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1551, N'NV001', N'TT001', N'', CAST(N'2019-06-27T11:06:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1552, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-27T11:06:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1553, N'NV001', N'TT001', N'', CAST(N'2019-06-27T11:10:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1554, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-27T11:10:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1555, N'NV001', N'TT001', N'', CAST(N'2019-06-27T11:13:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1556, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T11:14:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1557, N'NV001', N'TT001', N'', CAST(N'2019-06-27T14:27:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1558, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T14:27:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1559, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T14:27:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1560, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-27T14:28:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1561, N'NV001', N'TT001', N'', CAST(N'2019-06-27T14:34:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1562, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-27T14:35:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1563, N'NV001', N'TT001', N'', CAST(N'2019-06-27T14:37:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1564, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-27T14:38:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1565, N'NV001', N'TT001', N'', CAST(N'2019-06-27T16:17:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1566, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-27T16:18:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1567, N'NV001', N'TT001', N'', CAST(N'2019-06-27T16:21:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1568, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T16:21:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1569, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T16:21:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1570, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-27T16:22:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1571, N'NV001', N'TT001', N'', CAST(N'2019-06-27T16:24:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1572, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-27T16:24:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1573, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-27T16:25:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1574, N'NV001', N'TT001', N'', CAST(N'2019-06-27T16:28:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1575, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T16:28:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1576, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T16:28:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1577, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-27T16:28:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1578, N'NV001', N'TT001', N'', CAST(N'2019-06-27T16:34:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1579, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-27T16:34:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1580, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-27T16:34:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1581, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-27T16:34:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1582, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:08:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1583, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T08:08:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1584, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:08:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1585, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T08:08:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1586, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-28T08:09:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1587, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:34:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1588, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-28T08:34:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1589, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:41:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1590, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T08:41:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1591, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T08:41:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1592, N'NV001', N'TT002', N'Đậu Phộng', CAST(N'2019-06-28T08:42:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1593, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-28T08:44:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1594, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:49:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1595, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-28T08:49:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1596, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:50:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1597, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T08:50:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1598, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T08:50:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1599, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-28T08:50:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1600, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-28T08:50:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1601, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:51:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1602, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-28T08:51:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1603, N'NV001', N'TT001', N'', CAST(N'2019-06-28T08:56:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1604, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T08:56:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1605, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T08:56:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1606, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-28T08:57:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1607, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-28T08:57:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1608, N'NV001', N'TT001', N'', CAST(N'2019-06-28T11:58:43.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1609, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T11:58:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1610, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-28T11:59:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1611, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:06:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1612, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T12:06:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1613, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T12:06:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1614, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-28T12:06:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1615, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-28T12:07:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1616, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-28T12:07:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1617, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1618, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-28T12:08:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1619, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T12:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1620, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:11:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1621, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T12:11:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1622, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-28T12:12:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1623, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-28T12:12:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1624, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:15:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1625, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-28T12:16:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1626, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:18:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1627, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T12:18:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1628, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T12:18:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1629, N'NV001', N'TT002', N'Đậu Phộng', CAST(N'2019-06-28T12:21:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1630, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:35:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1631, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:37:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1632, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:37:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1633, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:39:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1634, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:39:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1635, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:43:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1636, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T12:43:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1637, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T12:43:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1638, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-28T12:44:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1639, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:48:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1640, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T12:48:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1641, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T12:48:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1642, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-28T12:48:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1643, N'NV001', N'TT007', N'PH006', CAST(N'2019-06-28T12:48:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1644, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-06-28T12:48:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1645, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-28T12:49:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1646, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-28T12:48:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1647, N'NV001', N'TT006', N'PH006', CAST(N'2019-06-28T12:48:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1648, N'NV001', N'TT001', N'', CAST(N'2019-06-28T12:50:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1649, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-28T12:50:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1650, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-28T12:50:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1651, N'NV001', N'TT001', N'', CAST(N'2019-06-29T14:01:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (1652, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-29T14:01:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2651, N'NV001', N'TT001', N'', CAST(N'2019-06-29T16:51:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2652, N'NV001', N'TT008', N'xuống làm bếp', CAST(N'2019-06-29T16:51:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2653, N'NV003', N'TT001', N'', CAST(N'2019-06-29T16:52:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2654, N'NV001', N'TT001', N'', CAST(N'2019-06-29T17:09:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2655, N'NV001', N'TT001', N'', CAST(N'2019-06-29T17:10:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2656, N'NV010', N'TT001', N'', CAST(N'2019-06-29T17:10:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2657, N'NV010', N'TT002', N'Bún Bò', CAST(N'2019-06-29T17:10:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2658, N'NV010', N'TT007', N'PH003', CAST(N'2019-06-29T17:10:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2659, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-29T17:11:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2660, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-29T17:11:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2661, N'NV001', N'TT007', N'PH009', CAST(N'2019-06-29T17:10:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2662, N'NV010', N'TT007', N'PH006', CAST(N'2019-06-29T17:10:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2663, N'NV010', N'TT001', N'', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2664, N'NV001', N'TT001', N'', CAST(N'2019-06-29T17:12:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2665, N'NV001', N'TT007', N'PH007', CAST(N'2019-06-29T17:12:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2666, N'NV010', N'TT007', N'PH001', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2667, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2668, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-29T17:12:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2669, N'NV010', N'TT007', N'PH005', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2670, N'NV010', N'TT006', N'PH006', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2671, N'NV010', N'TT006', N'PH005', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2672, N'NV010', N'TT001', N'', CAST(N'2019-06-29T17:16:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2673, N'NV010', N'TT007', N'PH006', CAST(N'2019-06-29T17:16:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2674, N'NV010', N'TT007', N'PH005', CAST(N'2019-06-29T17:12:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2675, N'NV010', N'TT007', N'PH004', CAST(N'2019-06-29T17:16:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2676, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-29T17:16:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2677, N'NV001', N'TT001', N'', CAST(N'2019-06-29T17:18:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2678, N'NV010', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-29T17:18:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2679, N'NV010', N'TT001', N'', CAST(N'2019-06-29T17:18:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2680, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-06-29T17:19:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2681, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-29T17:19:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2682, N'NV010', N'TT006', N'PH006', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2683, N'NV010', N'TT006', N'PH005', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2684, N'NV010', N'TT006', N'PH004', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2685, N'NV010', N'TT006', N'PH003', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2686, N'NV010', N'TT006', N'PH009', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2687, N'NV010', N'TT006', N'PH001', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2688, N'NV010', N'TT006', N'PH007', CAST(N'2019-06-29T17:18:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2689, N'NV001', N'TT001', N'', CAST(N'2019-06-29T17:22:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2690, N'NV010', N'TT001', N'', CAST(N'2019-06-29T17:22:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2691, N'NV003', N'TT001', N'', CAST(N'2019-06-29T17:23:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2692, N'NV010', N'TT001', N'', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2693, N'NV010', N'TT007', N'PH010', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2694, N'NV010', N'TT007', N'PH008', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2695, N'NV010', N'TT006', N'PH010', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2696, N'NV010', N'TT006', N'PH008', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2697, N'NV010', N'TT007', N'PH004', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2698, N'NV010', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-29T19:32:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2699, N'NV010', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-29T19:32:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2700, N'NV010', N'TT006', N'PH004', CAST(N'2019-06-29T19:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2701, N'NV001', N'TT001', N'', CAST(N'2019-06-29T21:09:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2702, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-29T21:09:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2703, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-29T21:11:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2704, N'NV001', N'TT001', N'', CAST(N'2019-06-30T01:57:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2705, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:05:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2706, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-30T02:05:11.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2707, N'NV001', N'TT007', N'PH010', CAST(N'2019-06-30T02:05:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2708, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:07:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2709, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:08:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2710, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:10:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2711, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:14:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2712, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:17:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2713, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:23:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2714, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-30T02:23:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2715, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-30T02:23:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2716, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:26:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2717, N'NV001', N'TT007', N'PH002', CAST(N'2019-06-30T02:26:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2718, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:27:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2719, N'NV001', N'TT007', N'PH003', CAST(N'2019-06-30T02:27:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2720, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-30T02:28:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2721, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:30:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2722, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:30:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2723, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:33:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2724, N'NV001', N'TT003', N'Bánh Poca vị bò', CAST(N'2019-06-30T02:33:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2725, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-30T02:33:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2726, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-06-30T02:34:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2727, N'NV001', N'TT002', N'Bánh Poca vị tảo biển', CAST(N'2019-06-30T02:34:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2728, N'NV001', N'TT002', N'Trái Cây Dĩa', CAST(N'2019-06-30T02:34:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2729, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2730, N'NV001', N'TT003', N'Bánh Poca vị tảo biển', CAST(N'2019-06-30T02:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2731, N'NV001', N'TT003', N'Bánh Poca vị bò', CAST(N'2019-06-30T02:35:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2732, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:36:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2733, N'NV001', N'TT002', N'Bò Khô', CAST(N'2019-06-30T02:36:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2734, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-06-30T02:36:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2735, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-06-30T02:37:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2736, N'NV001', N'TT003', N'Bánh Poca vị muối', CAST(N'2019-06-30T02:36:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2737, N'NV001', N'TT003', N'Bò Khô', CAST(N'2019-06-30T02:36:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2738, N'NV001', N'TT003', N'Trái Cây Dĩa', CAST(N'2019-06-30T02:36:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2739, N'NV001', N'TT003', N'Coca Cola', CAST(N'2019-06-30T02:36:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2740, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:38:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2741, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:50:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2742, N'NV001', N'TT002', N'Bánh Snack', CAST(N'2019-06-30T02:50:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2743, N'NV001', N'TT001', N'', CAST(N'2019-06-30T02:58:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2744, N'NV001', N'TT001', N'', CAST(N'2019-06-30T03:00:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2745, N'NV001', N'TT001', N'', CAST(N'2019-06-30T03:02:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2746, N'NV001', N'TT001', N'', CAST(N'2019-06-30T03:05:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2747, N'NV001', N'TT002', N'Bia Heineken', CAST(N'2019-06-30T03:05:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2748, N'NV001', N'TT002', N'Bia Sài Gòn', CAST(N'2019-06-30T03:05:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2749, N'NV001', N'TT001', N'', CAST(N'2019-06-30T09:51:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2750, N'NV001', N'TT006', N'PH003', CAST(N'2019-06-30T09:51:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2751, N'NV001', N'TT006', N'PH002', CAST(N'2019-06-30T09:51:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2752, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-30T09:51:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2753, N'NV001', N'TT001', N'', CAST(N'2019-06-30T09:53:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2754, N'NV001', N'TT001', N'', CAST(N'2019-06-30T09:57:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2755, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:07:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2756, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:09:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2757, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:13:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2758, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:18:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2759, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:31:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2760, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:39:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2761, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:40:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2762, N'NV001', N'TT006', N'PH010', CAST(N'2019-06-30T10:40:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2763, N'NV001', N'TT006', N'PH009', CAST(N'2019-06-30T10:40:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2764, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:45:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2765, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:46:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2766, N'NV001', N'TT002', N'Giờ Hát', CAST(N'2019-06-30T10:47:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2767, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:48:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2768, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:50:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2769, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:55:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2770, N'NV001', N'TT006', N'PH001', CAST(N'2019-06-30T10:55:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2771, N'NV001', N'TT007', N'PH001', CAST(N'2019-06-30T10:55:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2772, N'NV001', N'TT001', N'', CAST(N'2019-06-30T10:58:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2773, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-06-30T10:59:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2774, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-06-30T10:59:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2775, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-06-30T10:59:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2776, N'NV001', N'TT006', N'PH002', CAST(N'2019-06-30T10:58:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (2777, N'NV001', N'TT010', N'', CAST(N'2019-06-30T10:58:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3765, N'NV001', N'TT001', N'', CAST(N'2019-07-01T02:00:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3766, N'NV001', N'TT007', N'PH002', CAST(N'2019-07-01T02:00:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3767, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-07-01T02:01:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3768, N'NV001', N'TT002', N'Bánh Poca vị muối', CAST(N'2019-07-01T02:01:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3769, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-07-01T02:01:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3770, N'NV001', N'TT002', N'Cơm Cháy', CAST(N'2019-07-01T02:01:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3771, N'NV001', N'TT003', N'Cơm Cháy', CAST(N'2019-07-01T02:00:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3772, N'NV001', N'TT003', N'Bún Bò', CAST(N'2019-07-01T02:00:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3773, N'NV001', N'TT001', N'', CAST(N'2019-07-01T02:04:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3774, N'NV001', N'TT001', N'', CAST(N'2019-07-01T02:06:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3775, N'NV001', N'TT001', N'', CAST(N'2019-07-01T02:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3776, N'NV001', N'TT007', N'PH005', CAST(N'2019-07-01T02:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3777, N'NV001', N'TT006', N'PH003', CAST(N'2019-07-01T02:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3778, N'NV001', N'TT006', N'PH004', CAST(N'2019-07-01T02:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3779, N'NV001', N'TT007', N'PH006', CAST(N'2019-07-01T02:08:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3780, N'NV001', N'TT001', N'', CAST(N'2019-07-01T02:10:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3781, N'NV001', N'TT002', N'Bia Tiger', CAST(N'2019-07-01T02:11:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3782, N'NV001', N'TT002', N'Coca Cola', CAST(N'2019-07-01T02:11:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3783, N'NV001', N'TT002', N'Bún Bò', CAST(N'2019-07-01T02:11:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3784, N'NV001', N'TT003', N'Bánh Ngọt', CAST(N'2019-07-01T02:10:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3785, N'NV001', N'TT003', N'Bánh Poca vị muối', CAST(N'2019-07-01T02:10:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3786, N'NV001', N'TT001', N'', CAST(N'2019-07-01T10:52:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3787, N'NV001', N'TT007', N'PH003', CAST(N'2019-07-01T10:52:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3788, N'NV001', N'TT002', N'Bánh Ngọt', CAST(N'2019-07-01T10:53:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3789, N'NV001', N'TT002', N'Bánh Poca vị bò', CAST(N'2019-07-01T10:53:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3790, N'NV001', N'TT001', N'', CAST(N'2019-07-01T10:59:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3791, N'NV001', N'TT001', N'', CAST(N'2019-07-01T11:10:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3792, N'NV001', N'TT001', N'', CAST(N'2019-07-01T11:12:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3793, N'NV001', N'TT001', N'', CAST(N'2019-07-01T11:13:20.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3794, N'NV001', N'TT001', N'', CAST(N'2019-07-01T13:35:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3795, N'NV001', N'TT001', N'', CAST(N'2019-07-02T09:03:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3796, N'NV001', N'TT001', N'', CAST(N'2019-07-02T10:30:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3797, N'NV001', N'TT008', N'sửa thông tin loại tài khoản', CAST(N'2019-07-02T10:30:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3798, N'NV001', N'TT008', N'ssss', CAST(N'2019-07-02T10:30:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3799, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:16:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3800, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:20:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3801, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:22:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3802, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:26:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3803, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:28:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3804, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:30:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3805, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:33:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3806, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:43:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3807, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:48:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3808, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:49:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3809, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:53:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3810, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:57:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3811, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:57:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3812, N'NV001', N'TT001', N'', CAST(N'2019-07-04T11:58:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3813, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:00:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3814, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:02:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3815, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:06:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3816, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:07:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3817, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:09:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3818, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:11:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3819, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:25:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3820, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:26:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3821, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:30:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3822, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:32:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3823, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:33:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3824, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:34:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3825, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:34:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3826, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:36:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3827, N'NV001', N'TT001', N'', CAST(N'2019-07-04T12:40:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3828, N'NV001', N'TT001', N'', CAST(N'2019-07-04T13:00:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3829, N'NV001', N'TT001', N'', CAST(N'2019-07-04T16:31:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3830, N'NV001', N'TT001', N'', CAST(N'2019-07-04T16:46:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3831, N'NV001', N'TT001', N'', CAST(N'2019-07-04T16:48:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3832, N'NV001', N'TT001', N'', CAST(N'2019-07-04T16:49:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3833, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:05:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3834, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:08:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3835, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:09:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3836, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:10:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3837, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:12:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3838, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:13:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3839, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:19:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3840, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:21:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3841, N'NV001', N'TT001', N'', CAST(N'2019-07-04T17:28:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3842, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:27:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3843, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:29:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3844, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:34:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3845, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:35:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3846, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:37:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3847, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3848, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3849, N'NV001', N'TT006', N'PH001', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3850, N'NV001', N'TT007', N'PH002', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3851, N'NV001', N'TT006', N'PH002', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3852, N'NV001', N'TT007', N'PH003', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3853, N'NV001', N'TT006', N'PH003', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3854, N'NV001', N'TT007', N'PH005', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3855, N'NV001', N'TT006', N'PH005', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3856, N'NV001', N'TT007', N'PH006', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3857, N'NV001', N'TT006', N'PH006', CAST(N'2019-07-05T01:41:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3858, N'NV001', N'TT001', N'', CAST(N'2019-07-05T01:56:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3859, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T01:56:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3860, N'NV001', N'TT002', N'DV001', CAST(N'2019-07-05T01:56:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3861, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T01:57:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3862, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-05T01:57:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3863, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:02:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3864, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:03:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3865, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:11:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3866, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:31:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3867, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T02:31:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3868, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T02:32:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3869, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T02:32:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3870, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-05T02:32:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3871, N'NV001', N'TT002', N'DV008', CAST(N'2019-07-05T02:32:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3872, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:41:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3873, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T02:41:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3874, N'NV001', N'TT002', N'DV001', CAST(N'2019-07-05T02:41:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3875, N'NV001', N'TT002', N'DV004', CAST(N'2019-07-05T02:41:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3876, N'NV001', N'TT006', N'PH001', CAST(N'2019-07-05T02:41:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3877, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:43:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3878, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T02:43:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3879, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T02:44:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3880, N'NV001', N'TT006', N'PH001', CAST(N'2019-07-05T02:43:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3881, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:46:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3882, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T02:46:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3883, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:48:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3884, N'NV001', N'TT006', N'PH001', CAST(N'2019-07-05T02:48:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3885, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T02:48:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3886, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T02:48:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3887, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T02:49:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3888, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T02:49:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3889, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-05T02:49:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3890, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-05T02:49:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3891, N'NV001', N'TT001', N'', CAST(N'2019-07-05T02:53:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3892, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T02:53:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3893, N'NV001', N'TT011', N'PH022', CAST(N'2019-07-05T02:53:06.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3894, N'NV001', N'TT002', N'DV008', CAST(N'2019-07-05T02:53:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3895, N'NV001', N'TT002', N'DV010', CAST(N'2019-07-05T02:53:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3896, N'NV001', N'TT001', N'', CAST(N'2019-07-05T03:04:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3897, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T03:04:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3898, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-05T03:04:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3899, N'NV001', N'TT002', N'DV005', CAST(N'2019-07-05T03:05:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3900, N'NV001', N'TT001', N'', CAST(N'2019-07-05T03:19:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3901, N'NV001', N'TT007', N'PH002', CAST(N'2019-07-05T03:19:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3902, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T03:19:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3903, N'NV001', N'TT007', N'PH003', CAST(N'2019-07-05T03:19:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3904, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-05T03:19:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3905, N'NV001', N'TT002', N'DV009', CAST(N'2019-07-05T03:20:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3906, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-05T03:20:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3907, N'NV001', N'TT002', N'DV011', CAST(N'2019-07-05T03:21:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3908, N'NV001', N'TT002', N'DV013', CAST(N'2019-07-05T03:21:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3909, N'NV001', N'TT003', N'DV002', CAST(N'2019-07-05T03:19:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3910, N'NV001', N'TT007', N'Xóa nhân viên NV017', CAST(N'2019-07-05T03:19:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3911, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:18:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3912, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:22:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3913, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:23:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3914, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:23:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3915, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:29:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3916, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:30:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3917, N'NV001', N'TT007', N'PH003', CAST(N'2019-07-05T08:30:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3918, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-05T08:31:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3919, N'NV001', N'TT002', N'DV012', CAST(N'2019-07-05T08:31:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3920, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:33:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3921, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:34:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3922, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:56:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3923, N'NV001', N'TT001', N'', CAST(N'2019-07-05T08:59:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3924, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:03:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3925, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:05:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3926, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:08:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3927, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:11:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3928, N'NV001', N'TT008', N'', CAST(N'2019-07-05T09:11:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3929, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:14:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3930, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:15:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3931, N'NV001', N'TT007', N'PH003', CAST(N'2019-07-05T09:15:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3932, N'NV001', N'TT002', N'DV009', CAST(N'2019-07-05T09:15:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3933, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:22:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3934, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:24:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3935, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:26:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3936, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:27:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3937, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-05T09:27:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3938, N'NV001', N'TT002', N'DV008', CAST(N'2019-07-05T09:27:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3939, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:28:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3940, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:36:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3941, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:39:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3942, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:53:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3943, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:54:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3944, N'NV001', N'TT001', N'', CAST(N'2019-07-05T09:56:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3945, N'NV001', N'TT001', N'', CAST(N'2019-07-05T11:02:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3946, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:36:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3947, N'NV001', N'TT006', N'PH010', CAST(N'2019-07-05T12:36:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3948, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:37:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3949, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:37:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3950, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:39:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3951, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-05T12:39:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3952, N'NV001', N'TT006', N'PH010', CAST(N'2019-07-05T12:39:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3953, N'NV010', N'TT001', N'', CAST(N'2019-07-05T12:40:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3954, N'NV010', N'TT007', N'PH006', CAST(N'2019-07-05T12:40:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3955, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:46:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3956, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:47:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3957, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:48:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3958, N'NV010', N'TT001', N'', CAST(N'2019-07-05T12:49:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3959, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:54:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3960, N'NV001', N'TT001', N'', CAST(N'2019-07-05T12:58:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3961, N'NV001', N'TT001', N'', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3962, N'NV001', N'TT006', N'PH006', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3963, N'NV001', N'TT006', N'PH003', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3964, N'NV001', N'TT006', N'PH002', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3965, N'NV001', N'TT006', N'PH001', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3966, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3967, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-05T14:29:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3968, N'NV001', N'TT002', N'DV008', CAST(N'2019-07-05T14:29:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3969, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-05T14:29:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3970, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-05T14:29:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3971, N'NV001', N'TT003', N'DV008', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3972, N'NV001', N'TT006', N'PH010', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3973, N'NV001', N'TT006', N'Thêm mới nhân viên NV018', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3974, N'NV001', N'TT008', N'', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3975, N'NV001', N'TT008', N'dsadasd', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3976, N'NV001', N'TT007', N'Xóa nhân viên NV018', CAST(N'2019-07-05T14:27:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3977, N'NV001', N'TT001', N'', CAST(N'2019-07-05T14:41:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3978, N'NV001', N'TT001', N'', CAST(N'2019-07-05T18:58:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3979, N'NV001', N'TT001', N'', CAST(N'2019-07-06T12:00:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3980, N'NV001', N'TT001', N'', CAST(N'2019-07-07T14:06:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3981, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-07T14:06:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3982, N'NV001', N'TT002', N'DV008', CAST(N'2019-07-07T14:06:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3983, N'NV001', N'TT001', N'', CAST(N'2019-07-07T14:08:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3984, N'NV001', N'TT001', N'', CAST(N'2019-07-07T14:43:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3985, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-07T14:43:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3986, N'NV001', N'TT002', N'DV015', CAST(N'2019-07-07T14:43:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3987, N'NV010', N'TT001', N'', CAST(N'2019-07-07T14:45:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3988, N'NV010', N'TT006', N'PH010', CAST(N'2019-07-07T14:45:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3989, N'NV001', N'TT001', N'', CAST(N'2019-07-07T14:58:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3990, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-07T14:58:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3991, N'NV001', N'TT002', N'DV009', CAST(N'2019-07-07T14:59:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3992, N'NV001', N'TT002', N'DV015', CAST(N'2019-07-07T14:59:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3993, N'NV010', N'TT001', N'', CAST(N'2019-07-07T15:00:03.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3994, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:00:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3995, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:03:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3996, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-07T15:03:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3997, N'NV001', N'TT002', N'DV011', CAST(N'2019-07-07T15:03:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3998, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:05:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (3999, N'NV001', N'TT007', N'PH006', CAST(N'2019-07-07T15:05:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4000, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-07T15:05:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4001, N'NV001', N'TT007', N'PH006', CAST(N'2019-07-07T15:05:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4002, N'NV001', N'TT002', N'DV009', CAST(N'2019-07-07T15:06:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4003, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:07:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4004, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-07T15:07:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4005, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-07T15:08:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4006, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:10:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4007, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:18:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4008, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:20:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4009, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:22:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4010, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-07T15:22:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4011, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-07T15:22:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4012, N'NV010', N'TT001', N'', CAST(N'2019-07-07T15:22:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4013, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:23:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4014, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:24:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4015, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:27:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4016, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:27:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4017, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-07T15:27:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4018, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4019, N'NV001', N'TT006', N'PH010', CAST(N'2019-07-07T15:28:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4020, N'NV010', N'TT001', N'', CAST(N'2019-07-07T15:30:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4021, N'NV010', N'TT007', N'PH009', CAST(N'2019-07-07T15:30:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4022, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:30:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4023, N'NV001', N'TT002', N'DV011', CAST(N'2019-07-07T15:30:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4024, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:31:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4025, N'NV010', N'TT001', N'', CAST(N'2019-07-07T15:31:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4026, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:31:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4027, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:34:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4028, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:35:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4029, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:36:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4030, N'NV001', N'TT007', N'PH010', CAST(N'2019-07-07T15:36:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4031, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:38:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4032, N'NV001', N'TT006', N'PH010', CAST(N'2019-07-07T15:38:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4033, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-07T15:38:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4034, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:40:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4035, N'NV001', N'TT001', N'', CAST(N'2019-07-07T15:41:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4036, N'NV001', N'TT007', N'PH005', CAST(N'2019-07-07T15:41:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4037, N'NV001', N'TT007', N'PH006', CAST(N'2019-07-07T15:41:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4038, N'NV001', N'TT001', N'', CAST(N'2019-07-07T16:05:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4039, N'NV001', N'TT001', N'', CAST(N'2019-07-07T16:05:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4040, N'NV001', N'TT001', N'', CAST(N'2019-07-07T16:08:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4041, N'NV001', N'TT007', N'PH004', CAST(N'2019-07-07T16:08:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4042, N'NV001', N'TT001', N'', CAST(N'2019-07-07T16:11:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4043, N'NV001', N'TT007', N'PH002', CAST(N'2019-07-07T16:11:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4044, N'NV001', N'TT006', N'PH002', CAST(N'2019-07-07T16:11:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4045, N'NV001', N'TT007', N'PH002', CAST(N'2019-07-07T16:11:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4046, N'NV001', N'TT001', N'', CAST(N'2019-07-07T23:55:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4047, N'NV001', N'TT002', N'DV016', CAST(N'2019-07-07T23:55:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4048, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:01:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4049, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:01:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4050, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:02:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4051, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:02:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4052, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:05:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4053, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-08T00:05:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4054, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-08T00:05:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4055, N'NV001', N'TT002', N'DV010', CAST(N'2019-07-08T00:05:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4056, N'NV001', N'TT002', N'DV012', CAST(N'2019-07-08T00:06:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4057, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:07:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4058, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:08:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4059, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:09:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4060, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:10:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4061, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:12:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4062, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:17:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4063, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:19:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4064, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:21:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4065, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:22:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4066, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:23:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4067, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-08T00:23:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4068, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-08T00:23:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4069, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-08T00:23:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4070, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:24:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4071, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:27:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4072, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-08T00:28:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4073, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:29:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4074, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:30:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4075, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:31:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4076, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-08T00:31:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4077, N'NV001', N'TT002', N'DV008', CAST(N'2019-07-08T00:31:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4078, N'NV001', N'TT002', N'DV011', CAST(N'2019-07-08T00:31:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4079, N'NV001', N'TT002', N'DV014', CAST(N'2019-07-08T00:32:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4080, N'NV001', N'TT002', N'DV025', CAST(N'2019-07-08T00:32:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4081, N'NV001', N'TT002', N'DV023', CAST(N'2019-07-08T00:32:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4082, N'NV001', N'TT002', N'DV022', CAST(N'2019-07-08T00:32:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4083, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:35:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4084, N'NV001', N'TT007', N'PH001', CAST(N'2019-07-08T00:35:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4085, N'NV001', N'TT007', N'PH003', CAST(N'2019-07-08T00:35:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4086, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-08T00:38:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4087, N'NV001', N'TT002', N'DV007', CAST(N'2019-07-08T00:38:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4088, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:41:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4089, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:47:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4090, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:47:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4091, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:51:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4092, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:54:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4093, N'NV001', N'TT007', N'PH004', CAST(N'2019-07-08T00:54:14.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4094, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-08T00:54:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4095, N'NV001', N'TT002', N'DV003', CAST(N'2019-07-08T00:54:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4096, N'NV001', N'TT002', N'DV004', CAST(N'2019-07-08T00:55:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4097, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:56:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4098, N'NV001', N'TT001', N'', CAST(N'2019-07-08T00:58:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4099, N'NV001', N'TT007', N'PH005', CAST(N'2019-07-08T00:58:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4100, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:01:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4101, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:04:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4102, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:05:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4103, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:05:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4104, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:07:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4105, N'NV001', N'TT002', N'DV002', CAST(N'2019-07-08T01:08:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4106, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:09:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4107, N'NV001', N'TT002', N'DV005', CAST(N'2019-07-08T01:09:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4108, N'NV001', N'TT002', N'DV006', CAST(N'2019-07-08T01:09:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4109, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:13:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4110, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:16:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4111, N'NV001', N'TT007', N'PH006', CAST(N'2019-07-08T01:16:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4112, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:19:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4113, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:23:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4114, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:27:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4115, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:34:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4116, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào ', CAST(N'2019-07-08T01:34:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4117, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:35:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4118, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Tên Phòng', CAST(N'2019-07-08T01:36:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4119, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:40:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4120, N'NV001', N'TT002', N'NV001 thêm món Phồng Tôm vào Phòng 6', CAST(N'2019-07-08T01:41:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4121, N'NV001', N'TT002', N'NV001 thêm món Nước suối vào Phòng 6', CAST(N'2019-07-08T01:41:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4122, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:42:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4123, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:44:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4124, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:46:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4125, N'NV001', N'TT003', N'NV001 xóa món Bò Khô tại Phòng 5', CAST(N'2019-07-08T01:46:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4126, N'NV001', N'TT003', N'NV001 xóa món Phồng Tôm tại Phòng 6', CAST(N'2019-07-08T01:46:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4127, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:50:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4128, N'NV001', N'TT003', N'NV001 xóa món Coca Cola tại Phòng 6', CAST(N'2019-07-08T01:50:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4129, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:51:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4130, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 6', CAST(N'2019-07-08T01:51:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4131, N'NV001', N'TT002', N'NV001 thêm món Phồng Tôm vào Phòng 6', CAST(N'2019-07-08T01:51:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4132, N'NV001', N'TT003', N'NV001 xóa món Phồng Tôm tại Phòng 6', CAST(N'2019-07-08T01:51:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4133, N'NV001', N'TT003', N'NV001 xóa món Bánh Snack tại Phòng 6', CAST(N'2019-07-08T01:51:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4134, N'NV001', N'TT001', N'', CAST(N'2019-07-08T01:56:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4135, N'NV001', N'TT007', N'PH004', CAST(N'2019-07-08T01:56:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4136, N'NV001', N'TT006', N'NV001 xóa hóa đơn HD032 của Phòng 4', CAST(N'2019-07-08T01:56:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4137, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:09:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4138, N'NV001', N'TT007', N'NV001 mở Phòng 4', CAST(N'2019-07-08T02:09:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4139, N'NV001', N'TT007', N'NV001 mở Phòng 3', CAST(N'2019-07-08T02:09:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4140, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 4', CAST(N'2019-07-08T02:09:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4141, N'NV001', N'TT002', N'NV001 thêm món Phồng Tôm vào Phòng 4', CAST(N'2019-07-08T02:09:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4142, N'NV001', N'TT002', N'NV001 thêm món Nước suối vào Phòng 4', CAST(N'2019-07-08T02:09:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4143, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 3', CAST(N'2019-07-08T02:09:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4144, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:12:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4145, N'NV001', N'TT013', N'', CAST(N'2019-07-08T02:12:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4146, N'NV001', N'TT013', N'', CAST(N'2019-07-08T02:13:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4147, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:14:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4148, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:14:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4149, N'NV001', N'TT013', N'', CAST(N'2019-07-08T02:15:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4150, N'NV001', N'TT013', N'', CAST(N'2019-07-08T02:15:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4151, N'NV001', N'TT013', N'', CAST(N'2019-07-08T02:15:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4152, N'NV001', N'TT014', N'Hạ chức', CAST(N'2019-07-08T02:16:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4153, N'NV001', N'TT013', N'', CAST(N'2019-07-08T02:17:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4154, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:20:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4155, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán cho hóa đơn HD031 cho Phòng 6', CAST(N'2019-07-08T02:20:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4156, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:39:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4157, N'NV001', N'TT002', N'NV001 thêm món Phồng Tôm vào Phòng 5', CAST(N'2019-07-08T02:39:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4158, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:44:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4159, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:45:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4160, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:47:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4161, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:49:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4162, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:50:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4163, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:51:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4164, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:52:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4165, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:54:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4166, N'NV001', N'TT001', N'', CAST(N'2019-07-08T02:55:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4167, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:00:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4168, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 4', CAST(N'2019-07-08T03:00:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4169, N'NV001', N'TT003', N'NV001 xóa món Pepsi tại Phòng 4', CAST(N'2019-07-08T03:01:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4170, N'NV001', N'TT003', N'NV001 xóa món Phồng Tôm tại Phòng 4', CAST(N'2019-07-08T03:01:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4171, N'NV001', N'TT003', N'NV001 xóa món Phồng Tôm tại Phòng 5', CAST(N'2019-07-08T03:02:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4172, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:09:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4173, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:14:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4174, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:15:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4175, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:19:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4177, N'NV001', N'TT002', N'NV001 thêm món Bia Heineken vào Phòng 5', CAST(N'2019-07-08T03:21:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4179, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:25:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4180, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Bia Heinekenvới số lượng 4', CAST(N'2019-07-08T03:25:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4181, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Bia Heinekenvới số lượng 5', CAST(N'2019-07-08T03:25:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4182, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:26:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4183, N'NV001', N'TT007', N'NV001 mở Phòng 6', CAST(N'2019-07-08T03:26:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4184, N'NV001', N'TT002', N'NV001 thêm món Bánh Ngọt vào Phòng 6', CAST(N'2019-07-08T03:26:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4185, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 6', CAST(N'2019-07-08T03:26:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4186, N'NV001', N'TT002', N'NV001 thêm món Cơm Cháy vào Phòng 6', CAST(N'2019-07-08T03:27:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4187, N'NV001', N'TT002', N'NV001 thêm món Bò Khô vào Phòng 6', CAST(N'2019-07-08T03:27:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4188, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:30:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4189, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Cơm Cháyvới số lượng 1', CAST(N'2019-07-08T03:31:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4190, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Cơm Cháyvới số lượng 1', CAST(N'2019-07-08T03:31:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4191, N'NV001', N'TT017', N'Khách PH006 gọi món Bò Khôvới số lượng 1', CAST(N'2019-07-08T03:31:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4192, N'NV001', N'TT017', N'Khách PH006 gọi món Bò Khôvới số lượng 1', CAST(N'2019-07-08T03:31:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4193, N'NV001', N'TT017', N'Khách PH006 gọi món Bánh Ngọtvới số lượng 2', CAST(N'2019-07-08T03:31:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4194, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Bánh Snackvới số lượng 2', CAST(N'2019-07-08T03:31:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4195, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:38:33.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4196, N'NV001', N'TT018', N'Khách phòng PH006 trả món Bò Khô với số lượng 10', CAST(N'2019-07-08T03:38:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4197, N'NV001', N'TT002', N'NV001 thêm món Đậu Phộng vào Phòng 6', CAST(N'2019-07-08T03:39:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4198, N'NV001', N'TT018', N'Khách phòng PH006 trả món  với số lượng 1', CAST(N'2019-07-08T03:39:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4199, N'NV001', N'TT018', N'Khách phòng PH006 trả món  với số lượng 1', CAST(N'2019-07-08T03:39:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4200, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Bò Khô với số lượng 1', CAST(N'2019-07-08T03:39:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4201, N'NV001', N'TT018', N'Khách phòng PH006 trả món  với số lượng 1', CAST(N'2019-07-08T03:39:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4202, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Cơm Cháy với số lượng 2', CAST(N'2019-07-08T03:39:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4203, N'NV001', N'TT018', N'Khách phòng PH006 trả món Đậu Phộng với số lượng 1', CAST(N'2019-07-08T03:39:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4204, N'NV001', N'TT003', N'NV001 xóa món Đậu Phộng tại Phòng 6', CAST(N'2019-07-08T03:40:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4205, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:43:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4206, N'NV001', N'TT002', N'NV001 thêm món Phồng Tôm vào Phòng 6', CAST(N'2019-07-08T03:43:27.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4207, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 6', CAST(N'2019-07-08T03:43:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4208, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Phồng Tôm với số lượng 5', CAST(N'2019-07-08T03:43:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4209, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Bò Khô với số lượng 3', CAST(N'2019-07-08T03:43:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4210, N'NV001', N'TT018', N'Khách phòng PH006 trả món Bò Khô với số lượng 3', CAST(N'2019-07-08T03:44:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4211, N'NV001', N'TT018', N'Khách phòng PH006 trả món Bò Khô với số lượng 3', CAST(N'2019-07-08T03:44:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4212, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:49:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4213, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:50:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4214, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:52:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4215, N'NV001', N'TT001', N'', CAST(N'2019-07-08T03:54:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4216, N'NV001', N'TT018', N'Khách phòng PH004 trả món Bánh Snack với số lượng 10', CAST(N'2019-07-08T03:54:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4217, N'NV001', N'TT017', N'Khách phòng PH004 gọi món Bánh Snack với số lượng 11', CAST(N'2019-07-08T03:54:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4218, N'NV001', N'TT018', N'Khách phòng PH004 trả món Bánh Snack với số lượng 20', CAST(N'2019-07-08T03:54:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4219, N'NV001', N'TT018', N'Khách phòng PH004 trả món Nước suối với số lượng 2', CAST(N'2019-07-08T03:55:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4220, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:02:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4221, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:03:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4222, N'NV001', N'TT002', N'NV001 thêm món Đậu Phộng vào Phòng 5', CAST(N'2019-07-08T04:03:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4223, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Đậu Phộng với số lượng 1', CAST(N'2019-07-08T04:03:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4224, N'NV001', N'TT017', N'Khách phòng PH006 gọi món Bò Khô với số lượng 44', CAST(N'2019-07-08T04:04:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4225, N'NV001', N'TT018', N'Khách phòng PH006 trả món Bò Khô với số lượng 40', CAST(N'2019-07-08T04:04:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4226, N'NV001', N'TT003', N'NV001 xóa món Pepsi tại Phòng 6', CAST(N'2019-07-08T04:04:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4227, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:05:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4228, N'NV001', N'TT003', N'NV001 xóa món Cơm Cháy tại Phòng 6', CAST(N'2019-07-08T04:05:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4229, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:06:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4230, N'NV001', N'TT003', N'NV001 xóa món Phồng Tôm tại Phòng 6', CAST(N'2019-07-08T04:06:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4231, N'NV001', N'TT003', N'NV001 xóa món Bánh Snack tại Phòng 6', CAST(N'2019-07-08T04:06:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4232, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:07:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4233, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Đậu Phộng với số lượng 4', CAST(N'2019-07-08T04:07:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4234, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 5', CAST(N'2019-07-08T04:07:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4235, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Bánh Snack với số lượng 2', CAST(N'2019-07-08T04:07:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4236, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:10:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4237, N'NV001', N'TT017', N'Khách phòng PH004 gọi món Nước suối với số lượng 5', CAST(N'2019-07-08T04:10:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4238, N'NV001', N'TT018', N'Khách phòng PH004 trả món Nước suối với số lượng 2', CAST(N'2019-07-08T04:10:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4239, N'NV001', N'TT002', N'NV001 thêm món Bánh Ngọt vào Phòng 4', CAST(N'2019-07-08T04:10:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4240, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:12:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4241, N'NV001', N'TT017', N'Khách phòng PH004 gọi món Nước suối với số lượng 1', CAST(N'2019-07-08T04:12:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4242, N'NV001', N'TT018', N'Khách phòng PH004 trả món Nước suối với số lượng 4', CAST(N'2019-07-08T04:12:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4243, N'NV001', N'TT017', N'Khách phòng PH004 gọi món Nước suối với số lượng 4', CAST(N'2019-07-08T04:12:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4244, N'NV001', N'TT018', N'Khách phòng PH004 trả món Nước suối với số lượng 5', CAST(N'2019-07-08T04:12:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4245, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:17:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4246, N'NV001', N'TT013', N'', CAST(N'2019-07-08T04:18:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4247, N'NV001', N'TT013', N'', CAST(N'2019-07-08T04:19:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4248, N'NV001', N'TT013', N'', CAST(N'2019-07-08T04:20:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4249, N'NV001', N'TT006', N'Thêm mới nhân viên NV019', CAST(N'2019-07-08T04:20:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4250, N'NV001', N'TT013', N'', CAST(N'2019-07-08T04:21:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4251, N'NV001', N'TT013', N'', CAST(N'2019-07-08T04:22:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4252, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:33:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4253, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:37:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4254, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: Cổ điển
Lầu 1', CAST(N'2019-07-08T04:38:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4255, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:39:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4256, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: Cổ điển
Lầu 1', CAST(N'2019-07-08T04:39:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4257, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:40:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4258, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:41:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4259, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD033 cho Phòng 4', CAST(N'2019-07-08T04:41:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4260, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD030 cho Phòng 5', CAST(N'2019-07-08T04:41:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4261, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD035 cho Phòng 6', CAST(N'2019-07-08T04:42:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4262, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4263, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4264, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4265, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4266, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4267, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4268, N'NV001', N'TT009', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', CAST(N'2019-07-08T04:42:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4269, N'NV001', N'TT007', N'NV001 mở Phòng 3', CAST(N'2019-07-08T04:43:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4270, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:44:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4271, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD036', CAST(N'2019-07-08T04:47:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4272, N'NV001', N'TT001', N'', CAST(N'2019-07-08T04:48:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4273, N'NV001', N'TT001', N'', CAST(N'2019-07-08T07:41:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4274, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T07:42:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4275, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD037', CAST(N'2019-07-08T07:42:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4276, N'NV001', N'TT001', N'', CAST(N'2019-07-08T07:43:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4277, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD036', CAST(N'2019-07-08T07:43:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4278, N'NV001', N'TT001', N'', CAST(N'2019-07-08T07:43:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4279, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD036 cho Phòng 3', CAST(N'2019-07-08T07:43:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4280, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 10', CAST(N'2019-07-08T07:44:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4281, N'NV001', N'TT017', N'Khách PH010 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:44:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4282, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD037 cho Phòng 10', CAST(N'2019-07-08T07:45:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4283, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T07:45:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4284, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 10', CAST(N'2019-07-08T07:45:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4285, N'NV001', N'TT017', N'Khách PH010 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:45:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4286, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD038 cho Phòng 10', CAST(N'2019-07-08T07:46:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4287, N'NV001', N'TT001', N'', CAST(N'2019-07-08T07:49:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4288, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T07:49:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4289, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 10', CAST(N'2019-07-08T07:49:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4290, N'NV001', N'TT017', N'Khách PH010 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:49:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4291, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD039 cho Phòng 10', CAST(N'2019-07-08T07:49:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4292, N'NV001', N'TT001', N'', CAST(N'2019-07-08T07:51:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4293, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T07:51:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4294, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 10', CAST(N'2019-07-08T07:51:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4295, N'NV001', N'TT017', N'Khách PH010 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:52:07.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4296, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD040 cho Phòng 10', CAST(N'2019-07-08T07:52:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4297, N'NV001', N'TT007', N'NV001 mở Phòng 6', CAST(N'2019-07-08T07:52:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4298, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 6', CAST(N'2019-07-08T07:52:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4299, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 6', CAST(N'2019-07-08T07:52:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4300, N'NV001', N'TT017', N'Khách PH006 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:53:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4301, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD041 cho Phòng 6', CAST(N'2019-07-08T07:53:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4302, N'NV001', N'TT001', N'', CAST(N'2019-07-08T07:55:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4303, N'NV001', N'TT007', N'NV001 mở Phòng 6', CAST(N'2019-07-08T07:55:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4304, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 6', CAST(N'2019-07-08T07:55:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4305, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 6', CAST(N'2019-07-08T07:55:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4306, N'NV001', N'TT017', N'Khách PH006 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:55:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4307, N'NV001', N'TT018', N'Khách phòng PH006 trả món Coca Cola với số lượng 1', CAST(N'2019-07-08T07:56:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4308, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD042 cho Phòng 6', CAST(N'2019-07-08T07:56:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4309, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:08:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4310, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T08:08:11.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4311, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD043', CAST(N'2019-07-08T08:08:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4312, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:26:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4313, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD043', CAST(N'2019-07-08T08:27:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4314, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD043', CAST(N'2019-07-08T08:27:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4315, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:28:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4316, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD043', CAST(N'2019-07-08T08:28:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4317, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD043', CAST(N'2019-07-08T08:28:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4318, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD043', CAST(N'2019-07-08T08:28:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4319, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD043', CAST(N'2019-07-08T08:28:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4320, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD043', CAST(N'2019-07-08T08:28:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4321, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD043 cho Phòng 10', CAST(N'2019-07-08T08:29:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4322, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:30:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4323, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:35:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4324, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T08:35:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4325, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 10', CAST(N'2019-07-08T08:35:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4326, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD044', CAST(N'2019-07-08T08:35:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4327, N'NV001', N'TT017', N'Khách PH010 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T08:36:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4328, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD044', CAST(N'2019-07-08T08:36:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4329, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD044 cho Phòng 10', CAST(N'2019-07-08T08:37:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4330, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:38:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4331, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T08:38:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4332, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 10', CAST(N'2019-07-08T08:38:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4333, N'NV001', N'TT017', N'Khách PH010 gọi món Pepsi với số lượng 1', CAST(N'2019-07-08T08:38:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4334, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 10', CAST(N'2019-07-08T08:39:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4335, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:42:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4336, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:43:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4337, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T08:43:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4338, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 10', CAST(N'2019-07-08T08:43:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4339, N'NV001', N'TT017', N'Khách PH010 gọi món Pepsi với số lượng 1', CAST(N'2019-07-08T08:43:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4340, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:43:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4341, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:45:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4342, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD046', CAST(N'2019-07-08T08:45:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4343, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:45:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4344, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:46:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4345, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:46:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4346, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:47:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4347, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:47:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4348, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:49:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4349, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:49:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4350, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD046', CAST(N'2019-07-08T08:50:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4351, N'NV001', N'TT001', N'', CAST(N'2019-07-08T08:56:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4352, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:56:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4353, N'NV001', N'TT017', N'Khách phòng PH010 gọi món Pepsi với số lượng 1', CAST(N'2019-07-08T08:57:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4354, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD046', CAST(N'2019-07-08T08:57:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4355, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD046', CAST(N'2019-07-08T08:57:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4356, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 10', CAST(N'2019-07-08T08:57:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4357, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T08:57:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4358, N'NV001', N'TT002', N'NV001 thêm món Pepsi vào Phòng 10', CAST(N'2019-07-08T08:58:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4359, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD047', CAST(N'2019-07-08T08:58:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4360, N'NV001', N'TT017', N'Khách PH010 gọi món Pepsi với số lượng 1', CAST(N'2019-07-08T08:58:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4361, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD047', CAST(N'2019-07-08T08:58:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4362, N'NV001', N'TT008', N'NV001 lập hóa đơn thanh toán hóa đơn HD047 cho Phòng 10', CAST(N'2019-07-08T08:58:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4363, N'NV001', N'TT001', N'', CAST(N'2019-07-08T09:20:14.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4364, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:13:18.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4365, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:13:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4366, N'NV001', N'TT007', N'NV001 mở Phòng 1', CAST(N'2019-07-08T10:14:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4367, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:15:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4368, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 1', CAST(N'2019-07-08T10:15:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4369, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:15:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4370, N'NV001', N'TT007', N'NV001 mở Phòng 1', CAST(N'2019-07-08T10:15:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4371, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 1', CAST(N'2019-07-08T10:16:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4372, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:16:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4373, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:17:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4374, N'NV001', N'TT007', N'NV001 mở Phòng 1', CAST(N'2019-07-08T10:17:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4375, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 1', CAST(N'2019-07-08T10:17:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4376, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:21:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4377, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:21:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4378, N'NV001', N'TT007', N'NV001 mở Phòng 1', CAST(N'2019-07-08T10:22:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4379, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T10:22:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4380, N'NV010', N'TT007', N'NV010 mở Phòng 6', CAST(N'2019-07-08T10:22:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4381, N'NV001', N'TT007', N'NV001 mở Phòng 8', CAST(N'2019-07-08T10:22:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4382, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:23:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4383, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 10', CAST(N'2019-07-08T10:23:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4384, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 8', CAST(N'2019-07-08T10:23:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4385, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 6', CAST(N'2019-07-08T10:23:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4386, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 1', CAST(N'2019-07-08T10:23:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4387, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:24:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4388, N'NV001', N'TT007', N'NV001 mở Phòng 1', CAST(N'2019-07-08T10:24:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4389, N'NV010', N'TT007', N'NV010 mở Phòng 10', CAST(N'2019-07-08T10:24:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4390, N'NV010', N'TT006', N'NV010 đóng phòng Phòng 10', CAST(N'2019-07-08T10:25:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4391, N'NV010', N'TT006', N'NV010 đóng phòng Phòng 1', CAST(N'2019-07-08T10:25:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4392, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:34:03.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4393, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:36:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4394, N'NV010', N'TT007', N'NV010 mở Phòng 10', CAST(N'2019-07-08T10:36:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4395, N'NV010', N'TT002', N'NV010 thêm món Sting vào Phòng 10', CAST(N'2019-07-08T10:36:42.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4396, N'NV010', N'TT003', N'NV010 xóa món Sting tại Phòng 10', CAST(N'2019-07-08T10:36:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4397, N'NV010', N'TT002', N'NV010 thêm món Bia Heineken vào Phòng 10', CAST(N'2019-07-08T10:37:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4398, N'NV010', N'TT002', N'NV010 thêm món Bò Khô vào Phòng 10', CAST(N'2019-07-08T10:37:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4399, N'NV010', N'TT007', N'NV010 mở Phòng 3', CAST(N'2019-07-08T10:37:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4400, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:37:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4401, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 3', CAST(N'2019-07-08T10:38:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4402, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 1', CAST(N'2019-07-08T10:38:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4403, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:48:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4404, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:48:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4405, N'NV003', N'TT001', N'', CAST(N'2019-07-08T10:49:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4406, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:49:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4407, N'NV001', N'TT013', N'', CAST(N'2019-07-08T10:50:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4408, N'NV002', N'TT001', N'', CAST(N'2019-07-08T10:50:26.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4409, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:50:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4410, N'NV016', N'TT001', N'', CAST(N'2019-07-08T10:50:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4411, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:51:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4412, N'NV001', N'TT014', N'set cấp độ thu ngân', CAST(N'2019-07-08T10:51:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4413, N'NV016', N'TT001', N'', CAST(N'2019-07-08T10:51:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4414, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:52:04.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4415, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:52:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4416, N'NV016', N'TT001', N'', CAST(N'2019-07-08T10:52:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4417, N'NV002', N'TT001', N'', CAST(N'2019-07-08T10:53:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4418, N'NV003', N'TT001', N'', CAST(N'2019-07-08T10:53:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4419, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:53:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4420, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:54:21.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4421, N'NV001', N'TT014', N'Lên chức quản lý', CAST(N'2019-07-08T10:54:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4422, N'NV001', N'TT014', N'quản lý', CAST(N'2019-07-08T10:55:16.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4423, N'NV002', N'TT001', N'', CAST(N'2019-07-08T10:55:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4424, N'NV003', N'TT001', N'', CAST(N'2019-07-08T10:55:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4425, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:57:37.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4426, N'NV002', N'TT001', N'', CAST(N'2019-07-08T10:57:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4427, N'NV003', N'TT001', N'', CAST(N'2019-07-08T10:58:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4428, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:58:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4429, N'NV016', N'TT001', N'', CAST(N'2019-07-08T10:58:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4430, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:58:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4431, N'NV001', N'TT001', N'', CAST(N'2019-07-08T10:58:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4432, N'NV001', N'TT014', N'phục vụ', CAST(N'2019-07-08T10:59:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4433, N'NV010', N'TT001', N'', CAST(N'2019-07-08T10:59:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4434, N'NV016', N'TT001', N'', CAST(N'2019-07-08T11:00:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4435, N'NV001', N'TT001', N'', CAST(N'2019-07-08T11:01:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4436, N'NV003', N'TT001', N'', CAST(N'2019-07-08T11:01:32.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4437, N'NV001', N'TT001', N'', CAST(N'2019-07-08T11:02:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4438, N'NV002', N'TT001', N'', CAST(N'2019-07-08T11:02:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4439, N'NV003', N'TT001', N'', CAST(N'2019-07-08T11:02:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4440, N'NV010', N'TT001', N'', CAST(N'2019-07-08T11:02:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4441, N'NV016', N'TT001', N'', CAST(N'2019-07-08T11:02:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4442, N'NV001', N'TT001', N'', CAST(N'2019-07-08T11:04:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4443, N'NV001', N'TT001', N'', CAST(N'2019-07-08T11:05:51.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4444, N'NV001', N'TT001', N'', CAST(N'2019-07-08T12:45:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4445, N'NV001', N'TT001', N'', CAST(N'2019-07-08T12:46:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4446, N'NV010', N'TT001', N'', CAST(N'2019-07-08T12:48:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4447, N'NV016', N'TT001', N'', CAST(N'2019-07-08T12:49:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4448, N'NV016', N'TT001', N'', CAST(N'2019-07-08T12:51:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4449, N'NV010', N'TT001', N'', CAST(N'2019-07-08T12:51:52.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4450, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:26:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4451, N'NV001', N'TT007', N'NV001 mở Phòng 10', CAST(N'2019-07-08T13:26:47.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4452, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:32:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4453, N'NV001', N'TT007', N'NV001 mở Phòng 4', CAST(N'2019-07-08T13:33:06.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4454, N'NV001', N'TT002', N'NV001 thêm món Bánh Poca vị tảo biển vào Phòng 4', CAST(N'2019-07-08T13:33:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4455, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD060', CAST(N'2019-07-08T13:33:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4456, N'NV001', N'TT017', N'Khách phòng PH004 gọi món Bánh Poca vị tảo biển với số lượng 1', CAST(N'2019-07-08T13:33:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4457, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD060', CAST(N'2019-07-08T13:34:13.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4458, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:39:29.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4459, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:40:59.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4460, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:45:25.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4461, N'NV001', N'TT002', N'NV001 thêm món Bia Tiger vào Phòng 2', CAST(N'2019-07-08T13:49:49.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4462, N'NV001', N'TT006', N'NV001 đóng phòng Phòng 2', CAST(N'2019-07-08T13:50:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4463, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:53:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4464, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:54:08.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4465, N'NV001', N'TT001', N'', CAST(N'2019-07-08T13:55:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4466, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:23:56.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4467, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:27:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4468, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:35:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4469, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:38:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4470, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:40:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4471, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Bánh Poca vị tảo biển với số lượng 4', CAST(N'2019-07-08T15:40:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4472, N'NV001', N'TT017', N'Khách phòng PH005 gọi món Bánh Poca vị tảo biển với số lượng 7', CAST(N'2019-07-08T15:40:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4473, N'NV001', N'TT007', N'NV001 mở Phòng 1', CAST(N'2019-07-08T15:41:30.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4474, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 1', CAST(N'2019-07-08T15:41:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4475, N'NV001', N'TT002', N'NV001 thêm món Bò Khô vào Phòng 1', CAST(N'2019-07-08T15:41:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4476, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 1', CAST(N'2019-07-08T15:41:53.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4477, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 1', CAST(N'2019-07-08T15:42:02.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4478, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 1', CAST(N'2019-07-08T15:42:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4479, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 1', CAST(N'2019-07-08T15:42:17.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4480, N'NV001', N'TT002', N'NV001 thêm món Coca Cola vào Phòng 1', CAST(N'2019-07-08T15:42:23.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4481, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:48:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4482, N'NV001', N'TT017', N'Khách phòng PH001 gọi món Bò Khô với số lượng 4', CAST(N'2019-07-08T15:48:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4483, N'NV001', N'TT017', N'Khách PH001 gọi món Coca Cola với số lượng 4', CAST(N'2019-07-08T15:49:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4484, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:49:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4485, N'NV001', N'TT017', N'Khách phòng PH001 gọi món Bò Khô với số lượng 3', CAST(N'2019-07-08T15:49:33.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4486, N'NV001', N'TT018', N'Khách phòng PH001 trả món Bò Khô với số lượng 5', CAST(N'2019-07-08T15:49:36.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4487, N'NV001', N'TT017', N'Khách PH001 gọi món Coca Cola với số lượng 2', CAST(N'2019-07-08T15:49:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4488, N'NV001', N'TT017', N'Khách PH001 gọi món Bò Khô với số lượng 5', CAST(N'2019-07-08T15:49:54.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4489, N'NV001', N'TT002', N'NV001 thêm món Phồng Tôm vào Phòng 1', CAST(N'2019-07-08T15:50:01.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4490, N'NV001', N'TT017', N'Khách PH001 gọi món Coca Cola với số lượng 3', CAST(N'2019-07-08T15:50:15.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4491, N'NV001', N'TT017', N'Khách PH001 gọi món Coca Cola với số lượng 1', CAST(N'2019-07-08T15:50:22.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4492, N'NV001', N'TT001', N'', CAST(N'2019-07-08T15:51:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4493, N'NV001', N'TT001', N'', CAST(N'2019-07-08T16:13:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4494, N'NV001', N'TT001', N'', CAST(N'2019-07-08T16:21:42.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4495, N'NV010', N'TT001', N'', CAST(N'2019-07-08T16:39:19.000' AS DateTime))
GO
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4496, N'NV001', N'TT001', N'', CAST(N'2019-07-08T16:39:43.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4497, N'NV001', N'TT001', N'', CAST(N'2019-07-08T16:40:44.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4498, N'NV010', N'TT001', N'', CAST(N'2019-07-08T16:40:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4499, N'NV016', N'TT001', N'', CAST(N'2019-07-08T16:41:05.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4500, N'NV016', N'TT007', N'NV016 mở Phòng 10', CAST(N'2019-07-08T16:41:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4501, N'NV016', N'TT002', N'NV016 thêm món Bia Heineken vào Phòng 10', CAST(N'2019-07-08T16:41:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4502, N'NV016', N'TT002', N'NV016 thêm món Sting vào Phòng 10', CAST(N'2019-07-08T16:41:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4503, N'NV010', N'TT007', N'NV010 mở Phòng 4', CAST(N'2019-07-08T16:45:57.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4504, N'NV016', N'TT006', N'NV016 đóng phòng Phòng 4', CAST(N'2019-07-08T16:46:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4505, N'NV010', N'TT007', N'NV010 mở Phòng 6', CAST(N'2019-07-08T16:51:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4506, N'NV016', N'TT006', N'NV016 đóng phòng Phòng 6', CAST(N'2019-07-08T16:52:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4507, N'NV010', N'TT001', N'', CAST(N'2019-07-08T17:05:19.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4508, N'NV010', N'TT007', N'NV010 mở Phòng 2', CAST(N'2019-07-08T17:06:10.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4509, N'NV010', N'TT002', N'NV010 thêm món Nước suối vào Phòng 2', CAST(N'2019-07-08T17:06:20.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4510, N'NV010', N'TT017', N'Khách PH002 gọi món Nước suối với số lượng 5', CAST(N'2019-07-08T17:06:24.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4511, N'NV010', N'TT002', N'NV010 thêm món Bia Sài Gòn vào Phòng 2', CAST(N'2019-07-08T17:06:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4512, N'NV010', N'TT017', N'Khách PH002 gọi món Bia Sài Gòn với số lượng 1', CAST(N'2019-07-08T17:06:39.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4513, N'NV010', N'TT002', N'NV010 thêm món Nước Aquafina Lít Rưỡi vào Phòng 2', CAST(N'2019-07-08T17:06:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4514, N'NV010', N'TT003', N'NV010 xóa món Bia Sài Gòn tại Phòng 4', CAST(N'2019-07-08T17:07:28.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4515, N'NV010', N'TT015', N'NV010 lập hóa đơn tạm tính hóa đơn HD065', CAST(N'2019-07-08T17:08:00.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4516, N'NV001', N'TT001', N'', CAST(N'2019-07-08T17:09:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4517, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD061', CAST(N'2019-07-08T17:09:38.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4518, N'NV001', N'TT018', N'Khách phòng PH001 trả món Coca Cola với số lượng 5', CAST(N'2019-07-08T17:09:58.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4519, N'NV001', N'TT016', N'NV001 hủy hóa đơn tạm tính cho hóa đơn HD061', CAST(N'2019-07-08T17:10:12.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4520, N'NV001', N'TT015', N'NV001 lập hóa đơn tạm tính hóa đơn HD061', CAST(N'2019-07-08T17:10:31.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4521, N'NV001', N'TT007', N'NV001 mở Phòng 2', CAST(N'2019-07-08T17:14:48.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4522, N'NV001', N'TT002', N'NV001 thêm món Bánh Ngọt vào Phòng 2', CAST(N'2019-07-08T17:15:07.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4523, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 2', CAST(N'2019-07-08T17:15:34.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4524, N'NV001', N'TT002', N'NV001 thêm món Bánh Ngọt vào Phòng 2', CAST(N'2019-07-08T17:15:40.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4525, N'NV001', N'TT017', N'Khách phòng PH002 gọi món Bánh Ngọt với số lượng 2', CAST(N'2019-07-08T17:15:45.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4526, N'NV001', N'TT001', N'', CAST(N'2019-07-08T17:16:35.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4527, N'NV001', N'TT007', N'NV001 mở Phòng 3', CAST(N'2019-07-08T17:16:41.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4528, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 3', CAST(N'2019-07-08T17:16:46.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4529, N'NV001', N'TT002', N'NV001 thêm món Bánh Snack vào Phòng 3', CAST(N'2019-07-08T17:16:50.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4530, N'NV001', N'TT017', N'Khách phòng PH003 gọi món Bánh Snack với số lượng 3', CAST(N'2019-07-08T17:16:55.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4531, N'NV001', N'TT002', N'NV001 thêm món Nước suối vào Phòng 3', CAST(N'2019-07-08T17:17:09.000' AS DateTime))
INSERT [dbo].[LichSuThaoTac] ([ID], [MaNVTT], [MaTT], [GhiChu], [ThoiGian]) VALUES (4532, N'NV001', N'TT002', N'NV001 thêm món Bia Sài Gòn vào Phòng 5', CAST(N'2019-07-08T17:17:30.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[LichSuThaoTac] OFF
INSERT [dbo].[LoaiDichVu] ([MaLoaiDV], [TenLoaiDV], [TrangThai]) VALUES (N'LOAIDV001', N'Thức Ăn', 1)
INSERT [dbo].[LoaiDichVu] ([MaLoaiDV], [TenLoaiDV], [TrangThai]) VALUES (N'LOAIDV002', N'Nước Uống', 1)
INSERT [dbo].[LoaiDichVu] ([MaLoaiDV], [TenLoaiDV], [TrangThai]) VALUES (N'LOAIDV003', N'Giờ Hát', 1)
INSERT [dbo].[LoaiDichVu] ([MaLoaiDV], [TenLoaiDV], [TrangThai]) VALUES (N'LOAIDV004', N'Khác', 1)
INSERT [dbo].[LoaiNhanVien] ([MaLoaiNV], [ChucVu], [TrangThai]) VALUES (N'LOAINV001', N'Quản lý', 1)
INSERT [dbo].[LoaiNhanVien] ([MaLoaiNV], [ChucVu], [TrangThai]) VALUES (N'LOAINV002', N'Kế toán', 1)
INSERT [dbo].[LoaiNhanVien] ([MaLoaiNV], [ChucVu], [TrangThai]) VALUES (N'LOAINV003', N'Thu ngân', 1)
INSERT [dbo].[LoaiNhanVien] ([MaLoaiNV], [ChucVu], [TrangThai]) VALUES (N'LOAINV004', N'Phục vụ', 1)
INSERT [dbo].[LoaiPhongHat] ([MaLoai], [TenPhong], [GioBinhThuong], [GioCaoDiem], [TrangThai]) VALUES (N'LP001', N'Phòng VIP', 80000, 120000, 1)
INSERT [dbo].[LoaiPhongHat] ([MaLoai], [TenPhong], [GioBinhThuong], [GioCaoDiem], [TrangThai]) VALUES (N'LP002', N'Phòng thường', 50000, 80000, 1)
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTK], [TenMaLoaiTK], [TrangThai]) VALUES (N'LOAITK001', N'Admin', 1)
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTK], [TenMaLoaiTK], [TrangThai]) VALUES (N'LOAITK002', N'Quản lý', 1)
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTK], [TenMaLoaiTK], [TrangThai]) VALUES (N'LOAITK003', N'Kế toán', 1)
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTK], [TenMaLoaiTK], [TrangThai]) VALUES (N'LOAITK004', N'Thu ngân', 1)
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTK], [TenMaLoaiTK], [TrangThai]) VALUES (N'LOAITK005', N'Phục vụ', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT001', N'Đăng nhập', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT002', N'Gọi món', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT003', N'Xóa món', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT004', N'Chỉnh số lượng', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT005', N'Chỉnh giá dịch vụ', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT006', N'Đóng phòng', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT007', N'Mở phòng', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT008', N'Lập hóa đơn thanh toán', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT009', N'Chỉnh sửa phòng hát', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT010', N'Thêm phòng hát', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT011', N'Xóa phòng hát', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT012', N'Xóa nhân viên', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT013', N'Cập nhật thông tin nhân viên', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT014', N'Thay đổi chức vụ hoặc loại tài khoản', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT015', N'Lập hóa đơn tạm tính', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT016', N'Hủy hóa đơn tạm tính', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT017', N'Khách gọi thêm món', 1)
INSERT [dbo].[LoaiThaoTac] ([MaTT], [TenThaoTac], [TrangThai]) VALUES (N'TT018', N'Khách trả lại món', 1)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV001', N'Võ Thành An', CAST(N'1996-10-24T00:00:00.000' AS DateTime), N'Nam', N'0393524558', N'Bình Thuận', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV001', 1)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV002', N'Lâm Chí Thanh', CAST(N'1996-06-03T00:00:00.000' AS DateTime), N'Nam', N'0393524669', N'Long An', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV001', 1)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV003', N'Nguyễn Văn B', CAST(N'2018-11-05T00:00:00.000' AS DateTime), N'Nam', N'0393524552', N'Bến Tre', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV002', 1)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV004', N'Thánh', CAST(N'2018-11-08T00:00:00.000' AS DateTime), N'Nam', N'1111111111', N'aaaaaa', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV005', N'Vinh', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'Nữ', N'22333     ', N'BT', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV001', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV006', N'dasdad', CAST(N'2018-12-25T00:00:00.000' AS DateTime), N'Nam', N'456456484 ', N'xasd', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV007', N'NguyenVanB', CAST(N'2018-12-25T00:00:00.000' AS DateTime), N'Nam', N'548546548 ', N'xsadasd', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV008', N'xxxxx', CAST(N'2019-05-06T00:00:00.000' AS DateTime), N'Nữ', N'2132156456', N'dasdasd', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV009', N'zasd', CAST(N'2019-05-20T00:00:00.000' AS DateTime), N'Nữ', N'1111111111', N'fasdad', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV010', N'Nguyễn Thị Nhi', CAST(N'2019-05-20T00:00:00.000' AS DateTime), N'Nữ', N'0393524553', N'Sóc Trăng', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 1)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV011', N'hi', CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'Nam', N'123       ', N'ghj', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV001', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV012', N'xxxxxx', CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'Nữ', N'156456456 ', N'xxxxx', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV013', N'xxxxx', CAST(N'2019-06-03T00:00:00.000' AS DateTime), N'Nữ', N'12323     ', N'xxxxxx', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV014', N'Demo', CAST(N'2019-06-13T00:00:00.000' AS DateTime), N'Nam', N'123       ', N'BT', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV015', N'Demo', CAST(N'2019-06-13T00:00:00.000' AS DateTime), N'Nữ', N'123       ', N'VT', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV016', N'Nguyễn Văn A', CAST(N'2019-06-13T00:00:00.000' AS DateTime), N'Nam', N'0393524551', N'Vũng Tàu', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV003', 1)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV017', N'aaaaa', CAST(N'2019-06-25T00:00:00.000' AS DateTime), N'Nam', N'1231231   ', N'aaaaaa', N'DuLieu/NhanVien/NV017.jpg                                                                           ', N'LOAINV004', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV018', N'demoxxxasdasd', CAST(N'2019-07-05T00:00:00.000' AS DateTime), N'Nữ', N'1231235434', N'dqwqwd', N'DuLieu/NhanVien/NV018.jpg                                                                           ', N'LOAINV003', 0)
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [NgaySinh], [GioiTinh], [DienThoai], [DiaChi], [HinhAnhNV], [LoaiNV], [TrangThai]) VALUES (N'NV019', N'Lê Thị Bưởi', CAST(N'1999-07-15T00:00:00.000' AS DateTime), N'Nam', N'0393524554', N'Cần Thơ', N'DuLieu/NhanVien/NV005.jpg                                                                           ', N'LOAINV004', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH001', N'Phòng 1', N'Sức chứa: 25
Phong cách: Cổ điển
Lầu 1', N'LP001', N'TT002', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH002', N'Phòng 2', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP001', N'TT002', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH003', N'Phòng 3', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP002', N'TT002', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH004', N'Phòng 4', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP001', N'TT002', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH005', N'Phòng 5', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP002', N'TT002', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH006', N'Phòng 6', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP002', N'TT001', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH007', N'Phòng 7', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP001', N'TT001', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH008', N'Phòng 8', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP002', N'TT001', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH009', N'Phòng 9', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP001', N'TT001', 1)
INSERT [dbo].[PhongHat] ([MaPH], [TenPH], [MoTa], [LoaiPhong], [TinhTrang], [TrangThai]) VALUES (N'PH010', N'Phòng 10', N'Sức chứa: 25
Phong cách: cổ điển Classic
Lầu 1', N'LP002', N'TT002', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK001', N'admin', N'202cb962ac59075b964b07152d234b70                  ', N'NV001', N'LOAITK001', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK002', N'an                                                ', N'202cb962ac59075b964b07152d234b70                  ', N'NV001', N'LOAITK004', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK003', N'thanh2                                            ', N'202cb962ac59075b964b07152d234b70                  ', N'NV002', N'LOAITK002', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK004', N'vinh                                              ', N'202cb962ac59075b964b07152d234b70                  ', N'NV003', N'LOAITK003', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK005', N'test                                              ', N'289dff07669d7a23de0ef88d2f7129e7                  ', N'NV005', N'LOAITK001', 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK006', N'thanh                                             ', N'202cb962ac59075b964b07152d234b70                  ', N'NV006', N'LOAITK002', 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK007', N'phucvu                                            ', N'e10adc3949ba59abbe56e057f20f883e                  ', N'NV008', N'LOAITK004', 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK008', N'nhi                                               ', N'202cb962ac59075b964b07152d234b70                  ', N'NV010', N'LOAITK005', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK009', N'demo                                              ', N'202cb962ac59075b964b07152d234b70                  ', N'NV016', N'LOAITK004', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK010', N'aaa', N'ce1224038dc0951b719b13a60461975b                  ', N'NV017', N'LOAITK005', 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK011', N'demoxxx', N'202cb962ac59075b964b07152d234b70                  ', N'NV018', N'LOAITK004', 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [MatKhau], [MaNV], [LoaiTaiKhoan], [TrangThai]) VALUES (N'TK012', N'BuoiLT', N'202cb962ac59075b964b07152d234b70                  ', N'NV019', N'LOAITK005', 1)
INSERT [dbo].[TinhTrangPhong] ([MaTinhTrang], [TinhTrang], [MoTa], [TrangThai]) VALUES (N'TT001', N'Phòng trống', N'Có thể mở phòng', 1)
INSERT [dbo].[TinhTrangPhong] ([MaTinhTrang], [TinhTrang], [MoTa], [TrangThai]) VALUES (N'TT002', N'Đang sử dụng', N'Không thể mở phòng', 1)
INSERT [dbo].[TinhTrangPhong] ([MaTinhTrang], [TinhTrang], [MoTa], [TrangThai]) VALUES (N'TT003', N'Phòng hư', N'Không thể mở phòng', 1)
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_DichVu] FOREIGN KEY([MaDV])
REFERENCES [dbo].[DichVu] ([MaDV])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_DichVu]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_HoaDon] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDon] ([MaHD])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_HoaDon]
GO
ALTER TABLE [dbo].[DichVu]  WITH CHECK ADD  CONSTRAINT [FK_DichVu_LoaiDichVu] FOREIGN KEY([MaLoaiDV])
REFERENCES [dbo].[LoaiDichVu] ([MaLoaiDV])
GO
ALTER TABLE [dbo].[DichVu] CHECK CONSTRAINT [FK_DichVu_LoaiDichVu]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([NhanVienLapHD])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_PhongHat] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[PhongHat] ([MaPH])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_PhongHat]
GO
ALTER TABLE [dbo].[LichSuThaoTac]  WITH CHECK ADD  CONSTRAINT [FK_LichSuThaoTac_NhanVien] FOREIGN KEY([MaNVTT])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[LichSuThaoTac] CHECK CONSTRAINT [FK_LichSuThaoTac_NhanVien]
GO
ALTER TABLE [dbo].[LichSuThaoTac]  WITH CHECK ADD  CONSTRAINT [FK_LichSuThaoTac_ThaoTac] FOREIGN KEY([MaTT])
REFERENCES [dbo].[LoaiThaoTac] ([MaTT])
GO
ALTER TABLE [dbo].[LichSuThaoTac] CHECK CONSTRAINT [FK_LichSuThaoTac_ThaoTac]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_LoaiNhanVien] FOREIGN KEY([LoaiNV])
REFERENCES [dbo].[LoaiNhanVien] ([MaLoaiNV])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_LoaiNhanVien]
GO
ALTER TABLE [dbo].[PhongHat]  WITH CHECK ADD  CONSTRAINT [FK_PhongHat_LoaiPhongHat] FOREIGN KEY([LoaiPhong])
REFERENCES [dbo].[LoaiPhongHat] ([MaLoai])
GO
ALTER TABLE [dbo].[PhongHat] CHECK CONSTRAINT [FK_PhongHat_LoaiPhongHat]
GO
ALTER TABLE [dbo].[PhongHat]  WITH CHECK ADD  CONSTRAINT [FK_PhongHat_TinhTrangPhong] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TinhTrangPhong] ([MaTinhTrang])
GO
ALTER TABLE [dbo].[PhongHat] CHECK CONSTRAINT [FK_PhongHat_TinhTrangPhong]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_LoaiTaiKhoan_TaiKhoan] FOREIGN KEY([LoaiTaiKhoan])
REFERENCES [dbo].[LoaiTaiKhoan] ([MaLoaiTK])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_LoaiTaiKhoan_TaiKhoan]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_NhanVien]
GO
/****** Object:  StoredProcedure [dbo].[InsertOperationHistory]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[InsertOperationHistory] @MaNV char(5), @MaTT char(5), @GhiChu nvarchar(100), @ThoiGian datetime
AS
	Insert into LichSuThaoTac Values (@MaNV,@MaTT,@GhiChu,@ThoiGian)
GO
/****** Object:  StoredProcedure [dbo].[PROC_ChiTietHoaDon]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_ChiTietHoaDon]
@MaHD char(5)
as
	begin
		select cthd.MaDV,cthd.SoLuong,cthd.GiaBan,cthd.ThanhTien
		from hoadon hd, ChiTietHoaDon cthd
		where hd.MaHD = cthd.MaHD and hd.MaHD = @MaHD
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_DoanhThuTheoNgay]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_DoanhThuTheoNgay]
@Day date
as
	begin
			Select CONVERT(date,NgayLap) as 'DoanhThuNgay' , SUM(TongTien) as 'TongTien'
			From dbo.HoaDon
			where @Day = CONVERT(date,NgayLap) and DaThanhToan = 1 and TrangThai =1
			Group by CONVERT(date,NgayLap)
			
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_DoanhThuTheoThang]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_DoanhThuTheoThang]
@Month int,@Year int
as
	begin
			Select MONTH(NgayLap) as 'Thang', YEAR(NgayLap)  as 'Nam', SUM(TongTien) as 'TongTien'
			From dbo.HoaDon
			where MONTH(NgayLap) = @Month and YEAR(NgayLap) = @Year  and DaThanhToan = 1 and TrangThai = 1
			Group by MONTH(NgayLap), YEAR(NgayLap) 
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_DoanhThuTuNgayToiNgay]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_DoanhThuTuNgayToiNgay]
@FromDay date, @ToDay date
as
	begin
			Select CONVERT(date,NgayLap) as 'NgayLap' , SUM(TongTien) as 'TongTien'
			From dbo.HoaDon
			where @FromDay <= CONVERT(date,NgayLap) and CONVERT(date,NgayLap) <= @ToDay and DaThanhToan = 1 and TrangThai = 1
			Group by CONVERT(date,NgayLap)
			Order by CONVERT(date,NgayLap) ASC
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_FilterLichSuThaoTac]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[PROC_FilterLichSuThaoTac]
 @FromDay date,@ToDay date
 as
 begin
	select *
	from VIEW_LichSuThaoTac
	where CONVERT(date,ThoiGian) Between @FromDay and @ToDay
	order by ThoiGian DESC
end
GO
/****** Object:  StoredProcedure [dbo].[PROC_HoaDonDaThanhToan]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PROC_HoaDonDaThanhToan]
@MaHDIn char(5)
as
Begin
		SELECT hd.MaHD,ph.MaPH, hd.GioVao, hd.GioRa, dv.TenDV, CTHD.SoLuong, CTHD.GiaBan, CTHD.ThanhTien, nv.HoTenNV as 'NhanVienLapHDDTT', hd.NgayLap
		FROM   HoaDon hd ,ChiTietHoaDon CTHD ,PhongHat ph, DichVu dv,NhanVien nv
		where hd.MaHD = @MaHDIn and hd.MaHD = CTHD.MaHD and hd.MaPhong = ph.MaPH and CTHD.MaDV = dv.MaDV and hd.NhanVienLapHD = nv.MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[PROC_HoaDonTamTinh]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_HoaDonTamTinh]
@MaHDIn char(5)
as
Begin
		SELECT hd.MaHD,ph.MaPH, hd.GioVao, hd.GioRa, dv.TenDV, CTHD.SoLuong, CTHD.GiaBan, CTHD.ThanhTien,hd.NhanVienLapHDTT, hd.NgayLap
		FROM   HoaDon hd ,ChiTietHoaDon CTHD ,PhongHat ph, DichVu dv,NhanVien nv
		where hd.MaHD = @MaHDIn and hd.MaHD = CTHD.MaHD and hd.MaPhong = ph.MaPH and CTHD.MaDV = dv.MaDV and hd.NhanVienLapHDTT = nv.MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[PROC_InHoaDonVoiTienNhan]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[PROC_InHoaDonVoiTienNhan]
@MaHDIn char(5),@TienNhan char(15),@TienThoi char(15), @TienGioHat char(15)
as
begin
	select *,@TienNhan as 'TienNhan',@TienThoi as 'TienThoi', @TienGioHat as 'TienGioHat'
	from VIEW_InHoaDon
	where MaHD = @MaHDIn
end
GO
/****** Object:  StoredProcedure [dbo].[PROC_SoLuongSPBanTheoNgay]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_SoLuongSPBanTheoNgay]
@FromDay date, @ToDay date
as
	begin
			select DV.TenDV , SUM(CTHD.SoLuong)
			from ChiTietHoaDon CTHD, HoaDon HD,DichVu DV
			where CTHD.MaHD = HD.MaHD and CTHD.MaDV = DV.MaDV and NgayLap Between @FromDay and @ToDay
			Group by DV.TenDV
			Order by SUM(CTHD.SoLuong) DESC
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_SoLuongSPBanTrongNgay]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_SoLuongSPBanTrongNgay]
@FromDay date
as
	begin
			select DV.TenDV , SUM(CTHD.SoLuong)
			from ChiTietHoaDon CTHD, HoaDon HD,DichVu DV
			where CTHD.MaHD = HD.MaHD and convert(date,NgayLap) = @FromDay and CTHD.MaDV = DV.MaDV
			Group by DV.TenDV
			Order by SUM(CTHD.SoLuong) DESC
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_SoLuongSPBanTrongThang]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_SoLuongSPBanTrongThang]
@Month int,@Year int
as
	begin
			select DV.TenDV , SUM(CTHD.SoLuong)
			from ChiTietHoaDon CTHD, HoaDon HD,DichVu DV
			where CTHD.MaHD = HD.MaHD and CTHD.MaDV = dv.MaDV and MONTH(NgayLap) = @Month and YEAR(NgayLap) = @Year
			Group by DV.TenDV
			Order by SUM(CTHD.SoLuong) DESC
	end
GO
/****** Object:  StoredProcedure [dbo].[PROC_ThongKeHoaDon]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PROC_ThongKeHoaDon]
@FromDay date , @ToDay date
as
	begin
			select hd.MaHD,ph.TenPH,hd.GioVao,hd.GioRa,nv.HoTenNV,hd.TongTien,hd.NgayLap,hd.DaThanhToan
			from hoadon hd, PhongHat ph , NhanVien nv
			where hd.MaPhong = ph.MaPH and hd.NhanVienLapHD = nv.MaNV and hd.NgayLap between @FromDay and @ToDay
	end


	
GO
/****** Object:  StoredProcedure [dbo].[PROC_ThongKeTanSuatSuDungPhong]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROC_ThongKeTanSuatSuDungPhong]
@Thang int
as
begin
	select ph.TenPH,sum(cthd.SoLuong) as 'SoLuongPhut'
	from HoaDon hd, ChiTietHoaDon cthd, PhongHat ph
	where hd.MaHD  = cthd.MaHD and hd.MaPhong = ph.MaPH and Month(hd.NgayLap) = @Thang
	group by ph.TenPH
	order by sum(cthd.SoLuong) desc
	end
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-01a82a1e-208c-431c-be16-316bb238c1e2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-01a82a1e-208c-431c-be16-316bb238c1e2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-01a82a1e-208c-431c-be16-316bb238c1e2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-01a82a1e-208c-431c-be16-316bb238c1e2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-01a82a1e-208c-431c-be16-316bb238c1e2') > 0)   DROP SERVICE [SqlQueryNotificationService-01a82a1e-208c-431c-be16-316bb238c1e2]; if (OBJECT_ID('SqlQueryNotificationService-01a82a1e-208c-431c-be16-316bb238c1e2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-01a82a1e-208c-431c-be16-316bb238c1e2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-01a82a1e-208c-431c-be16-316bb238c1e2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-05643292-68ba-4d0d-bfc6-7e3c49a38b6d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-05643292-68ba-4d0d-bfc6-7e3c49a38b6d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-05643292-68ba-4d0d-bfc6-7e3c49a38b6d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-05643292-68ba-4d0d-bfc6-7e3c49a38b6d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-05643292-68ba-4d0d-bfc6-7e3c49a38b6d') > 0)   DROP SERVICE [SqlQueryNotificationService-05643292-68ba-4d0d-bfc6-7e3c49a38b6d]; if (OBJECT_ID('SqlQueryNotificationService-05643292-68ba-4d0d-bfc6-7e3c49a38b6d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-05643292-68ba-4d0d-bfc6-7e3c49a38b6d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-05643292-68ba-4d0d-bfc6-7e3c49a38b6d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-05c2df66-891f-4393-b506-d095c3790f3e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-05c2df66-891f-4393-b506-d095c3790f3e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-05c2df66-891f-4393-b506-d095c3790f3e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-05c2df66-891f-4393-b506-d095c3790f3e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-05c2df66-891f-4393-b506-d095c3790f3e') > 0)   DROP SERVICE [SqlQueryNotificationService-05c2df66-891f-4393-b506-d095c3790f3e]; if (OBJECT_ID('SqlQueryNotificationService-05c2df66-891f-4393-b506-d095c3790f3e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-05c2df66-891f-4393-b506-d095c3790f3e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-05c2df66-891f-4393-b506-d095c3790f3e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-089d1163-f26d-4586-8217-68c3db26ca86]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-089d1163-f26d-4586-8217-68c3db26ca86] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-089d1163-f26d-4586-8217-68c3db26ca86]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-089d1163-f26d-4586-8217-68c3db26ca86] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-089d1163-f26d-4586-8217-68c3db26ca86') > 0)   DROP SERVICE [SqlQueryNotificationService-089d1163-f26d-4586-8217-68c3db26ca86]; if (OBJECT_ID('SqlQueryNotificationService-089d1163-f26d-4586-8217-68c3db26ca86', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-089d1163-f26d-4586-8217-68c3db26ca86]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-089d1163-f26d-4586-8217-68c3db26ca86]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a') > 0)   DROP SERVICE [SqlQueryNotificationService-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a]; if (OBJECT_ID('SqlQueryNotificationService-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-08e111bf-1fb6-4f35-8230-cca1a6ce3f9a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-0d7fba6e-e346-48f2-a9b4-66acf338f6d6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-0d7fba6e-e346-48f2-a9b4-66acf338f6d6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-0d7fba6e-e346-48f2-a9b4-66acf338f6d6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-0d7fba6e-e346-48f2-a9b4-66acf338f6d6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-0d7fba6e-e346-48f2-a9b4-66acf338f6d6') > 0)   DROP SERVICE [SqlQueryNotificationService-0d7fba6e-e346-48f2-a9b4-66acf338f6d6]; if (OBJECT_ID('SqlQueryNotificationService-0d7fba6e-e346-48f2-a9b4-66acf338f6d6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-0d7fba6e-e346-48f2-a9b4-66acf338f6d6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-0d7fba6e-e346-48f2-a9b4-66acf338f6d6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-103dbce7-f227-4f98-aaab-e45a519bd952]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-103dbce7-f227-4f98-aaab-e45a519bd952] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-103dbce7-f227-4f98-aaab-e45a519bd952]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-103dbce7-f227-4f98-aaab-e45a519bd952] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-103dbce7-f227-4f98-aaab-e45a519bd952') > 0)   DROP SERVICE [SqlQueryNotificationService-103dbce7-f227-4f98-aaab-e45a519bd952]; if (OBJECT_ID('SqlQueryNotificationService-103dbce7-f227-4f98-aaab-e45a519bd952', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-103dbce7-f227-4f98-aaab-e45a519bd952]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-103dbce7-f227-4f98-aaab-e45a519bd952]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-117a70be-9ade-43c2-934f-89acce24076f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-117a70be-9ade-43c2-934f-89acce24076f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-117a70be-9ade-43c2-934f-89acce24076f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-117a70be-9ade-43c2-934f-89acce24076f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-117a70be-9ade-43c2-934f-89acce24076f') > 0)   DROP SERVICE [SqlQueryNotificationService-117a70be-9ade-43c2-934f-89acce24076f]; if (OBJECT_ID('SqlQueryNotificationService-117a70be-9ade-43c2-934f-89acce24076f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-117a70be-9ade-43c2-934f-89acce24076f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-117a70be-9ade-43c2-934f-89acce24076f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-1445814c-7959-46ec-a18a-a431106a4d0b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-1445814c-7959-46ec-a18a-a431106a4d0b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-1445814c-7959-46ec-a18a-a431106a4d0b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-1445814c-7959-46ec-a18a-a431106a4d0b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-1445814c-7959-46ec-a18a-a431106a4d0b') > 0)   DROP SERVICE [SqlQueryNotificationService-1445814c-7959-46ec-a18a-a431106a4d0b]; if (OBJECT_ID('SqlQueryNotificationService-1445814c-7959-46ec-a18a-a431106a4d0b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-1445814c-7959-46ec-a18a-a431106a4d0b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-1445814c-7959-46ec-a18a-a431106a4d0b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-14569c21-50f7-4993-9968-1f75ef273b0d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-14569c21-50f7-4993-9968-1f75ef273b0d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-14569c21-50f7-4993-9968-1f75ef273b0d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-14569c21-50f7-4993-9968-1f75ef273b0d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-14569c21-50f7-4993-9968-1f75ef273b0d') > 0)   DROP SERVICE [SqlQueryNotificationService-14569c21-50f7-4993-9968-1f75ef273b0d]; if (OBJECT_ID('SqlQueryNotificationService-14569c21-50f7-4993-9968-1f75ef273b0d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-14569c21-50f7-4993-9968-1f75ef273b0d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-14569c21-50f7-4993-9968-1f75ef273b0d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-16236df8-58de-4bad-95de-8c9d72ec94c3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-16236df8-58de-4bad-95de-8c9d72ec94c3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-16236df8-58de-4bad-95de-8c9d72ec94c3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-16236df8-58de-4bad-95de-8c9d72ec94c3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-16236df8-58de-4bad-95de-8c9d72ec94c3') > 0)   DROP SERVICE [SqlQueryNotificationService-16236df8-58de-4bad-95de-8c9d72ec94c3]; if (OBJECT_ID('SqlQueryNotificationService-16236df8-58de-4bad-95de-8c9d72ec94c3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-16236df8-58de-4bad-95de-8c9d72ec94c3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-16236df8-58de-4bad-95de-8c9d72ec94c3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-16a4f2cb-f003-4462-a561-ea31115cc14d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-16a4f2cb-f003-4462-a561-ea31115cc14d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-16a4f2cb-f003-4462-a561-ea31115cc14d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-16a4f2cb-f003-4462-a561-ea31115cc14d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-16a4f2cb-f003-4462-a561-ea31115cc14d') > 0)   DROP SERVICE [SqlQueryNotificationService-16a4f2cb-f003-4462-a561-ea31115cc14d]; if (OBJECT_ID('SqlQueryNotificationService-16a4f2cb-f003-4462-a561-ea31115cc14d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-16a4f2cb-f003-4462-a561-ea31115cc14d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-16a4f2cb-f003-4462-a561-ea31115cc14d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-172f62f6-8491-4c8b-88d6-8400ece0e971]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-172f62f6-8491-4c8b-88d6-8400ece0e971] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-172f62f6-8491-4c8b-88d6-8400ece0e971]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-172f62f6-8491-4c8b-88d6-8400ece0e971] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-172f62f6-8491-4c8b-88d6-8400ece0e971') > 0)   DROP SERVICE [SqlQueryNotificationService-172f62f6-8491-4c8b-88d6-8400ece0e971]; if (OBJECT_ID('SqlQueryNotificationService-172f62f6-8491-4c8b-88d6-8400ece0e971', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-172f62f6-8491-4c8b-88d6-8400ece0e971]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-172f62f6-8491-4c8b-88d6-8400ece0e971]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-189b46c0-d502-48e8-9994-e5b94890c10f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-189b46c0-d502-48e8-9994-e5b94890c10f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-189b46c0-d502-48e8-9994-e5b94890c10f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-189b46c0-d502-48e8-9994-e5b94890c10f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-189b46c0-d502-48e8-9994-e5b94890c10f') > 0)   DROP SERVICE [SqlQueryNotificationService-189b46c0-d502-48e8-9994-e5b94890c10f]; if (OBJECT_ID('SqlQueryNotificationService-189b46c0-d502-48e8-9994-e5b94890c10f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-189b46c0-d502-48e8-9994-e5b94890c10f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-189b46c0-d502-48e8-9994-e5b94890c10f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-19087bd0-41bc-4e6a-a675-fb675cf5e4e4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-19087bd0-41bc-4e6a-a675-fb675cf5e4e4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-19087bd0-41bc-4e6a-a675-fb675cf5e4e4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-19087bd0-41bc-4e6a-a675-fb675cf5e4e4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-19087bd0-41bc-4e6a-a675-fb675cf5e4e4') > 0)   DROP SERVICE [SqlQueryNotificationService-19087bd0-41bc-4e6a-a675-fb675cf5e4e4]; if (OBJECT_ID('SqlQueryNotificationService-19087bd0-41bc-4e6a-a675-fb675cf5e4e4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-19087bd0-41bc-4e6a-a675-fb675cf5e4e4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-19087bd0-41bc-4e6a-a675-fb675cf5e4e4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-191456fe-95a8-429b-a5e5-d31ca61f9168]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-191456fe-95a8-429b-a5e5-d31ca61f9168] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-191456fe-95a8-429b-a5e5-d31ca61f9168]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-191456fe-95a8-429b-a5e5-d31ca61f9168] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-191456fe-95a8-429b-a5e5-d31ca61f9168') > 0)   DROP SERVICE [SqlQueryNotificationService-191456fe-95a8-429b-a5e5-d31ca61f9168]; if (OBJECT_ID('SqlQueryNotificationService-191456fe-95a8-429b-a5e5-d31ca61f9168', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-191456fe-95a8-429b-a5e5-d31ca61f9168]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-191456fe-95a8-429b-a5e5-d31ca61f9168]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-199dad67-73ed-4a0f-913d-f85ad39e3091]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-199dad67-73ed-4a0f-913d-f85ad39e3091] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-199dad67-73ed-4a0f-913d-f85ad39e3091]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-199dad67-73ed-4a0f-913d-f85ad39e3091] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-199dad67-73ed-4a0f-913d-f85ad39e3091') > 0)   DROP SERVICE [SqlQueryNotificationService-199dad67-73ed-4a0f-913d-f85ad39e3091]; if (OBJECT_ID('SqlQueryNotificationService-199dad67-73ed-4a0f-913d-f85ad39e3091', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-199dad67-73ed-4a0f-913d-f85ad39e3091]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-199dad67-73ed-4a0f-913d-f85ad39e3091]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd') > 0)   DROP SERVICE [SqlQueryNotificationService-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd]; if (OBJECT_ID('SqlQueryNotificationService-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-1a0bc8e4-748b-4d99-a8e3-ccf85fe4d9cd]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-1b486905-2e07-4691-aa67-d7179dfcbe74]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-1b486905-2e07-4691-aa67-d7179dfcbe74] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-1b486905-2e07-4691-aa67-d7179dfcbe74]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-1b486905-2e07-4691-aa67-d7179dfcbe74] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-1b486905-2e07-4691-aa67-d7179dfcbe74') > 0)   DROP SERVICE [SqlQueryNotificationService-1b486905-2e07-4691-aa67-d7179dfcbe74]; if (OBJECT_ID('SqlQueryNotificationService-1b486905-2e07-4691-aa67-d7179dfcbe74', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-1b486905-2e07-4691-aa67-d7179dfcbe74]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-1b486905-2e07-4691-aa67-d7179dfcbe74]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-1d068f75-d0bb-4735-9570-0d450795e14c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-1d068f75-d0bb-4735-9570-0d450795e14c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-1d068f75-d0bb-4735-9570-0d450795e14c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-1d068f75-d0bb-4735-9570-0d450795e14c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-1d068f75-d0bb-4735-9570-0d450795e14c') > 0)   DROP SERVICE [SqlQueryNotificationService-1d068f75-d0bb-4735-9570-0d450795e14c]; if (OBJECT_ID('SqlQueryNotificationService-1d068f75-d0bb-4735-9570-0d450795e14c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-1d068f75-d0bb-4735-9570-0d450795e14c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-1d068f75-d0bb-4735-9570-0d450795e14c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-20b543af-8757-404f-b49d-762cbbb660ec]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-20b543af-8757-404f-b49d-762cbbb660ec] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-20b543af-8757-404f-b49d-762cbbb660ec]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-20b543af-8757-404f-b49d-762cbbb660ec] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-20b543af-8757-404f-b49d-762cbbb660ec') > 0)   DROP SERVICE [SqlQueryNotificationService-20b543af-8757-404f-b49d-762cbbb660ec]; if (OBJECT_ID('SqlQueryNotificationService-20b543af-8757-404f-b49d-762cbbb660ec', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-20b543af-8757-404f-b49d-762cbbb660ec]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-20b543af-8757-404f-b49d-762cbbb660ec]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-21ba6d79-047c-450d-9084-59357cff6e97]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-21ba6d79-047c-450d-9084-59357cff6e97] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-21ba6d79-047c-450d-9084-59357cff6e97]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-21ba6d79-047c-450d-9084-59357cff6e97] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-21ba6d79-047c-450d-9084-59357cff6e97') > 0)   DROP SERVICE [SqlQueryNotificationService-21ba6d79-047c-450d-9084-59357cff6e97]; if (OBJECT_ID('SqlQueryNotificationService-21ba6d79-047c-450d-9084-59357cff6e97', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-21ba6d79-047c-450d-9084-59357cff6e97]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-21ba6d79-047c-450d-9084-59357cff6e97]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-21e839a4-c444-41a6-b21e-906066a99397]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-21e839a4-c444-41a6-b21e-906066a99397] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-21e839a4-c444-41a6-b21e-906066a99397]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-21e839a4-c444-41a6-b21e-906066a99397] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-21e839a4-c444-41a6-b21e-906066a99397') > 0)   DROP SERVICE [SqlQueryNotificationService-21e839a4-c444-41a6-b21e-906066a99397]; if (OBJECT_ID('SqlQueryNotificationService-21e839a4-c444-41a6-b21e-906066a99397', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-21e839a4-c444-41a6-b21e-906066a99397]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-21e839a4-c444-41a6-b21e-906066a99397]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-22182587-40c1-408a-b4da-f2cd987a96a0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-22182587-40c1-408a-b4da-f2cd987a96a0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-22182587-40c1-408a-b4da-f2cd987a96a0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-22182587-40c1-408a-b4da-f2cd987a96a0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-22182587-40c1-408a-b4da-f2cd987a96a0') > 0)   DROP SERVICE [SqlQueryNotificationService-22182587-40c1-408a-b4da-f2cd987a96a0]; if (OBJECT_ID('SqlQueryNotificationService-22182587-40c1-408a-b4da-f2cd987a96a0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-22182587-40c1-408a-b4da-f2cd987a96a0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-22182587-40c1-408a-b4da-f2cd987a96a0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-236c9b99-19c1-4202-807a-df67c6b53294]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-236c9b99-19c1-4202-807a-df67c6b53294] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-236c9b99-19c1-4202-807a-df67c6b53294]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-236c9b99-19c1-4202-807a-df67c6b53294] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-236c9b99-19c1-4202-807a-df67c6b53294') > 0)   DROP SERVICE [SqlQueryNotificationService-236c9b99-19c1-4202-807a-df67c6b53294]; if (OBJECT_ID('SqlQueryNotificationService-236c9b99-19c1-4202-807a-df67c6b53294', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-236c9b99-19c1-4202-807a-df67c6b53294]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-236c9b99-19c1-4202-807a-df67c6b53294]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-24e64e36-24fc-4c9e-9279-784658ce91fc]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-24e64e36-24fc-4c9e-9279-784658ce91fc] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-24e64e36-24fc-4c9e-9279-784658ce91fc]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-24e64e36-24fc-4c9e-9279-784658ce91fc] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-24e64e36-24fc-4c9e-9279-784658ce91fc') > 0)   DROP SERVICE [SqlQueryNotificationService-24e64e36-24fc-4c9e-9279-784658ce91fc]; if (OBJECT_ID('SqlQueryNotificationService-24e64e36-24fc-4c9e-9279-784658ce91fc', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-24e64e36-24fc-4c9e-9279-784658ce91fc]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-24e64e36-24fc-4c9e-9279-784658ce91fc]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc') > 0)   DROP SERVICE [SqlQueryNotificationService-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc]; if (OBJECT_ID('SqlQueryNotificationService-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-25d0cd67-65a9-40cd-bf29-1ba1b4f0d2dc]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-25d7a50d-2487-454c-82c6-ff3f932bbf76]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-25d7a50d-2487-454c-82c6-ff3f932bbf76] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-25d7a50d-2487-454c-82c6-ff3f932bbf76]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-25d7a50d-2487-454c-82c6-ff3f932bbf76] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-25d7a50d-2487-454c-82c6-ff3f932bbf76') > 0)   DROP SERVICE [SqlQueryNotificationService-25d7a50d-2487-454c-82c6-ff3f932bbf76]; if (OBJECT_ID('SqlQueryNotificationService-25d7a50d-2487-454c-82c6-ff3f932bbf76', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-25d7a50d-2487-454c-82c6-ff3f932bbf76]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-25d7a50d-2487-454c-82c6-ff3f932bbf76]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-271b06a8-60ab-426c-9dbc-e025492ab2be]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-271b06a8-60ab-426c-9dbc-e025492ab2be] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-271b06a8-60ab-426c-9dbc-e025492ab2be]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-271b06a8-60ab-426c-9dbc-e025492ab2be] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-271b06a8-60ab-426c-9dbc-e025492ab2be') > 0)   DROP SERVICE [SqlQueryNotificationService-271b06a8-60ab-426c-9dbc-e025492ab2be]; if (OBJECT_ID('SqlQueryNotificationService-271b06a8-60ab-426c-9dbc-e025492ab2be', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-271b06a8-60ab-426c-9dbc-e025492ab2be]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-271b06a8-60ab-426c-9dbc-e025492ab2be]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-271f8d81-1dd6-4473-a73e-4550bb5fb684]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-271f8d81-1dd6-4473-a73e-4550bb5fb684] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-271f8d81-1dd6-4473-a73e-4550bb5fb684]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-271f8d81-1dd6-4473-a73e-4550bb5fb684] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-271f8d81-1dd6-4473-a73e-4550bb5fb684') > 0)   DROP SERVICE [SqlQueryNotificationService-271f8d81-1dd6-4473-a73e-4550bb5fb684]; if (OBJECT_ID('SqlQueryNotificationService-271f8d81-1dd6-4473-a73e-4550bb5fb684', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-271f8d81-1dd6-4473-a73e-4550bb5fb684]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-271f8d81-1dd6-4473-a73e-4550bb5fb684]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-29a5b8f1-327c-4929-a35e-9d04dd5a87af]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-29a5b8f1-327c-4929-a35e-9d04dd5a87af] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-29a5b8f1-327c-4929-a35e-9d04dd5a87af]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-29a5b8f1-327c-4929-a35e-9d04dd5a87af] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-29a5b8f1-327c-4929-a35e-9d04dd5a87af') > 0)   DROP SERVICE [SqlQueryNotificationService-29a5b8f1-327c-4929-a35e-9d04dd5a87af]; if (OBJECT_ID('SqlQueryNotificationService-29a5b8f1-327c-4929-a35e-9d04dd5a87af', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-29a5b8f1-327c-4929-a35e-9d04dd5a87af]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-29a5b8f1-327c-4929-a35e-9d04dd5a87af]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-29ab45d6-cecf-4a9e-83d7-5f073cf451ce]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-29ab45d6-cecf-4a9e-83d7-5f073cf451ce] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-29ab45d6-cecf-4a9e-83d7-5f073cf451ce]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-29ab45d6-cecf-4a9e-83d7-5f073cf451ce] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-29ab45d6-cecf-4a9e-83d7-5f073cf451ce') > 0)   DROP SERVICE [SqlQueryNotificationService-29ab45d6-cecf-4a9e-83d7-5f073cf451ce]; if (OBJECT_ID('SqlQueryNotificationService-29ab45d6-cecf-4a9e-83d7-5f073cf451ce', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-29ab45d6-cecf-4a9e-83d7-5f073cf451ce]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-29ab45d6-cecf-4a9e-83d7-5f073cf451ce]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-29f0c2c5-3515-4a67-9fde-480bbfc4c41c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-29f0c2c5-3515-4a67-9fde-480bbfc4c41c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-29f0c2c5-3515-4a67-9fde-480bbfc4c41c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-29f0c2c5-3515-4a67-9fde-480bbfc4c41c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-29f0c2c5-3515-4a67-9fde-480bbfc4c41c') > 0)   DROP SERVICE [SqlQueryNotificationService-29f0c2c5-3515-4a67-9fde-480bbfc4c41c]; if (OBJECT_ID('SqlQueryNotificationService-29f0c2c5-3515-4a67-9fde-480bbfc4c41c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-29f0c2c5-3515-4a67-9fde-480bbfc4c41c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-29f0c2c5-3515-4a67-9fde-480bbfc4c41c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2a072703-c5eb-468c-9161-11c4bdf43368]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2a072703-c5eb-468c-9161-11c4bdf43368] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2a072703-c5eb-468c-9161-11c4bdf43368]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2a072703-c5eb-468c-9161-11c4bdf43368] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2a072703-c5eb-468c-9161-11c4bdf43368') > 0)   DROP SERVICE [SqlQueryNotificationService-2a072703-c5eb-468c-9161-11c4bdf43368]; if (OBJECT_ID('SqlQueryNotificationService-2a072703-c5eb-468c-9161-11c4bdf43368', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2a072703-c5eb-468c-9161-11c4bdf43368]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2a072703-c5eb-468c-9161-11c4bdf43368]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2b51c960-0113-4862-88fb-d4b897a9a5d2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2b51c960-0113-4862-88fb-d4b897a9a5d2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2b51c960-0113-4862-88fb-d4b897a9a5d2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2b51c960-0113-4862-88fb-d4b897a9a5d2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2b51c960-0113-4862-88fb-d4b897a9a5d2') > 0)   DROP SERVICE [SqlQueryNotificationService-2b51c960-0113-4862-88fb-d4b897a9a5d2]; if (OBJECT_ID('SqlQueryNotificationService-2b51c960-0113-4862-88fb-d4b897a9a5d2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2b51c960-0113-4862-88fb-d4b897a9a5d2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2b51c960-0113-4862-88fb-d4b897a9a5d2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2ba76a1f-6889-498c-9572-9e9c54903ecc]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2ba76a1f-6889-498c-9572-9e9c54903ecc] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2ba76a1f-6889-498c-9572-9e9c54903ecc]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2ba76a1f-6889-498c-9572-9e9c54903ecc] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2ba76a1f-6889-498c-9572-9e9c54903ecc') > 0)   DROP SERVICE [SqlQueryNotificationService-2ba76a1f-6889-498c-9572-9e9c54903ecc]; if (OBJECT_ID('SqlQueryNotificationService-2ba76a1f-6889-498c-9572-9e9c54903ecc', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2ba76a1f-6889-498c-9572-9e9c54903ecc]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2ba76a1f-6889-498c-9572-9e9c54903ecc]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2c1ef5a1-f120-4969-af0b-618fee856ca5]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2c1ef5a1-f120-4969-af0b-618fee856ca5] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2c1ef5a1-f120-4969-af0b-618fee856ca5]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2c1ef5a1-f120-4969-af0b-618fee856ca5] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2c1ef5a1-f120-4969-af0b-618fee856ca5') > 0)   DROP SERVICE [SqlQueryNotificationService-2c1ef5a1-f120-4969-af0b-618fee856ca5]; if (OBJECT_ID('SqlQueryNotificationService-2c1ef5a1-f120-4969-af0b-618fee856ca5', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2c1ef5a1-f120-4969-af0b-618fee856ca5]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2c1ef5a1-f120-4969-af0b-618fee856ca5]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2c764526-5395-4f49-807e-f10ee969f128]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2c764526-5395-4f49-807e-f10ee969f128] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2c764526-5395-4f49-807e-f10ee969f128]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2c764526-5395-4f49-807e-f10ee969f128] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2c764526-5395-4f49-807e-f10ee969f128') > 0)   DROP SERVICE [SqlQueryNotificationService-2c764526-5395-4f49-807e-f10ee969f128]; if (OBJECT_ID('SqlQueryNotificationService-2c764526-5395-4f49-807e-f10ee969f128', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2c764526-5395-4f49-807e-f10ee969f128]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2c764526-5395-4f49-807e-f10ee969f128]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2d5c5ba6-2848-4c37-818b-511b006b06ec]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2d5c5ba6-2848-4c37-818b-511b006b06ec] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2d5c5ba6-2848-4c37-818b-511b006b06ec]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2d5c5ba6-2848-4c37-818b-511b006b06ec] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2d5c5ba6-2848-4c37-818b-511b006b06ec') > 0)   DROP SERVICE [SqlQueryNotificationService-2d5c5ba6-2848-4c37-818b-511b006b06ec]; if (OBJECT_ID('SqlQueryNotificationService-2d5c5ba6-2848-4c37-818b-511b006b06ec', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2d5c5ba6-2848-4c37-818b-511b006b06ec]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2d5c5ba6-2848-4c37-818b-511b006b06ec]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c') > 0)   DROP SERVICE [SqlQueryNotificationService-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c]; if (OBJECT_ID('SqlQueryNotificationService-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2db8b7d9-7c17-4626-bfa1-b7106e1ead4c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2e025a50-527c-4d83-a2da-ae4812c04f28]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2e025a50-527c-4d83-a2da-ae4812c04f28] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2e025a50-527c-4d83-a2da-ae4812c04f28]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2e025a50-527c-4d83-a2da-ae4812c04f28] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2e025a50-527c-4d83-a2da-ae4812c04f28') > 0)   DROP SERVICE [SqlQueryNotificationService-2e025a50-527c-4d83-a2da-ae4812c04f28]; if (OBJECT_ID('SqlQueryNotificationService-2e025a50-527c-4d83-a2da-ae4812c04f28', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2e025a50-527c-4d83-a2da-ae4812c04f28]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2e025a50-527c-4d83-a2da-ae4812c04f28]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2e4937dd-0a38-47ee-96da-43db7b4acdc4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2e4937dd-0a38-47ee-96da-43db7b4acdc4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2e4937dd-0a38-47ee-96da-43db7b4acdc4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2e4937dd-0a38-47ee-96da-43db7b4acdc4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2e4937dd-0a38-47ee-96da-43db7b4acdc4') > 0)   DROP SERVICE [SqlQueryNotificationService-2e4937dd-0a38-47ee-96da-43db7b4acdc4]; if (OBJECT_ID('SqlQueryNotificationService-2e4937dd-0a38-47ee-96da-43db7b4acdc4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2e4937dd-0a38-47ee-96da-43db7b4acdc4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2e4937dd-0a38-47ee-96da-43db7b4acdc4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06') > 0)   DROP SERVICE [SqlQueryNotificationService-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06]; if (OBJECT_ID('SqlQueryNotificationService-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2e7f0f0f-cd04-4f59-943e-b6f7a38a5e06]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2e875988-0b78-4e79-8319-158b1c2168db]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2e875988-0b78-4e79-8319-158b1c2168db] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2e875988-0b78-4e79-8319-158b1c2168db]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2e875988-0b78-4e79-8319-158b1c2168db] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2e875988-0b78-4e79-8319-158b1c2168db') > 0)   DROP SERVICE [SqlQueryNotificationService-2e875988-0b78-4e79-8319-158b1c2168db]; if (OBJECT_ID('SqlQueryNotificationService-2e875988-0b78-4e79-8319-158b1c2168db', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2e875988-0b78-4e79-8319-158b1c2168db]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2e875988-0b78-4e79-8319-158b1c2168db]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2f34c250-b40a-41a4-91a5-5a71509bdad3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2f34c250-b40a-41a4-91a5-5a71509bdad3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2f34c250-b40a-41a4-91a5-5a71509bdad3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2f34c250-b40a-41a4-91a5-5a71509bdad3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2f34c250-b40a-41a4-91a5-5a71509bdad3') > 0)   DROP SERVICE [SqlQueryNotificationService-2f34c250-b40a-41a4-91a5-5a71509bdad3]; if (OBJECT_ID('SqlQueryNotificationService-2f34c250-b40a-41a4-91a5-5a71509bdad3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2f34c250-b40a-41a4-91a5-5a71509bdad3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2f34c250-b40a-41a4-91a5-5a71509bdad3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-2f62b667-935e-4007-a7ed-ed7e319d1954]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-2f62b667-935e-4007-a7ed-ed7e319d1954] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-2f62b667-935e-4007-a7ed-ed7e319d1954]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-2f62b667-935e-4007-a7ed-ed7e319d1954] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-2f62b667-935e-4007-a7ed-ed7e319d1954') > 0)   DROP SERVICE [SqlQueryNotificationService-2f62b667-935e-4007-a7ed-ed7e319d1954]; if (OBJECT_ID('SqlQueryNotificationService-2f62b667-935e-4007-a7ed-ed7e319d1954', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-2f62b667-935e-4007-a7ed-ed7e319d1954]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-2f62b667-935e-4007-a7ed-ed7e319d1954]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-302f7aff-b2a6-4d7f-a6d6-64a528b99127]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-302f7aff-b2a6-4d7f-a6d6-64a528b99127] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-302f7aff-b2a6-4d7f-a6d6-64a528b99127]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-302f7aff-b2a6-4d7f-a6d6-64a528b99127] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-302f7aff-b2a6-4d7f-a6d6-64a528b99127') > 0)   DROP SERVICE [SqlQueryNotificationService-302f7aff-b2a6-4d7f-a6d6-64a528b99127]; if (OBJECT_ID('SqlQueryNotificationService-302f7aff-b2a6-4d7f-a6d6-64a528b99127', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-302f7aff-b2a6-4d7f-a6d6-64a528b99127]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-302f7aff-b2a6-4d7f-a6d6-64a528b99127]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-30abc482-4d13-4db6-86eb-1fc19211d6f0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-30abc482-4d13-4db6-86eb-1fc19211d6f0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-30abc482-4d13-4db6-86eb-1fc19211d6f0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-30abc482-4d13-4db6-86eb-1fc19211d6f0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-30abc482-4d13-4db6-86eb-1fc19211d6f0') > 0)   DROP SERVICE [SqlQueryNotificationService-30abc482-4d13-4db6-86eb-1fc19211d6f0]; if (OBJECT_ID('SqlQueryNotificationService-30abc482-4d13-4db6-86eb-1fc19211d6f0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-30abc482-4d13-4db6-86eb-1fc19211d6f0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-30abc482-4d13-4db6-86eb-1fc19211d6f0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-313b64d5-b614-4e0b-bf79-ddc42011eff3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-313b64d5-b614-4e0b-bf79-ddc42011eff3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-313b64d5-b614-4e0b-bf79-ddc42011eff3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-313b64d5-b614-4e0b-bf79-ddc42011eff3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-313b64d5-b614-4e0b-bf79-ddc42011eff3') > 0)   DROP SERVICE [SqlQueryNotificationService-313b64d5-b614-4e0b-bf79-ddc42011eff3]; if (OBJECT_ID('SqlQueryNotificationService-313b64d5-b614-4e0b-bf79-ddc42011eff3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-313b64d5-b614-4e0b-bf79-ddc42011eff3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-313b64d5-b614-4e0b-bf79-ddc42011eff3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-31661184-31dd-4809-9d2a-f251be461edd]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-31661184-31dd-4809-9d2a-f251be461edd] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-31661184-31dd-4809-9d2a-f251be461edd]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-31661184-31dd-4809-9d2a-f251be461edd] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-31661184-31dd-4809-9d2a-f251be461edd') > 0)   DROP SERVICE [SqlQueryNotificationService-31661184-31dd-4809-9d2a-f251be461edd]; if (OBJECT_ID('SqlQueryNotificationService-31661184-31dd-4809-9d2a-f251be461edd', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-31661184-31dd-4809-9d2a-f251be461edd]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-31661184-31dd-4809-9d2a-f251be461edd]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-318a579b-c7a5-454c-af26-d23188dec47a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-318a579b-c7a5-454c-af26-d23188dec47a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-318a579b-c7a5-454c-af26-d23188dec47a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-318a579b-c7a5-454c-af26-d23188dec47a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-318a579b-c7a5-454c-af26-d23188dec47a') > 0)   DROP SERVICE [SqlQueryNotificationService-318a579b-c7a5-454c-af26-d23188dec47a]; if (OBJECT_ID('SqlQueryNotificationService-318a579b-c7a5-454c-af26-d23188dec47a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-318a579b-c7a5-454c-af26-d23188dec47a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-318a579b-c7a5-454c-af26-d23188dec47a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3539e45e-7d18-41a9-9364-b7b9ea7e8b59]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3539e45e-7d18-41a9-9364-b7b9ea7e8b59] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3539e45e-7d18-41a9-9364-b7b9ea7e8b59]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3539e45e-7d18-41a9-9364-b7b9ea7e8b59] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3539e45e-7d18-41a9-9364-b7b9ea7e8b59') > 0)   DROP SERVICE [SqlQueryNotificationService-3539e45e-7d18-41a9-9364-b7b9ea7e8b59]; if (OBJECT_ID('SqlQueryNotificationService-3539e45e-7d18-41a9-9364-b7b9ea7e8b59', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3539e45e-7d18-41a9-9364-b7b9ea7e8b59]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3539e45e-7d18-41a9-9364-b7b9ea7e8b59]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-373c8c98-06d7-424a-b58e-7ff219794f04]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-373c8c98-06d7-424a-b58e-7ff219794f04] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-373c8c98-06d7-424a-b58e-7ff219794f04]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-373c8c98-06d7-424a-b58e-7ff219794f04] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-373c8c98-06d7-424a-b58e-7ff219794f04') > 0)   DROP SERVICE [SqlQueryNotificationService-373c8c98-06d7-424a-b58e-7ff219794f04]; if (OBJECT_ID('SqlQueryNotificationService-373c8c98-06d7-424a-b58e-7ff219794f04', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-373c8c98-06d7-424a-b58e-7ff219794f04]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-373c8c98-06d7-424a-b58e-7ff219794f04]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-37c717df-19f4-43e7-936b-1b36c64b0edd]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-37c717df-19f4-43e7-936b-1b36c64b0edd] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-37c717df-19f4-43e7-936b-1b36c64b0edd]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-37c717df-19f4-43e7-936b-1b36c64b0edd] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-37c717df-19f4-43e7-936b-1b36c64b0edd') > 0)   DROP SERVICE [SqlQueryNotificationService-37c717df-19f4-43e7-936b-1b36c64b0edd]; if (OBJECT_ID('SqlQueryNotificationService-37c717df-19f4-43e7-936b-1b36c64b0edd', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-37c717df-19f4-43e7-936b-1b36c64b0edd]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-37c717df-19f4-43e7-936b-1b36c64b0edd]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-38c5ad97-21dd-4887-971b-4dbd411922ed]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-38c5ad97-21dd-4887-971b-4dbd411922ed] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-38c5ad97-21dd-4887-971b-4dbd411922ed]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-38c5ad97-21dd-4887-971b-4dbd411922ed] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-38c5ad97-21dd-4887-971b-4dbd411922ed') > 0)   DROP SERVICE [SqlQueryNotificationService-38c5ad97-21dd-4887-971b-4dbd411922ed]; if (OBJECT_ID('SqlQueryNotificationService-38c5ad97-21dd-4887-971b-4dbd411922ed', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-38c5ad97-21dd-4887-971b-4dbd411922ed]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-38c5ad97-21dd-4887-971b-4dbd411922ed]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-38fed837-8665-4465-8f97-bd5fdb719aea]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-38fed837-8665-4465-8f97-bd5fdb719aea] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-38fed837-8665-4465-8f97-bd5fdb719aea]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-38fed837-8665-4465-8f97-bd5fdb719aea] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-38fed837-8665-4465-8f97-bd5fdb719aea') > 0)   DROP SERVICE [SqlQueryNotificationService-38fed837-8665-4465-8f97-bd5fdb719aea]; if (OBJECT_ID('SqlQueryNotificationService-38fed837-8665-4465-8f97-bd5fdb719aea', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-38fed837-8665-4465-8f97-bd5fdb719aea]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-38fed837-8665-4465-8f97-bd5fdb719aea]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-390e109d-17bc-433a-b2d9-5421a4d7c7ac]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-390e109d-17bc-433a-b2d9-5421a4d7c7ac] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-390e109d-17bc-433a-b2d9-5421a4d7c7ac]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-390e109d-17bc-433a-b2d9-5421a4d7c7ac] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-390e109d-17bc-433a-b2d9-5421a4d7c7ac') > 0)   DROP SERVICE [SqlQueryNotificationService-390e109d-17bc-433a-b2d9-5421a4d7c7ac]; if (OBJECT_ID('SqlQueryNotificationService-390e109d-17bc-433a-b2d9-5421a4d7c7ac', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-390e109d-17bc-433a-b2d9-5421a4d7c7ac]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-390e109d-17bc-433a-b2d9-5421a4d7c7ac]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-39e7daae-2031-4ceb-a935-2fd6ba18a2ca]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-39e7daae-2031-4ceb-a935-2fd6ba18a2ca] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-39e7daae-2031-4ceb-a935-2fd6ba18a2ca]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-39e7daae-2031-4ceb-a935-2fd6ba18a2ca] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-39e7daae-2031-4ceb-a935-2fd6ba18a2ca') > 0)   DROP SERVICE [SqlQueryNotificationService-39e7daae-2031-4ceb-a935-2fd6ba18a2ca]; if (OBJECT_ID('SqlQueryNotificationService-39e7daae-2031-4ceb-a935-2fd6ba18a2ca', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-39e7daae-2031-4ceb-a935-2fd6ba18a2ca]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-39e7daae-2031-4ceb-a935-2fd6ba18a2ca]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3ac15c5d-c846-444d-a988-dbaa636e30ef]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3ac15c5d-c846-444d-a988-dbaa636e30ef] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3ac15c5d-c846-444d-a988-dbaa636e30ef]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3ac15c5d-c846-444d-a988-dbaa636e30ef] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3ac15c5d-c846-444d-a988-dbaa636e30ef') > 0)   DROP SERVICE [SqlQueryNotificationService-3ac15c5d-c846-444d-a988-dbaa636e30ef]; if (OBJECT_ID('SqlQueryNotificationService-3ac15c5d-c846-444d-a988-dbaa636e30ef', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3ac15c5d-c846-444d-a988-dbaa636e30ef]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3ac15c5d-c846-444d-a988-dbaa636e30ef]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3ae204c9-01e9-4c47-b0ee-728558026e91]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3ae204c9-01e9-4c47-b0ee-728558026e91] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3ae204c9-01e9-4c47-b0ee-728558026e91]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3ae204c9-01e9-4c47-b0ee-728558026e91] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3ae204c9-01e9-4c47-b0ee-728558026e91') > 0)   DROP SERVICE [SqlQueryNotificationService-3ae204c9-01e9-4c47-b0ee-728558026e91]; if (OBJECT_ID('SqlQueryNotificationService-3ae204c9-01e9-4c47-b0ee-728558026e91', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3ae204c9-01e9-4c47-b0ee-728558026e91]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3ae204c9-01e9-4c47-b0ee-728558026e91]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3cf997ec-e791-4eba-be5a-d17a8abda9d6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3cf997ec-e791-4eba-be5a-d17a8abda9d6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3cf997ec-e791-4eba-be5a-d17a8abda9d6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3cf997ec-e791-4eba-be5a-d17a8abda9d6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3cf997ec-e791-4eba-be5a-d17a8abda9d6') > 0)   DROP SERVICE [SqlQueryNotificationService-3cf997ec-e791-4eba-be5a-d17a8abda9d6]; if (OBJECT_ID('SqlQueryNotificationService-3cf997ec-e791-4eba-be5a-d17a8abda9d6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3cf997ec-e791-4eba-be5a-d17a8abda9d6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3cf997ec-e791-4eba-be5a-d17a8abda9d6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3dd1fdb9-7178-49e7-ad36-8846670c2c28]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3dd1fdb9-7178-49e7-ad36-8846670c2c28] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3dd1fdb9-7178-49e7-ad36-8846670c2c28]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3dd1fdb9-7178-49e7-ad36-8846670c2c28] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3dd1fdb9-7178-49e7-ad36-8846670c2c28') > 0)   DROP SERVICE [SqlQueryNotificationService-3dd1fdb9-7178-49e7-ad36-8846670c2c28]; if (OBJECT_ID('SqlQueryNotificationService-3dd1fdb9-7178-49e7-ad36-8846670c2c28', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3dd1fdb9-7178-49e7-ad36-8846670c2c28]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3dd1fdb9-7178-49e7-ad36-8846670c2c28]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3dd59500-8bab-40c6-8c95-72a35c4b4436]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3dd59500-8bab-40c6-8c95-72a35c4b4436] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3dd59500-8bab-40c6-8c95-72a35c4b4436]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3dd59500-8bab-40c6-8c95-72a35c4b4436] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3dd59500-8bab-40c6-8c95-72a35c4b4436') > 0)   DROP SERVICE [SqlQueryNotificationService-3dd59500-8bab-40c6-8c95-72a35c4b4436]; if (OBJECT_ID('SqlQueryNotificationService-3dd59500-8bab-40c6-8c95-72a35c4b4436', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3dd59500-8bab-40c6-8c95-72a35c4b4436]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3dd59500-8bab-40c6-8c95-72a35c4b4436]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3ea2876d-8946-43fb-989e-5fb55358138e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3ea2876d-8946-43fb-989e-5fb55358138e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3ea2876d-8946-43fb-989e-5fb55358138e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3ea2876d-8946-43fb-989e-5fb55358138e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3ea2876d-8946-43fb-989e-5fb55358138e') > 0)   DROP SERVICE [SqlQueryNotificationService-3ea2876d-8946-43fb-989e-5fb55358138e]; if (OBJECT_ID('SqlQueryNotificationService-3ea2876d-8946-43fb-989e-5fb55358138e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3ea2876d-8946-43fb-989e-5fb55358138e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3ea2876d-8946-43fb-989e-5fb55358138e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe') > 0)   DROP SERVICE [SqlQueryNotificationService-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe]; if (OBJECT_ID('SqlQueryNotificationService-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3f373ab6-3be3-4fc9-ac50-c2b81e8491fe]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-3fcba8ea-308f-432e-a5e9-d08999414fa3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-3fcba8ea-308f-432e-a5e9-d08999414fa3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-3fcba8ea-308f-432e-a5e9-d08999414fa3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-3fcba8ea-308f-432e-a5e9-d08999414fa3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-3fcba8ea-308f-432e-a5e9-d08999414fa3') > 0)   DROP SERVICE [SqlQueryNotificationService-3fcba8ea-308f-432e-a5e9-d08999414fa3]; if (OBJECT_ID('SqlQueryNotificationService-3fcba8ea-308f-432e-a5e9-d08999414fa3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-3fcba8ea-308f-432e-a5e9-d08999414fa3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-3fcba8ea-308f-432e-a5e9-d08999414fa3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-40844793-be49-4aab-bfe4-43d6f79028cb]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-40844793-be49-4aab-bfe4-43d6f79028cb] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-40844793-be49-4aab-bfe4-43d6f79028cb]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-40844793-be49-4aab-bfe4-43d6f79028cb] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-40844793-be49-4aab-bfe4-43d6f79028cb') > 0)   DROP SERVICE [SqlQueryNotificationService-40844793-be49-4aab-bfe4-43d6f79028cb]; if (OBJECT_ID('SqlQueryNotificationService-40844793-be49-4aab-bfe4-43d6f79028cb', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-40844793-be49-4aab-bfe4-43d6f79028cb]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-40844793-be49-4aab-bfe4-43d6f79028cb]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-40d27903-a176-483a-bac8-6a69c0ba8865]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-40d27903-a176-483a-bac8-6a69c0ba8865] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-40d27903-a176-483a-bac8-6a69c0ba8865]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-40d27903-a176-483a-bac8-6a69c0ba8865] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-40d27903-a176-483a-bac8-6a69c0ba8865') > 0)   DROP SERVICE [SqlQueryNotificationService-40d27903-a176-483a-bac8-6a69c0ba8865]; if (OBJECT_ID('SqlQueryNotificationService-40d27903-a176-483a-bac8-6a69c0ba8865', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-40d27903-a176-483a-bac8-6a69c0ba8865]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-40d27903-a176-483a-bac8-6a69c0ba8865]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-40eee4ac-e8ef-417a-aefe-924c5a306736]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-40eee4ac-e8ef-417a-aefe-924c5a306736] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-40eee4ac-e8ef-417a-aefe-924c5a306736]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-40eee4ac-e8ef-417a-aefe-924c5a306736] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-40eee4ac-e8ef-417a-aefe-924c5a306736') > 0)   DROP SERVICE [SqlQueryNotificationService-40eee4ac-e8ef-417a-aefe-924c5a306736]; if (OBJECT_ID('SqlQueryNotificationService-40eee4ac-e8ef-417a-aefe-924c5a306736', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-40eee4ac-e8ef-417a-aefe-924c5a306736]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-40eee4ac-e8ef-417a-aefe-924c5a306736]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-41390fff-b0e1-45d9-8a95-9a08a286c6a9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-41390fff-b0e1-45d9-8a95-9a08a286c6a9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-41390fff-b0e1-45d9-8a95-9a08a286c6a9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-41390fff-b0e1-45d9-8a95-9a08a286c6a9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-41390fff-b0e1-45d9-8a95-9a08a286c6a9') > 0)   DROP SERVICE [SqlQueryNotificationService-41390fff-b0e1-45d9-8a95-9a08a286c6a9]; if (OBJECT_ID('SqlQueryNotificationService-41390fff-b0e1-45d9-8a95-9a08a286c6a9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-41390fff-b0e1-45d9-8a95-9a08a286c6a9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-41390fff-b0e1-45d9-8a95-9a08a286c6a9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-41ad8efc-aad0-4203-abf6-f1f0164b9a3d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-41ad8efc-aad0-4203-abf6-f1f0164b9a3d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-41ad8efc-aad0-4203-abf6-f1f0164b9a3d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-41ad8efc-aad0-4203-abf6-f1f0164b9a3d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-41ad8efc-aad0-4203-abf6-f1f0164b9a3d') > 0)   DROP SERVICE [SqlQueryNotificationService-41ad8efc-aad0-4203-abf6-f1f0164b9a3d]; if (OBJECT_ID('SqlQueryNotificationService-41ad8efc-aad0-4203-abf6-f1f0164b9a3d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-41ad8efc-aad0-4203-abf6-f1f0164b9a3d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-41ad8efc-aad0-4203-abf6-f1f0164b9a3d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-41f47be0-65d7-44a4-9318-a7f876d54f24]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-41f47be0-65d7-44a4-9318-a7f876d54f24] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-41f47be0-65d7-44a4-9318-a7f876d54f24]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-41f47be0-65d7-44a4-9318-a7f876d54f24] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-41f47be0-65d7-44a4-9318-a7f876d54f24') > 0)   DROP SERVICE [SqlQueryNotificationService-41f47be0-65d7-44a4-9318-a7f876d54f24]; if (OBJECT_ID('SqlQueryNotificationService-41f47be0-65d7-44a4-9318-a7f876d54f24', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-41f47be0-65d7-44a4-9318-a7f876d54f24]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-41f47be0-65d7-44a4-9318-a7f876d54f24]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-448b4793-0523-4e60-a494-1bb1c70fa107]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-448b4793-0523-4e60-a494-1bb1c70fa107] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-448b4793-0523-4e60-a494-1bb1c70fa107]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-448b4793-0523-4e60-a494-1bb1c70fa107] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-448b4793-0523-4e60-a494-1bb1c70fa107') > 0)   DROP SERVICE [SqlQueryNotificationService-448b4793-0523-4e60-a494-1bb1c70fa107]; if (OBJECT_ID('SqlQueryNotificationService-448b4793-0523-4e60-a494-1bb1c70fa107', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-448b4793-0523-4e60-a494-1bb1c70fa107]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-448b4793-0523-4e60-a494-1bb1c70fa107]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4503c469-013d-4a0a-a23d-0006d0d558e1]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4503c469-013d-4a0a-a23d-0006d0d558e1] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4503c469-013d-4a0a-a23d-0006d0d558e1]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4503c469-013d-4a0a-a23d-0006d0d558e1] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4503c469-013d-4a0a-a23d-0006d0d558e1') > 0)   DROP SERVICE [SqlQueryNotificationService-4503c469-013d-4a0a-a23d-0006d0d558e1]; if (OBJECT_ID('SqlQueryNotificationService-4503c469-013d-4a0a-a23d-0006d0d558e1', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4503c469-013d-4a0a-a23d-0006d0d558e1]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4503c469-013d-4a0a-a23d-0006d0d558e1]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-45418321-311e-43cf-ba4d-7446d6def82c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-45418321-311e-43cf-ba4d-7446d6def82c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-45418321-311e-43cf-ba4d-7446d6def82c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-45418321-311e-43cf-ba4d-7446d6def82c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-45418321-311e-43cf-ba4d-7446d6def82c') > 0)   DROP SERVICE [SqlQueryNotificationService-45418321-311e-43cf-ba4d-7446d6def82c]; if (OBJECT_ID('SqlQueryNotificationService-45418321-311e-43cf-ba4d-7446d6def82c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-45418321-311e-43cf-ba4d-7446d6def82c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-45418321-311e-43cf-ba4d-7446d6def82c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-45ab2477-a96f-4c93-a1fb-3d5a2d90546f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-45ab2477-a96f-4c93-a1fb-3d5a2d90546f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-45ab2477-a96f-4c93-a1fb-3d5a2d90546f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-45ab2477-a96f-4c93-a1fb-3d5a2d90546f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-45ab2477-a96f-4c93-a1fb-3d5a2d90546f') > 0)   DROP SERVICE [SqlQueryNotificationService-45ab2477-a96f-4c93-a1fb-3d5a2d90546f]; if (OBJECT_ID('SqlQueryNotificationService-45ab2477-a96f-4c93-a1fb-3d5a2d90546f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-45ab2477-a96f-4c93-a1fb-3d5a2d90546f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-45ab2477-a96f-4c93-a1fb-3d5a2d90546f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-46b24892-802b-48f9-9edb-c9a37dd8956d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-46b24892-802b-48f9-9edb-c9a37dd8956d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-46b24892-802b-48f9-9edb-c9a37dd8956d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-46b24892-802b-48f9-9edb-c9a37dd8956d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-46b24892-802b-48f9-9edb-c9a37dd8956d') > 0)   DROP SERVICE [SqlQueryNotificationService-46b24892-802b-48f9-9edb-c9a37dd8956d]; if (OBJECT_ID('SqlQueryNotificationService-46b24892-802b-48f9-9edb-c9a37dd8956d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-46b24892-802b-48f9-9edb-c9a37dd8956d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-46b24892-802b-48f9-9edb-c9a37dd8956d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-474ab4dc-7796-4462-8bf0-52c132c49235]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-474ab4dc-7796-4462-8bf0-52c132c49235] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-474ab4dc-7796-4462-8bf0-52c132c49235]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-474ab4dc-7796-4462-8bf0-52c132c49235] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-474ab4dc-7796-4462-8bf0-52c132c49235') > 0)   DROP SERVICE [SqlQueryNotificationService-474ab4dc-7796-4462-8bf0-52c132c49235]; if (OBJECT_ID('SqlQueryNotificationService-474ab4dc-7796-4462-8bf0-52c132c49235', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-474ab4dc-7796-4462-8bf0-52c132c49235]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-474ab4dc-7796-4462-8bf0-52c132c49235]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-474ec481-34c9-4dd3-92f2-b074bfc8a734]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-474ec481-34c9-4dd3-92f2-b074bfc8a734] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-474ec481-34c9-4dd3-92f2-b074bfc8a734]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-474ec481-34c9-4dd3-92f2-b074bfc8a734] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-474ec481-34c9-4dd3-92f2-b074bfc8a734') > 0)   DROP SERVICE [SqlQueryNotificationService-474ec481-34c9-4dd3-92f2-b074bfc8a734]; if (OBJECT_ID('SqlQueryNotificationService-474ec481-34c9-4dd3-92f2-b074bfc8a734', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-474ec481-34c9-4dd3-92f2-b074bfc8a734]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-474ec481-34c9-4dd3-92f2-b074bfc8a734]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe') > 0)   DROP SERVICE [SqlQueryNotificationService-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe]; if (OBJECT_ID('SqlQueryNotificationService-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-48c4db79-8f2d-46c8-afdf-3c0bbb959cbe]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-493a0093-9e0f-4ec3-8f83-a1c0803a899d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-493a0093-9e0f-4ec3-8f83-a1c0803a899d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-493a0093-9e0f-4ec3-8f83-a1c0803a899d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-493a0093-9e0f-4ec3-8f83-a1c0803a899d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-493a0093-9e0f-4ec3-8f83-a1c0803a899d') > 0)   DROP SERVICE [SqlQueryNotificationService-493a0093-9e0f-4ec3-8f83-a1c0803a899d]; if (OBJECT_ID('SqlQueryNotificationService-493a0093-9e0f-4ec3-8f83-a1c0803a899d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-493a0093-9e0f-4ec3-8f83-a1c0803a899d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-493a0093-9e0f-4ec3-8f83-a1c0803a899d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4991aa4c-18e1-4224-a2c0-7b01f5415dd0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4991aa4c-18e1-4224-a2c0-7b01f5415dd0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4991aa4c-18e1-4224-a2c0-7b01f5415dd0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4991aa4c-18e1-4224-a2c0-7b01f5415dd0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4991aa4c-18e1-4224-a2c0-7b01f5415dd0') > 0)   DROP SERVICE [SqlQueryNotificationService-4991aa4c-18e1-4224-a2c0-7b01f5415dd0]; if (OBJECT_ID('SqlQueryNotificationService-4991aa4c-18e1-4224-a2c0-7b01f5415dd0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4991aa4c-18e1-4224-a2c0-7b01f5415dd0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4991aa4c-18e1-4224-a2c0-7b01f5415dd0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4bc98400-8430-4144-86a8-4c7bcdf6cf7e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4bc98400-8430-4144-86a8-4c7bcdf6cf7e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4bc98400-8430-4144-86a8-4c7bcdf6cf7e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4bc98400-8430-4144-86a8-4c7bcdf6cf7e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4bc98400-8430-4144-86a8-4c7bcdf6cf7e') > 0)   DROP SERVICE [SqlQueryNotificationService-4bc98400-8430-4144-86a8-4c7bcdf6cf7e]; if (OBJECT_ID('SqlQueryNotificationService-4bc98400-8430-4144-86a8-4c7bcdf6cf7e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4bc98400-8430-4144-86a8-4c7bcdf6cf7e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4bc98400-8430-4144-86a8-4c7bcdf6cf7e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe') > 0)   DROP SERVICE [SqlQueryNotificationService-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe]; if (OBJECT_ID('SqlQueryNotificationService-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4c3541ff-a5cb-42ab-945b-3bf3540ca4fe]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4cbdb18a-cc45-48dd-a054-dc3e69aa5829]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4cbdb18a-cc45-48dd-a054-dc3e69aa5829] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4cbdb18a-cc45-48dd-a054-dc3e69aa5829]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4cbdb18a-cc45-48dd-a054-dc3e69aa5829] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4cbdb18a-cc45-48dd-a054-dc3e69aa5829') > 0)   DROP SERVICE [SqlQueryNotificationService-4cbdb18a-cc45-48dd-a054-dc3e69aa5829]; if (OBJECT_ID('SqlQueryNotificationService-4cbdb18a-cc45-48dd-a054-dc3e69aa5829', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4cbdb18a-cc45-48dd-a054-dc3e69aa5829]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4cbdb18a-cc45-48dd-a054-dc3e69aa5829]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4e473370-7ef9-4dec-bf0d-83575dd83e29]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4e473370-7ef9-4dec-bf0d-83575dd83e29] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4e473370-7ef9-4dec-bf0d-83575dd83e29]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4e473370-7ef9-4dec-bf0d-83575dd83e29] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4e473370-7ef9-4dec-bf0d-83575dd83e29') > 0)   DROP SERVICE [SqlQueryNotificationService-4e473370-7ef9-4dec-bf0d-83575dd83e29]; if (OBJECT_ID('SqlQueryNotificationService-4e473370-7ef9-4dec-bf0d-83575dd83e29', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4e473370-7ef9-4dec-bf0d-83575dd83e29]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4e473370-7ef9-4dec-bf0d-83575dd83e29]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-4f881b32-9567-45b9-9139-0f43cbb8530c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-4f881b32-9567-45b9-9139-0f43cbb8530c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-4f881b32-9567-45b9-9139-0f43cbb8530c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-4f881b32-9567-45b9-9139-0f43cbb8530c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-4f881b32-9567-45b9-9139-0f43cbb8530c') > 0)   DROP SERVICE [SqlQueryNotificationService-4f881b32-9567-45b9-9139-0f43cbb8530c]; if (OBJECT_ID('SqlQueryNotificationService-4f881b32-9567-45b9-9139-0f43cbb8530c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-4f881b32-9567-45b9-9139-0f43cbb8530c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-4f881b32-9567-45b9-9139-0f43cbb8530c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-514a13aa-b98d-46f7-af77-199ace02eb4f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-514a13aa-b98d-46f7-af77-199ace02eb4f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-514a13aa-b98d-46f7-af77-199ace02eb4f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-514a13aa-b98d-46f7-af77-199ace02eb4f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-514a13aa-b98d-46f7-af77-199ace02eb4f') > 0)   DROP SERVICE [SqlQueryNotificationService-514a13aa-b98d-46f7-af77-199ace02eb4f]; if (OBJECT_ID('SqlQueryNotificationService-514a13aa-b98d-46f7-af77-199ace02eb4f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-514a13aa-b98d-46f7-af77-199ace02eb4f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-514a13aa-b98d-46f7-af77-199ace02eb4f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-51c76695-a6e7-45f2-a414-ff64a000873a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-51c76695-a6e7-45f2-a414-ff64a000873a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-51c76695-a6e7-45f2-a414-ff64a000873a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-51c76695-a6e7-45f2-a414-ff64a000873a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-51c76695-a6e7-45f2-a414-ff64a000873a') > 0)   DROP SERVICE [SqlQueryNotificationService-51c76695-a6e7-45f2-a414-ff64a000873a]; if (OBJECT_ID('SqlQueryNotificationService-51c76695-a6e7-45f2-a414-ff64a000873a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-51c76695-a6e7-45f2-a414-ff64a000873a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-51c76695-a6e7-45f2-a414-ff64a000873a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-52f07c6b-a983-499c-95dd-dc0d7d5afb6b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-52f07c6b-a983-499c-95dd-dc0d7d5afb6b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-52f07c6b-a983-499c-95dd-dc0d7d5afb6b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-52f07c6b-a983-499c-95dd-dc0d7d5afb6b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-52f07c6b-a983-499c-95dd-dc0d7d5afb6b') > 0)   DROP SERVICE [SqlQueryNotificationService-52f07c6b-a983-499c-95dd-dc0d7d5afb6b]; if (OBJECT_ID('SqlQueryNotificationService-52f07c6b-a983-499c-95dd-dc0d7d5afb6b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-52f07c6b-a983-499c-95dd-dc0d7d5afb6b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-52f07c6b-a983-499c-95dd-dc0d7d5afb6b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-535640a7-2d34-4d65-9264-0e06012f67dd]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-535640a7-2d34-4d65-9264-0e06012f67dd] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-535640a7-2d34-4d65-9264-0e06012f67dd]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-535640a7-2d34-4d65-9264-0e06012f67dd] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-535640a7-2d34-4d65-9264-0e06012f67dd') > 0)   DROP SERVICE [SqlQueryNotificationService-535640a7-2d34-4d65-9264-0e06012f67dd]; if (OBJECT_ID('SqlQueryNotificationService-535640a7-2d34-4d65-9264-0e06012f67dd', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-535640a7-2d34-4d65-9264-0e06012f67dd]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-535640a7-2d34-4d65-9264-0e06012f67dd]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5498d333-2aa2-4243-b677-48631f35ce13]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5498d333-2aa2-4243-b677-48631f35ce13] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5498d333-2aa2-4243-b677-48631f35ce13]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5498d333-2aa2-4243-b677-48631f35ce13] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5498d333-2aa2-4243-b677-48631f35ce13') > 0)   DROP SERVICE [SqlQueryNotificationService-5498d333-2aa2-4243-b677-48631f35ce13]; if (OBJECT_ID('SqlQueryNotificationService-5498d333-2aa2-4243-b677-48631f35ce13', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5498d333-2aa2-4243-b677-48631f35ce13]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5498d333-2aa2-4243-b677-48631f35ce13]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-598d5f18-f03f-4f35-b111-26c2bfa512c1]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-598d5f18-f03f-4f35-b111-26c2bfa512c1] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-598d5f18-f03f-4f35-b111-26c2bfa512c1]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-598d5f18-f03f-4f35-b111-26c2bfa512c1] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-598d5f18-f03f-4f35-b111-26c2bfa512c1') > 0)   DROP SERVICE [SqlQueryNotificationService-598d5f18-f03f-4f35-b111-26c2bfa512c1]; if (OBJECT_ID('SqlQueryNotificationService-598d5f18-f03f-4f35-b111-26c2bfa512c1', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-598d5f18-f03f-4f35-b111-26c2bfa512c1]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-598d5f18-f03f-4f35-b111-26c2bfa512c1]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6') > 0)   DROP SERVICE [SqlQueryNotificationService-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6]; if (OBJECT_ID('SqlQueryNotificationService-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5a3d4746-2cf3-46f6-88f5-fd84886a6cf6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5ac1185d-9bce-4057-b705-b3965978f59c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5ac1185d-9bce-4057-b705-b3965978f59c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5ac1185d-9bce-4057-b705-b3965978f59c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5ac1185d-9bce-4057-b705-b3965978f59c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5ac1185d-9bce-4057-b705-b3965978f59c') > 0)   DROP SERVICE [SqlQueryNotificationService-5ac1185d-9bce-4057-b705-b3965978f59c]; if (OBJECT_ID('SqlQueryNotificationService-5ac1185d-9bce-4057-b705-b3965978f59c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5ac1185d-9bce-4057-b705-b3965978f59c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5ac1185d-9bce-4057-b705-b3965978f59c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5af7212f-65de-453d-a150-e2f372f46475]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5af7212f-65de-453d-a150-e2f372f46475] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5af7212f-65de-453d-a150-e2f372f46475]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5af7212f-65de-453d-a150-e2f372f46475] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5af7212f-65de-453d-a150-e2f372f46475') > 0)   DROP SERVICE [SqlQueryNotificationService-5af7212f-65de-453d-a150-e2f372f46475]; if (OBJECT_ID('SqlQueryNotificationService-5af7212f-65de-453d-a150-e2f372f46475', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5af7212f-65de-453d-a150-e2f372f46475]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5af7212f-65de-453d-a150-e2f372f46475]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5b0ff0f6-0f7c-4a31-8f70-629b554d3483]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5b0ff0f6-0f7c-4a31-8f70-629b554d3483] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5b0ff0f6-0f7c-4a31-8f70-629b554d3483]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5b0ff0f6-0f7c-4a31-8f70-629b554d3483] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5b0ff0f6-0f7c-4a31-8f70-629b554d3483') > 0)   DROP SERVICE [SqlQueryNotificationService-5b0ff0f6-0f7c-4a31-8f70-629b554d3483]; if (OBJECT_ID('SqlQueryNotificationService-5b0ff0f6-0f7c-4a31-8f70-629b554d3483', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5b0ff0f6-0f7c-4a31-8f70-629b554d3483]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5b0ff0f6-0f7c-4a31-8f70-629b554d3483]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5dea1d3b-3441-433f-8976-2e79a90c5cca]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5dea1d3b-3441-433f-8976-2e79a90c5cca] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5dea1d3b-3441-433f-8976-2e79a90c5cca]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5dea1d3b-3441-433f-8976-2e79a90c5cca] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5dea1d3b-3441-433f-8976-2e79a90c5cca') > 0)   DROP SERVICE [SqlQueryNotificationService-5dea1d3b-3441-433f-8976-2e79a90c5cca]; if (OBJECT_ID('SqlQueryNotificationService-5dea1d3b-3441-433f-8976-2e79a90c5cca', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5dea1d3b-3441-433f-8976-2e79a90c5cca]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5dea1d3b-3441-433f-8976-2e79a90c5cca]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5f242331-668e-4243-860a-5c8f007a0d98]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5f242331-668e-4243-860a-5c8f007a0d98] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5f242331-668e-4243-860a-5c8f007a0d98]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5f242331-668e-4243-860a-5c8f007a0d98] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5f242331-668e-4243-860a-5c8f007a0d98') > 0)   DROP SERVICE [SqlQueryNotificationService-5f242331-668e-4243-860a-5c8f007a0d98]; if (OBJECT_ID('SqlQueryNotificationService-5f242331-668e-4243-860a-5c8f007a0d98', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5f242331-668e-4243-860a-5c8f007a0d98]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5f242331-668e-4243-860a-5c8f007a0d98]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-5ffd37c5-340c-40b7-9eb0-999642a5c1e8]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-5ffd37c5-340c-40b7-9eb0-999642a5c1e8] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-5ffd37c5-340c-40b7-9eb0-999642a5c1e8]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-5ffd37c5-340c-40b7-9eb0-999642a5c1e8] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-5ffd37c5-340c-40b7-9eb0-999642a5c1e8') > 0)   DROP SERVICE [SqlQueryNotificationService-5ffd37c5-340c-40b7-9eb0-999642a5c1e8]; if (OBJECT_ID('SqlQueryNotificationService-5ffd37c5-340c-40b7-9eb0-999642a5c1e8', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-5ffd37c5-340c-40b7-9eb0-999642a5c1e8]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-5ffd37c5-340c-40b7-9eb0-999642a5c1e8]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-612b66f7-1033-4154-9493-1421658ae06b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-612b66f7-1033-4154-9493-1421658ae06b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-612b66f7-1033-4154-9493-1421658ae06b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-612b66f7-1033-4154-9493-1421658ae06b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-612b66f7-1033-4154-9493-1421658ae06b') > 0)   DROP SERVICE [SqlQueryNotificationService-612b66f7-1033-4154-9493-1421658ae06b]; if (OBJECT_ID('SqlQueryNotificationService-612b66f7-1033-4154-9493-1421658ae06b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-612b66f7-1033-4154-9493-1421658ae06b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-612b66f7-1033-4154-9493-1421658ae06b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-61a48328-bed4-4a12-b3b5-cfa2b2f841ad]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-61a48328-bed4-4a12-b3b5-cfa2b2f841ad] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-61a48328-bed4-4a12-b3b5-cfa2b2f841ad]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-61a48328-bed4-4a12-b3b5-cfa2b2f841ad] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-61a48328-bed4-4a12-b3b5-cfa2b2f841ad') > 0)   DROP SERVICE [SqlQueryNotificationService-61a48328-bed4-4a12-b3b5-cfa2b2f841ad]; if (OBJECT_ID('SqlQueryNotificationService-61a48328-bed4-4a12-b3b5-cfa2b2f841ad', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-61a48328-bed4-4a12-b3b5-cfa2b2f841ad]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-61a48328-bed4-4a12-b3b5-cfa2b2f841ad]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-62967d77-f521-40ed-bbfc-80f77401b866]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-62967d77-f521-40ed-bbfc-80f77401b866] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-62967d77-f521-40ed-bbfc-80f77401b866]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-62967d77-f521-40ed-bbfc-80f77401b866] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-62967d77-f521-40ed-bbfc-80f77401b866') > 0)   DROP SERVICE [SqlQueryNotificationService-62967d77-f521-40ed-bbfc-80f77401b866]; if (OBJECT_ID('SqlQueryNotificationService-62967d77-f521-40ed-bbfc-80f77401b866', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-62967d77-f521-40ed-bbfc-80f77401b866]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-62967d77-f521-40ed-bbfc-80f77401b866]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-636fde47-c77a-4d2e-ad18-7248cf379282]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-636fde47-c77a-4d2e-ad18-7248cf379282] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-636fde47-c77a-4d2e-ad18-7248cf379282]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-636fde47-c77a-4d2e-ad18-7248cf379282] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-636fde47-c77a-4d2e-ad18-7248cf379282') > 0)   DROP SERVICE [SqlQueryNotificationService-636fde47-c77a-4d2e-ad18-7248cf379282]; if (OBJECT_ID('SqlQueryNotificationService-636fde47-c77a-4d2e-ad18-7248cf379282', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-636fde47-c77a-4d2e-ad18-7248cf379282]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-636fde47-c77a-4d2e-ad18-7248cf379282]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-63aceaba-b36f-44d5-a23f-2fbb414df2f8]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-63aceaba-b36f-44d5-a23f-2fbb414df2f8] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-63aceaba-b36f-44d5-a23f-2fbb414df2f8]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-63aceaba-b36f-44d5-a23f-2fbb414df2f8] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-63aceaba-b36f-44d5-a23f-2fbb414df2f8') > 0)   DROP SERVICE [SqlQueryNotificationService-63aceaba-b36f-44d5-a23f-2fbb414df2f8]; if (OBJECT_ID('SqlQueryNotificationService-63aceaba-b36f-44d5-a23f-2fbb414df2f8', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-63aceaba-b36f-44d5-a23f-2fbb414df2f8]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-63aceaba-b36f-44d5-a23f-2fbb414df2f8]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-63d8a8c5-fb6b-4ef5-add5-d91960806eb2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-63d8a8c5-fb6b-4ef5-add5-d91960806eb2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-63d8a8c5-fb6b-4ef5-add5-d91960806eb2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-63d8a8c5-fb6b-4ef5-add5-d91960806eb2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-63d8a8c5-fb6b-4ef5-add5-d91960806eb2') > 0)   DROP SERVICE [SqlQueryNotificationService-63d8a8c5-fb6b-4ef5-add5-d91960806eb2]; if (OBJECT_ID('SqlQueryNotificationService-63d8a8c5-fb6b-4ef5-add5-d91960806eb2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-63d8a8c5-fb6b-4ef5-add5-d91960806eb2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-63d8a8c5-fb6b-4ef5-add5-d91960806eb2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-63daeaf8-27c9-4b86-bce2-5a4b96fea85e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-63daeaf8-27c9-4b86-bce2-5a4b96fea85e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-63daeaf8-27c9-4b86-bce2-5a4b96fea85e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-63daeaf8-27c9-4b86-bce2-5a4b96fea85e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-63daeaf8-27c9-4b86-bce2-5a4b96fea85e') > 0)   DROP SERVICE [SqlQueryNotificationService-63daeaf8-27c9-4b86-bce2-5a4b96fea85e]; if (OBJECT_ID('SqlQueryNotificationService-63daeaf8-27c9-4b86-bce2-5a4b96fea85e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-63daeaf8-27c9-4b86-bce2-5a4b96fea85e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-63daeaf8-27c9-4b86-bce2-5a4b96fea85e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-64032603-324a-41be-942d-38a6b3aca80b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-64032603-324a-41be-942d-38a6b3aca80b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-64032603-324a-41be-942d-38a6b3aca80b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-64032603-324a-41be-942d-38a6b3aca80b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-64032603-324a-41be-942d-38a6b3aca80b') > 0)   DROP SERVICE [SqlQueryNotificationService-64032603-324a-41be-942d-38a6b3aca80b]; if (OBJECT_ID('SqlQueryNotificationService-64032603-324a-41be-942d-38a6b3aca80b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-64032603-324a-41be-942d-38a6b3aca80b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-64032603-324a-41be-942d-38a6b3aca80b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-64191405-7acb-471d-a7de-3ee8a194e5d9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-64191405-7acb-471d-a7de-3ee8a194e5d9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-64191405-7acb-471d-a7de-3ee8a194e5d9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-64191405-7acb-471d-a7de-3ee8a194e5d9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-64191405-7acb-471d-a7de-3ee8a194e5d9') > 0)   DROP SERVICE [SqlQueryNotificationService-64191405-7acb-471d-a7de-3ee8a194e5d9]; if (OBJECT_ID('SqlQueryNotificationService-64191405-7acb-471d-a7de-3ee8a194e5d9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-64191405-7acb-471d-a7de-3ee8a194e5d9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-64191405-7acb-471d-a7de-3ee8a194e5d9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-647a1951-bb81-42db-9ec0-135ab1a33058]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-647a1951-bb81-42db-9ec0-135ab1a33058] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-647a1951-bb81-42db-9ec0-135ab1a33058]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-647a1951-bb81-42db-9ec0-135ab1a33058] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-647a1951-bb81-42db-9ec0-135ab1a33058') > 0)   DROP SERVICE [SqlQueryNotificationService-647a1951-bb81-42db-9ec0-135ab1a33058]; if (OBJECT_ID('SqlQueryNotificationService-647a1951-bb81-42db-9ec0-135ab1a33058', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-647a1951-bb81-42db-9ec0-135ab1a33058]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-647a1951-bb81-42db-9ec0-135ab1a33058]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-64f20916-606a-45c1-9ce6-fee8316df3e2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-64f20916-606a-45c1-9ce6-fee8316df3e2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-64f20916-606a-45c1-9ce6-fee8316df3e2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-64f20916-606a-45c1-9ce6-fee8316df3e2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-64f20916-606a-45c1-9ce6-fee8316df3e2') > 0)   DROP SERVICE [SqlQueryNotificationService-64f20916-606a-45c1-9ce6-fee8316df3e2]; if (OBJECT_ID('SqlQueryNotificationService-64f20916-606a-45c1-9ce6-fee8316df3e2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-64f20916-606a-45c1-9ce6-fee8316df3e2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-64f20916-606a-45c1-9ce6-fee8316df3e2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-65220dd4-2c99-4040-8320-28c275aef772]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-65220dd4-2c99-4040-8320-28c275aef772] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-65220dd4-2c99-4040-8320-28c275aef772]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-65220dd4-2c99-4040-8320-28c275aef772] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-65220dd4-2c99-4040-8320-28c275aef772') > 0)   DROP SERVICE [SqlQueryNotificationService-65220dd4-2c99-4040-8320-28c275aef772]; if (OBJECT_ID('SqlQueryNotificationService-65220dd4-2c99-4040-8320-28c275aef772', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-65220dd4-2c99-4040-8320-28c275aef772]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-65220dd4-2c99-4040-8320-28c275aef772]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-67710d68-5c66-4444-be42-4512a246022c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-67710d68-5c66-4444-be42-4512a246022c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-67710d68-5c66-4444-be42-4512a246022c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-67710d68-5c66-4444-be42-4512a246022c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-67710d68-5c66-4444-be42-4512a246022c') > 0)   DROP SERVICE [SqlQueryNotificationService-67710d68-5c66-4444-be42-4512a246022c]; if (OBJECT_ID('SqlQueryNotificationService-67710d68-5c66-4444-be42-4512a246022c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-67710d68-5c66-4444-be42-4512a246022c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-67710d68-5c66-4444-be42-4512a246022c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-686532ca-cce8-4bf5-b245-43f17f5659b6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-686532ca-cce8-4bf5-b245-43f17f5659b6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-686532ca-cce8-4bf5-b245-43f17f5659b6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-686532ca-cce8-4bf5-b245-43f17f5659b6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-686532ca-cce8-4bf5-b245-43f17f5659b6') > 0)   DROP SERVICE [SqlQueryNotificationService-686532ca-cce8-4bf5-b245-43f17f5659b6]; if (OBJECT_ID('SqlQueryNotificationService-686532ca-cce8-4bf5-b245-43f17f5659b6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-686532ca-cce8-4bf5-b245-43f17f5659b6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-686532ca-cce8-4bf5-b245-43f17f5659b6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-68d89e6e-330d-4853-bb7a-40c28e81c043]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-68d89e6e-330d-4853-bb7a-40c28e81c043] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-68d89e6e-330d-4853-bb7a-40c28e81c043]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-68d89e6e-330d-4853-bb7a-40c28e81c043] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-68d89e6e-330d-4853-bb7a-40c28e81c043') > 0)   DROP SERVICE [SqlQueryNotificationService-68d89e6e-330d-4853-bb7a-40c28e81c043]; if (OBJECT_ID('SqlQueryNotificationService-68d89e6e-330d-4853-bb7a-40c28e81c043', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-68d89e6e-330d-4853-bb7a-40c28e81c043]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-68d89e6e-330d-4853-bb7a-40c28e81c043]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6b576e25-1bf2-40a1-9752-b0299d5e85c7]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6b576e25-1bf2-40a1-9752-b0299d5e85c7] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6b576e25-1bf2-40a1-9752-b0299d5e85c7]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6b576e25-1bf2-40a1-9752-b0299d5e85c7] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6b576e25-1bf2-40a1-9752-b0299d5e85c7') > 0)   DROP SERVICE [SqlQueryNotificationService-6b576e25-1bf2-40a1-9752-b0299d5e85c7]; if (OBJECT_ID('SqlQueryNotificationService-6b576e25-1bf2-40a1-9752-b0299d5e85c7', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6b576e25-1bf2-40a1-9752-b0299d5e85c7]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6b576e25-1bf2-40a1-9752-b0299d5e85c7]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2') > 0)   DROP SERVICE [SqlQueryNotificationService-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2]; if (OBJECT_ID('SqlQueryNotificationService-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6c0708fd-6bcd-4c60-8ca5-fd0c8939dfa2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6cbe7f44-fa89-4924-9db4-5150d48471c5]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6cbe7f44-fa89-4924-9db4-5150d48471c5] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6cbe7f44-fa89-4924-9db4-5150d48471c5]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6cbe7f44-fa89-4924-9db4-5150d48471c5] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6cbe7f44-fa89-4924-9db4-5150d48471c5') > 0)   DROP SERVICE [SqlQueryNotificationService-6cbe7f44-fa89-4924-9db4-5150d48471c5]; if (OBJECT_ID('SqlQueryNotificationService-6cbe7f44-fa89-4924-9db4-5150d48471c5', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6cbe7f44-fa89-4924-9db4-5150d48471c5]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6cbe7f44-fa89-4924-9db4-5150d48471c5]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6cf4c37c-0638-4fcd-9824-d954be50d495]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6cf4c37c-0638-4fcd-9824-d954be50d495] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6cf4c37c-0638-4fcd-9824-d954be50d495]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6cf4c37c-0638-4fcd-9824-d954be50d495] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6cf4c37c-0638-4fcd-9824-d954be50d495') > 0)   DROP SERVICE [SqlQueryNotificationService-6cf4c37c-0638-4fcd-9824-d954be50d495]; if (OBJECT_ID('SqlQueryNotificationService-6cf4c37c-0638-4fcd-9824-d954be50d495', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6cf4c37c-0638-4fcd-9824-d954be50d495]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6cf4c37c-0638-4fcd-9824-d954be50d495]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6db63b95-65de-4a27-bf9a-65e2a6560c01]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6db63b95-65de-4a27-bf9a-65e2a6560c01] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6db63b95-65de-4a27-bf9a-65e2a6560c01]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6db63b95-65de-4a27-bf9a-65e2a6560c01] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6db63b95-65de-4a27-bf9a-65e2a6560c01') > 0)   DROP SERVICE [SqlQueryNotificationService-6db63b95-65de-4a27-bf9a-65e2a6560c01]; if (OBJECT_ID('SqlQueryNotificationService-6db63b95-65de-4a27-bf9a-65e2a6560c01', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6db63b95-65de-4a27-bf9a-65e2a6560c01]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6db63b95-65de-4a27-bf9a-65e2a6560c01]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44') > 0)   DROP SERVICE [SqlQueryNotificationService-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44]; if (OBJECT_ID('SqlQueryNotificationService-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6dd981ac-d6c8-4a6f-b2c4-2996f9f11e44]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6ec4c372-60d0-460b-95cd-ba62bde9dfe8]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6ec4c372-60d0-460b-95cd-ba62bde9dfe8] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6ec4c372-60d0-460b-95cd-ba62bde9dfe8]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6ec4c372-60d0-460b-95cd-ba62bde9dfe8] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6ec4c372-60d0-460b-95cd-ba62bde9dfe8') > 0)   DROP SERVICE [SqlQueryNotificationService-6ec4c372-60d0-460b-95cd-ba62bde9dfe8]; if (OBJECT_ID('SqlQueryNotificationService-6ec4c372-60d0-460b-95cd-ba62bde9dfe8', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6ec4c372-60d0-460b-95cd-ba62bde9dfe8]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6ec4c372-60d0-460b-95cd-ba62bde9dfe8]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17') > 0)   DROP SERVICE [SqlQueryNotificationService-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17]; if (OBJECT_ID('SqlQueryNotificationService-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6f9046a5-c5ab-41d1-bee3-4fe71a4e2f17]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-6fda11d2-b99b-4cfe-83a1-616c1e1e0645]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-6fda11d2-b99b-4cfe-83a1-616c1e1e0645] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-6fda11d2-b99b-4cfe-83a1-616c1e1e0645]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-6fda11d2-b99b-4cfe-83a1-616c1e1e0645] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-6fda11d2-b99b-4cfe-83a1-616c1e1e0645') > 0)   DROP SERVICE [SqlQueryNotificationService-6fda11d2-b99b-4cfe-83a1-616c1e1e0645]; if (OBJECT_ID('SqlQueryNotificationService-6fda11d2-b99b-4cfe-83a1-616c1e1e0645', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-6fda11d2-b99b-4cfe-83a1-616c1e1e0645]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-6fda11d2-b99b-4cfe-83a1-616c1e1e0645]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-70b160a7-c90c-4f19-a89f-66f3525ef194]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-70b160a7-c90c-4f19-a89f-66f3525ef194] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-70b160a7-c90c-4f19-a89f-66f3525ef194]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-70b160a7-c90c-4f19-a89f-66f3525ef194] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-70b160a7-c90c-4f19-a89f-66f3525ef194') > 0)   DROP SERVICE [SqlQueryNotificationService-70b160a7-c90c-4f19-a89f-66f3525ef194]; if (OBJECT_ID('SqlQueryNotificationService-70b160a7-c90c-4f19-a89f-66f3525ef194', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-70b160a7-c90c-4f19-a89f-66f3525ef194]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-70b160a7-c90c-4f19-a89f-66f3525ef194]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-72f27786-65c7-4372-a6d5-de5ffc5ebf4b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-72f27786-65c7-4372-a6d5-de5ffc5ebf4b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-72f27786-65c7-4372-a6d5-de5ffc5ebf4b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-72f27786-65c7-4372-a6d5-de5ffc5ebf4b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-72f27786-65c7-4372-a6d5-de5ffc5ebf4b') > 0)   DROP SERVICE [SqlQueryNotificationService-72f27786-65c7-4372-a6d5-de5ffc5ebf4b]; if (OBJECT_ID('SqlQueryNotificationService-72f27786-65c7-4372-a6d5-de5ffc5ebf4b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-72f27786-65c7-4372-a6d5-de5ffc5ebf4b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-72f27786-65c7-4372-a6d5-de5ffc5ebf4b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-73037834-525f-490a-bd28-0fb083022aad]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-73037834-525f-490a-bd28-0fb083022aad] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-73037834-525f-490a-bd28-0fb083022aad]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-73037834-525f-490a-bd28-0fb083022aad] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-73037834-525f-490a-bd28-0fb083022aad') > 0)   DROP SERVICE [SqlQueryNotificationService-73037834-525f-490a-bd28-0fb083022aad]; if (OBJECT_ID('SqlQueryNotificationService-73037834-525f-490a-bd28-0fb083022aad', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-73037834-525f-490a-bd28-0fb083022aad]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-73037834-525f-490a-bd28-0fb083022aad]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-73508665-6872-4afa-a19f-0823a47c6014]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-73508665-6872-4afa-a19f-0823a47c6014] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-73508665-6872-4afa-a19f-0823a47c6014]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-73508665-6872-4afa-a19f-0823a47c6014] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-73508665-6872-4afa-a19f-0823a47c6014') > 0)   DROP SERVICE [SqlQueryNotificationService-73508665-6872-4afa-a19f-0823a47c6014]; if (OBJECT_ID('SqlQueryNotificationService-73508665-6872-4afa-a19f-0823a47c6014', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-73508665-6872-4afa-a19f-0823a47c6014]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-73508665-6872-4afa-a19f-0823a47c6014]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7356bceb-d2f6-4b83-b511-9bc32332b3a2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7356bceb-d2f6-4b83-b511-9bc32332b3a2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7356bceb-d2f6-4b83-b511-9bc32332b3a2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7356bceb-d2f6-4b83-b511-9bc32332b3a2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7356bceb-d2f6-4b83-b511-9bc32332b3a2') > 0)   DROP SERVICE [SqlQueryNotificationService-7356bceb-d2f6-4b83-b511-9bc32332b3a2]; if (OBJECT_ID('SqlQueryNotificationService-7356bceb-d2f6-4b83-b511-9bc32332b3a2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7356bceb-d2f6-4b83-b511-9bc32332b3a2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7356bceb-d2f6-4b83-b511-9bc32332b3a2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-735a30ab-5f74-48f1-a8b6-62ea963e3206]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-735a30ab-5f74-48f1-a8b6-62ea963e3206] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-735a30ab-5f74-48f1-a8b6-62ea963e3206]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-735a30ab-5f74-48f1-a8b6-62ea963e3206] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-735a30ab-5f74-48f1-a8b6-62ea963e3206') > 0)   DROP SERVICE [SqlQueryNotificationService-735a30ab-5f74-48f1-a8b6-62ea963e3206]; if (OBJECT_ID('SqlQueryNotificationService-735a30ab-5f74-48f1-a8b6-62ea963e3206', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-735a30ab-5f74-48f1-a8b6-62ea963e3206]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-735a30ab-5f74-48f1-a8b6-62ea963e3206]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-736f6197-eb79-47ca-869e-f5593a14b935]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-736f6197-eb79-47ca-869e-f5593a14b935] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-736f6197-eb79-47ca-869e-f5593a14b935]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-736f6197-eb79-47ca-869e-f5593a14b935] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-736f6197-eb79-47ca-869e-f5593a14b935') > 0)   DROP SERVICE [SqlQueryNotificationService-736f6197-eb79-47ca-869e-f5593a14b935]; if (OBJECT_ID('SqlQueryNotificationService-736f6197-eb79-47ca-869e-f5593a14b935', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-736f6197-eb79-47ca-869e-f5593a14b935]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-736f6197-eb79-47ca-869e-f5593a14b935]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7395c699-3010-4e80-9c7b-ce0d1f3f8e31]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7395c699-3010-4e80-9c7b-ce0d1f3f8e31] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7395c699-3010-4e80-9c7b-ce0d1f3f8e31]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7395c699-3010-4e80-9c7b-ce0d1f3f8e31] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7395c699-3010-4e80-9c7b-ce0d1f3f8e31') > 0)   DROP SERVICE [SqlQueryNotificationService-7395c699-3010-4e80-9c7b-ce0d1f3f8e31]; if (OBJECT_ID('SqlQueryNotificationService-7395c699-3010-4e80-9c7b-ce0d1f3f8e31', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7395c699-3010-4e80-9c7b-ce0d1f3f8e31]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7395c699-3010-4e80-9c7b-ce0d1f3f8e31]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7428c453-143b-4681-bf8d-b8b15efd2c5a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7428c453-143b-4681-bf8d-b8b15efd2c5a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7428c453-143b-4681-bf8d-b8b15efd2c5a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7428c453-143b-4681-bf8d-b8b15efd2c5a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7428c453-143b-4681-bf8d-b8b15efd2c5a') > 0)   DROP SERVICE [SqlQueryNotificationService-7428c453-143b-4681-bf8d-b8b15efd2c5a]; if (OBJECT_ID('SqlQueryNotificationService-7428c453-143b-4681-bf8d-b8b15efd2c5a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7428c453-143b-4681-bf8d-b8b15efd2c5a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7428c453-143b-4681-bf8d-b8b15efd2c5a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7502c7e4-4e21-4880-934c-653e25bef034]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7502c7e4-4e21-4880-934c-653e25bef034] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7502c7e4-4e21-4880-934c-653e25bef034]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7502c7e4-4e21-4880-934c-653e25bef034] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7502c7e4-4e21-4880-934c-653e25bef034') > 0)   DROP SERVICE [SqlQueryNotificationService-7502c7e4-4e21-4880-934c-653e25bef034]; if (OBJECT_ID('SqlQueryNotificationService-7502c7e4-4e21-4880-934c-653e25bef034', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7502c7e4-4e21-4880-934c-653e25bef034]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7502c7e4-4e21-4880-934c-653e25bef034]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-76bb283f-40da-499c-af33-017167b99594]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-76bb283f-40da-499c-af33-017167b99594] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-76bb283f-40da-499c-af33-017167b99594]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-76bb283f-40da-499c-af33-017167b99594] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-76bb283f-40da-499c-af33-017167b99594') > 0)   DROP SERVICE [SqlQueryNotificationService-76bb283f-40da-499c-af33-017167b99594]; if (OBJECT_ID('SqlQueryNotificationService-76bb283f-40da-499c-af33-017167b99594', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-76bb283f-40da-499c-af33-017167b99594]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-76bb283f-40da-499c-af33-017167b99594]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-78e70b21-d6f9-461d-9762-7d3be17d89ee]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-78e70b21-d6f9-461d-9762-7d3be17d89ee] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-78e70b21-d6f9-461d-9762-7d3be17d89ee]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-78e70b21-d6f9-461d-9762-7d3be17d89ee] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-78e70b21-d6f9-461d-9762-7d3be17d89ee') > 0)   DROP SERVICE [SqlQueryNotificationService-78e70b21-d6f9-461d-9762-7d3be17d89ee]; if (OBJECT_ID('SqlQueryNotificationService-78e70b21-d6f9-461d-9762-7d3be17d89ee', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-78e70b21-d6f9-461d-9762-7d3be17d89ee]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-78e70b21-d6f9-461d-9762-7d3be17d89ee]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-797b1796-4fa0-4bbd-b1c5-dd3f30834e10]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-797b1796-4fa0-4bbd-b1c5-dd3f30834e10] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-797b1796-4fa0-4bbd-b1c5-dd3f30834e10]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-797b1796-4fa0-4bbd-b1c5-dd3f30834e10] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-797b1796-4fa0-4bbd-b1c5-dd3f30834e10') > 0)   DROP SERVICE [SqlQueryNotificationService-797b1796-4fa0-4bbd-b1c5-dd3f30834e10]; if (OBJECT_ID('SqlQueryNotificationService-797b1796-4fa0-4bbd-b1c5-dd3f30834e10', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-797b1796-4fa0-4bbd-b1c5-dd3f30834e10]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-797b1796-4fa0-4bbd-b1c5-dd3f30834e10]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad') > 0)   DROP SERVICE [SqlQueryNotificationService-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad]; if (OBJECT_ID('SqlQueryNotificationService-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7bb9eecc-427e-4c78-bbfe-fb2d4fe7f6ad]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7ca7043f-3227-4b11-9b18-d513f39c6dd0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7ca7043f-3227-4b11-9b18-d513f39c6dd0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7ca7043f-3227-4b11-9b18-d513f39c6dd0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7ca7043f-3227-4b11-9b18-d513f39c6dd0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7ca7043f-3227-4b11-9b18-d513f39c6dd0') > 0)   DROP SERVICE [SqlQueryNotificationService-7ca7043f-3227-4b11-9b18-d513f39c6dd0]; if (OBJECT_ID('SqlQueryNotificationService-7ca7043f-3227-4b11-9b18-d513f39c6dd0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7ca7043f-3227-4b11-9b18-d513f39c6dd0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7ca7043f-3227-4b11-9b18-d513f39c6dd0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7dbe0867-6f30-4328-9345-84bf1e6574b3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7dbe0867-6f30-4328-9345-84bf1e6574b3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7dbe0867-6f30-4328-9345-84bf1e6574b3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7dbe0867-6f30-4328-9345-84bf1e6574b3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7dbe0867-6f30-4328-9345-84bf1e6574b3') > 0)   DROP SERVICE [SqlQueryNotificationService-7dbe0867-6f30-4328-9345-84bf1e6574b3]; if (OBJECT_ID('SqlQueryNotificationService-7dbe0867-6f30-4328-9345-84bf1e6574b3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7dbe0867-6f30-4328-9345-84bf1e6574b3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7dbe0867-6f30-4328-9345-84bf1e6574b3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7f216a67-e500-4c5a-88f9-171032c8ec03]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7f216a67-e500-4c5a-88f9-171032c8ec03] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7f216a67-e500-4c5a-88f9-171032c8ec03]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7f216a67-e500-4c5a-88f9-171032c8ec03] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7f216a67-e500-4c5a-88f9-171032c8ec03') > 0)   DROP SERVICE [SqlQueryNotificationService-7f216a67-e500-4c5a-88f9-171032c8ec03]; if (OBJECT_ID('SqlQueryNotificationService-7f216a67-e500-4c5a-88f9-171032c8ec03', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7f216a67-e500-4c5a-88f9-171032c8ec03]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7f216a67-e500-4c5a-88f9-171032c8ec03]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-7fae5b10-9f13-4887-b447-eb2bdca1e58e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-7fae5b10-9f13-4887-b447-eb2bdca1e58e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-7fae5b10-9f13-4887-b447-eb2bdca1e58e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-7fae5b10-9f13-4887-b447-eb2bdca1e58e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-7fae5b10-9f13-4887-b447-eb2bdca1e58e') > 0)   DROP SERVICE [SqlQueryNotificationService-7fae5b10-9f13-4887-b447-eb2bdca1e58e]; if (OBJECT_ID('SqlQueryNotificationService-7fae5b10-9f13-4887-b447-eb2bdca1e58e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-7fae5b10-9f13-4887-b447-eb2bdca1e58e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-7fae5b10-9f13-4887-b447-eb2bdca1e58e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-81531ecf-f617-49d0-a287-4e5edd2a56f1]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-81531ecf-f617-49d0-a287-4e5edd2a56f1] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-81531ecf-f617-49d0-a287-4e5edd2a56f1]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-81531ecf-f617-49d0-a287-4e5edd2a56f1] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-81531ecf-f617-49d0-a287-4e5edd2a56f1') > 0)   DROP SERVICE [SqlQueryNotificationService-81531ecf-f617-49d0-a287-4e5edd2a56f1]; if (OBJECT_ID('SqlQueryNotificationService-81531ecf-f617-49d0-a287-4e5edd2a56f1', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-81531ecf-f617-49d0-a287-4e5edd2a56f1]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-81531ecf-f617-49d0-a287-4e5edd2a56f1]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-81b3eee7-c887-4691-a3c8-cda7e0682509]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-81b3eee7-c887-4691-a3c8-cda7e0682509] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-81b3eee7-c887-4691-a3c8-cda7e0682509]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-81b3eee7-c887-4691-a3c8-cda7e0682509] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-81b3eee7-c887-4691-a3c8-cda7e0682509') > 0)   DROP SERVICE [SqlQueryNotificationService-81b3eee7-c887-4691-a3c8-cda7e0682509]; if (OBJECT_ID('SqlQueryNotificationService-81b3eee7-c887-4691-a3c8-cda7e0682509', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-81b3eee7-c887-4691-a3c8-cda7e0682509]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-81b3eee7-c887-4691-a3c8-cda7e0682509]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-84a48699-c3af-47fe-aa66-36bfc7d0c6e2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-84a48699-c3af-47fe-aa66-36bfc7d0c6e2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-84a48699-c3af-47fe-aa66-36bfc7d0c6e2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-84a48699-c3af-47fe-aa66-36bfc7d0c6e2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-84a48699-c3af-47fe-aa66-36bfc7d0c6e2') > 0)   DROP SERVICE [SqlQueryNotificationService-84a48699-c3af-47fe-aa66-36bfc7d0c6e2]; if (OBJECT_ID('SqlQueryNotificationService-84a48699-c3af-47fe-aa66-36bfc7d0c6e2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-84a48699-c3af-47fe-aa66-36bfc7d0c6e2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-84a48699-c3af-47fe-aa66-36bfc7d0c6e2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-851cebd3-cce6-476e-984e-a5dfe8db9d84]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-851cebd3-cce6-476e-984e-a5dfe8db9d84] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-851cebd3-cce6-476e-984e-a5dfe8db9d84]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-851cebd3-cce6-476e-984e-a5dfe8db9d84] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-851cebd3-cce6-476e-984e-a5dfe8db9d84') > 0)   DROP SERVICE [SqlQueryNotificationService-851cebd3-cce6-476e-984e-a5dfe8db9d84]; if (OBJECT_ID('SqlQueryNotificationService-851cebd3-cce6-476e-984e-a5dfe8db9d84', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-851cebd3-cce6-476e-984e-a5dfe8db9d84]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-851cebd3-cce6-476e-984e-a5dfe8db9d84]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-85d958e0-b7ac-4a79-bfa3-900fd5af76b8]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-85d958e0-b7ac-4a79-bfa3-900fd5af76b8] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-85d958e0-b7ac-4a79-bfa3-900fd5af76b8]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-85d958e0-b7ac-4a79-bfa3-900fd5af76b8] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-85d958e0-b7ac-4a79-bfa3-900fd5af76b8') > 0)   DROP SERVICE [SqlQueryNotificationService-85d958e0-b7ac-4a79-bfa3-900fd5af76b8]; if (OBJECT_ID('SqlQueryNotificationService-85d958e0-b7ac-4a79-bfa3-900fd5af76b8', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-85d958e0-b7ac-4a79-bfa3-900fd5af76b8]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-85d958e0-b7ac-4a79-bfa3-900fd5af76b8]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-85e075a6-4f01-4240-bb8c-4ca125c47d76]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-85e075a6-4f01-4240-bb8c-4ca125c47d76] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-85e075a6-4f01-4240-bb8c-4ca125c47d76]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-85e075a6-4f01-4240-bb8c-4ca125c47d76] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-85e075a6-4f01-4240-bb8c-4ca125c47d76') > 0)   DROP SERVICE [SqlQueryNotificationService-85e075a6-4f01-4240-bb8c-4ca125c47d76]; if (OBJECT_ID('SqlQueryNotificationService-85e075a6-4f01-4240-bb8c-4ca125c47d76', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-85e075a6-4f01-4240-bb8c-4ca125c47d76]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-85e075a6-4f01-4240-bb8c-4ca125c47d76]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-86a6c6d1-a748-4d38-adb7-6b6938a08322]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-86a6c6d1-a748-4d38-adb7-6b6938a08322] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-86a6c6d1-a748-4d38-adb7-6b6938a08322]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-86a6c6d1-a748-4d38-adb7-6b6938a08322] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-86a6c6d1-a748-4d38-adb7-6b6938a08322') > 0)   DROP SERVICE [SqlQueryNotificationService-86a6c6d1-a748-4d38-adb7-6b6938a08322]; if (OBJECT_ID('SqlQueryNotificationService-86a6c6d1-a748-4d38-adb7-6b6938a08322', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-86a6c6d1-a748-4d38-adb7-6b6938a08322]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-86a6c6d1-a748-4d38-adb7-6b6938a08322]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-88115e55-4670-4e01-b3f7-151c50ac7dce]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-88115e55-4670-4e01-b3f7-151c50ac7dce] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-88115e55-4670-4e01-b3f7-151c50ac7dce]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-88115e55-4670-4e01-b3f7-151c50ac7dce] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-88115e55-4670-4e01-b3f7-151c50ac7dce') > 0)   DROP SERVICE [SqlQueryNotificationService-88115e55-4670-4e01-b3f7-151c50ac7dce]; if (OBJECT_ID('SqlQueryNotificationService-88115e55-4670-4e01-b3f7-151c50ac7dce', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-88115e55-4670-4e01-b3f7-151c50ac7dce]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-88115e55-4670-4e01-b3f7-151c50ac7dce]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-8a12498e-d85a-4e7d-b3d8-88771b41adca]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-8a12498e-d85a-4e7d-b3d8-88771b41adca] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-8a12498e-d85a-4e7d-b3d8-88771b41adca]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-8a12498e-d85a-4e7d-b3d8-88771b41adca] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-8a12498e-d85a-4e7d-b3d8-88771b41adca') > 0)   DROP SERVICE [SqlQueryNotificationService-8a12498e-d85a-4e7d-b3d8-88771b41adca]; if (OBJECT_ID('SqlQueryNotificationService-8a12498e-d85a-4e7d-b3d8-88771b41adca', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-8a12498e-d85a-4e7d-b3d8-88771b41adca]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-8a12498e-d85a-4e7d-b3d8-88771b41adca]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a') > 0)   DROP SERVICE [SqlQueryNotificationService-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a]; if (OBJECT_ID('SqlQueryNotificationService-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-8cf67bad-13a0-4c66-ae32-7e35e4e40a4a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-8d21702f-8423-4f9c-ae6c-7c966c363768]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-8d21702f-8423-4f9c-ae6c-7c966c363768] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-8d21702f-8423-4f9c-ae6c-7c966c363768]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-8d21702f-8423-4f9c-ae6c-7c966c363768] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-8d21702f-8423-4f9c-ae6c-7c966c363768') > 0)   DROP SERVICE [SqlQueryNotificationService-8d21702f-8423-4f9c-ae6c-7c966c363768]; if (OBJECT_ID('SqlQueryNotificationService-8d21702f-8423-4f9c-ae6c-7c966c363768', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-8d21702f-8423-4f9c-ae6c-7c966c363768]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-8d21702f-8423-4f9c-ae6c-7c966c363768]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-8ea362c2-36a9-421f-b0a0-fad0aa3f671d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-8ea362c2-36a9-421f-b0a0-fad0aa3f671d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-8ea362c2-36a9-421f-b0a0-fad0aa3f671d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-8ea362c2-36a9-421f-b0a0-fad0aa3f671d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-8ea362c2-36a9-421f-b0a0-fad0aa3f671d') > 0)   DROP SERVICE [SqlQueryNotificationService-8ea362c2-36a9-421f-b0a0-fad0aa3f671d]; if (OBJECT_ID('SqlQueryNotificationService-8ea362c2-36a9-421f-b0a0-fad0aa3f671d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-8ea362c2-36a9-421f-b0a0-fad0aa3f671d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-8ea362c2-36a9-421f-b0a0-fad0aa3f671d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-8fa611e1-433b-402a-a0e6-9cda3a03523a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-8fa611e1-433b-402a-a0e6-9cda3a03523a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-8fa611e1-433b-402a-a0e6-9cda3a03523a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-8fa611e1-433b-402a-a0e6-9cda3a03523a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-8fa611e1-433b-402a-a0e6-9cda3a03523a') > 0)   DROP SERVICE [SqlQueryNotificationService-8fa611e1-433b-402a-a0e6-9cda3a03523a]; if (OBJECT_ID('SqlQueryNotificationService-8fa611e1-433b-402a-a0e6-9cda3a03523a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-8fa611e1-433b-402a-a0e6-9cda3a03523a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-8fa611e1-433b-402a-a0e6-9cda3a03523a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9073548b-306f-4a80-bd9c-d5af983cd324]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9073548b-306f-4a80-bd9c-d5af983cd324] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9073548b-306f-4a80-bd9c-d5af983cd324]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9073548b-306f-4a80-bd9c-d5af983cd324] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9073548b-306f-4a80-bd9c-d5af983cd324') > 0)   DROP SERVICE [SqlQueryNotificationService-9073548b-306f-4a80-bd9c-d5af983cd324]; if (OBJECT_ID('SqlQueryNotificationService-9073548b-306f-4a80-bd9c-d5af983cd324', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9073548b-306f-4a80-bd9c-d5af983cd324]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9073548b-306f-4a80-bd9c-d5af983cd324]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-93197bef-a470-4919-9c4d-f93ea9d457d6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-93197bef-a470-4919-9c4d-f93ea9d457d6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-93197bef-a470-4919-9c4d-f93ea9d457d6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-93197bef-a470-4919-9c4d-f93ea9d457d6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-93197bef-a470-4919-9c4d-f93ea9d457d6') > 0)   DROP SERVICE [SqlQueryNotificationService-93197bef-a470-4919-9c4d-f93ea9d457d6]; if (OBJECT_ID('SqlQueryNotificationService-93197bef-a470-4919-9c4d-f93ea9d457d6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-93197bef-a470-4919-9c4d-f93ea9d457d6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-93197bef-a470-4919-9c4d-f93ea9d457d6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-93c066a8-548a-4301-ab37-085579457e93]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-93c066a8-548a-4301-ab37-085579457e93] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-93c066a8-548a-4301-ab37-085579457e93]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-93c066a8-548a-4301-ab37-085579457e93] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-93c066a8-548a-4301-ab37-085579457e93') > 0)   DROP SERVICE [SqlQueryNotificationService-93c066a8-548a-4301-ab37-085579457e93]; if (OBJECT_ID('SqlQueryNotificationService-93c066a8-548a-4301-ab37-085579457e93', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-93c066a8-548a-4301-ab37-085579457e93]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-93c066a8-548a-4301-ab37-085579457e93]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-93f05735-7ec7-4356-8a5f-c2c20ffaa88c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-93f05735-7ec7-4356-8a5f-c2c20ffaa88c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-93f05735-7ec7-4356-8a5f-c2c20ffaa88c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-93f05735-7ec7-4356-8a5f-c2c20ffaa88c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-93f05735-7ec7-4356-8a5f-c2c20ffaa88c') > 0)   DROP SERVICE [SqlQueryNotificationService-93f05735-7ec7-4356-8a5f-c2c20ffaa88c]; if (OBJECT_ID('SqlQueryNotificationService-93f05735-7ec7-4356-8a5f-c2c20ffaa88c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-93f05735-7ec7-4356-8a5f-c2c20ffaa88c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-93f05735-7ec7-4356-8a5f-c2c20ffaa88c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-94874845-b5a4-4254-8b6b-c87c67c83779]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-94874845-b5a4-4254-8b6b-c87c67c83779] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-94874845-b5a4-4254-8b6b-c87c67c83779]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-94874845-b5a4-4254-8b6b-c87c67c83779] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-94874845-b5a4-4254-8b6b-c87c67c83779') > 0)   DROP SERVICE [SqlQueryNotificationService-94874845-b5a4-4254-8b6b-c87c67c83779]; if (OBJECT_ID('SqlQueryNotificationService-94874845-b5a4-4254-8b6b-c87c67c83779', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-94874845-b5a4-4254-8b6b-c87c67c83779]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-94874845-b5a4-4254-8b6b-c87c67c83779]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9501dac5-2e2c-4802-879c-4f5c54cae27c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9501dac5-2e2c-4802-879c-4f5c54cae27c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9501dac5-2e2c-4802-879c-4f5c54cae27c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9501dac5-2e2c-4802-879c-4f5c54cae27c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9501dac5-2e2c-4802-879c-4f5c54cae27c') > 0)   DROP SERVICE [SqlQueryNotificationService-9501dac5-2e2c-4802-879c-4f5c54cae27c]; if (OBJECT_ID('SqlQueryNotificationService-9501dac5-2e2c-4802-879c-4f5c54cae27c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9501dac5-2e2c-4802-879c-4f5c54cae27c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9501dac5-2e2c-4802-879c-4f5c54cae27c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-95d00d6d-1515-4f04-a1be-2b7493eecd8b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-95d00d6d-1515-4f04-a1be-2b7493eecd8b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-95d00d6d-1515-4f04-a1be-2b7493eecd8b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-95d00d6d-1515-4f04-a1be-2b7493eecd8b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-95d00d6d-1515-4f04-a1be-2b7493eecd8b') > 0)   DROP SERVICE [SqlQueryNotificationService-95d00d6d-1515-4f04-a1be-2b7493eecd8b]; if (OBJECT_ID('SqlQueryNotificationService-95d00d6d-1515-4f04-a1be-2b7493eecd8b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-95d00d6d-1515-4f04-a1be-2b7493eecd8b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-95d00d6d-1515-4f04-a1be-2b7493eecd8b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9607e842-33d1-469d-9de9-ab40f1667b48]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9607e842-33d1-469d-9de9-ab40f1667b48] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9607e842-33d1-469d-9de9-ab40f1667b48]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9607e842-33d1-469d-9de9-ab40f1667b48] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9607e842-33d1-469d-9de9-ab40f1667b48') > 0)   DROP SERVICE [SqlQueryNotificationService-9607e842-33d1-469d-9de9-ab40f1667b48]; if (OBJECT_ID('SqlQueryNotificationService-9607e842-33d1-469d-9de9-ab40f1667b48', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9607e842-33d1-469d-9de9-ab40f1667b48]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9607e842-33d1-469d-9de9-ab40f1667b48]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9653dabe-a891-4ec6-b64e-8b47c26081c0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9653dabe-a891-4ec6-b64e-8b47c26081c0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9653dabe-a891-4ec6-b64e-8b47c26081c0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9653dabe-a891-4ec6-b64e-8b47c26081c0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9653dabe-a891-4ec6-b64e-8b47c26081c0') > 0)   DROP SERVICE [SqlQueryNotificationService-9653dabe-a891-4ec6-b64e-8b47c26081c0]; if (OBJECT_ID('SqlQueryNotificationService-9653dabe-a891-4ec6-b64e-8b47c26081c0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9653dabe-a891-4ec6-b64e-8b47c26081c0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9653dabe-a891-4ec6-b64e-8b47c26081c0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-97b8ada9-fbe8-40e1-b157-abf11c93a813]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-97b8ada9-fbe8-40e1-b157-abf11c93a813] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-97b8ada9-fbe8-40e1-b157-abf11c93a813]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-97b8ada9-fbe8-40e1-b157-abf11c93a813] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-97b8ada9-fbe8-40e1-b157-abf11c93a813') > 0)   DROP SERVICE [SqlQueryNotificationService-97b8ada9-fbe8-40e1-b157-abf11c93a813]; if (OBJECT_ID('SqlQueryNotificationService-97b8ada9-fbe8-40e1-b157-abf11c93a813', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-97b8ada9-fbe8-40e1-b157-abf11c93a813]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-97b8ada9-fbe8-40e1-b157-abf11c93a813]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9bec3c35-523e-48e2-9152-6a32fb7b50ed]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9bec3c35-523e-48e2-9152-6a32fb7b50ed] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9bec3c35-523e-48e2-9152-6a32fb7b50ed]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9bec3c35-523e-48e2-9152-6a32fb7b50ed] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9bec3c35-523e-48e2-9152-6a32fb7b50ed') > 0)   DROP SERVICE [SqlQueryNotificationService-9bec3c35-523e-48e2-9152-6a32fb7b50ed]; if (OBJECT_ID('SqlQueryNotificationService-9bec3c35-523e-48e2-9152-6a32fb7b50ed', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9bec3c35-523e-48e2-9152-6a32fb7b50ed]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9bec3c35-523e-48e2-9152-6a32fb7b50ed]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9bfe57dc-6a1b-4feb-bfe5-144f561f39de]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9bfe57dc-6a1b-4feb-bfe5-144f561f39de] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9bfe57dc-6a1b-4feb-bfe5-144f561f39de]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9bfe57dc-6a1b-4feb-bfe5-144f561f39de] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9bfe57dc-6a1b-4feb-bfe5-144f561f39de') > 0)   DROP SERVICE [SqlQueryNotificationService-9bfe57dc-6a1b-4feb-bfe5-144f561f39de]; if (OBJECT_ID('SqlQueryNotificationService-9bfe57dc-6a1b-4feb-bfe5-144f561f39de', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9bfe57dc-6a1b-4feb-bfe5-144f561f39de]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9bfe57dc-6a1b-4feb-bfe5-144f561f39de]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd') > 0)   DROP SERVICE [SqlQueryNotificationService-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd]; if (OBJECT_ID('SqlQueryNotificationService-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9dba11fb-f07a-4f4c-b808-0cf8be5e3edd]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-9dc52121-8066-4387-b921-8428b23a8cfb]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-9dc52121-8066-4387-b921-8428b23a8cfb] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-9dc52121-8066-4387-b921-8428b23a8cfb]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-9dc52121-8066-4387-b921-8428b23a8cfb] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-9dc52121-8066-4387-b921-8428b23a8cfb') > 0)   DROP SERVICE [SqlQueryNotificationService-9dc52121-8066-4387-b921-8428b23a8cfb]; if (OBJECT_ID('SqlQueryNotificationService-9dc52121-8066-4387-b921-8428b23a8cfb', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-9dc52121-8066-4387-b921-8428b23a8cfb]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-9dc52121-8066-4387-b921-8428b23a8cfb]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a0dde6ff-33fb-454b-940a-3598d6b43ae6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a0dde6ff-33fb-454b-940a-3598d6b43ae6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a0dde6ff-33fb-454b-940a-3598d6b43ae6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a0dde6ff-33fb-454b-940a-3598d6b43ae6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a0dde6ff-33fb-454b-940a-3598d6b43ae6') > 0)   DROP SERVICE [SqlQueryNotificationService-a0dde6ff-33fb-454b-940a-3598d6b43ae6]; if (OBJECT_ID('SqlQueryNotificationService-a0dde6ff-33fb-454b-940a-3598d6b43ae6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a0dde6ff-33fb-454b-940a-3598d6b43ae6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a0dde6ff-33fb-454b-940a-3598d6b43ae6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c') > 0)   DROP SERVICE [SqlQueryNotificationService-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c]; if (OBJECT_ID('SqlQueryNotificationService-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a0fc5e3d-ce32-4f6d-aa2f-f039f268c75c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a1d92d09-b5be-4992-8c35-21fce2fcc93e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a1d92d09-b5be-4992-8c35-21fce2fcc93e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a1d92d09-b5be-4992-8c35-21fce2fcc93e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a1d92d09-b5be-4992-8c35-21fce2fcc93e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a1d92d09-b5be-4992-8c35-21fce2fcc93e') > 0)   DROP SERVICE [SqlQueryNotificationService-a1d92d09-b5be-4992-8c35-21fce2fcc93e]; if (OBJECT_ID('SqlQueryNotificationService-a1d92d09-b5be-4992-8c35-21fce2fcc93e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a1d92d09-b5be-4992-8c35-21fce2fcc93e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a1d92d09-b5be-4992-8c35-21fce2fcc93e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a3de33fa-f42a-40b7-87ba-2a53cd444d39]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a3de33fa-f42a-40b7-87ba-2a53cd444d39] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a3de33fa-f42a-40b7-87ba-2a53cd444d39]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a3de33fa-f42a-40b7-87ba-2a53cd444d39] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a3de33fa-f42a-40b7-87ba-2a53cd444d39') > 0)   DROP SERVICE [SqlQueryNotificationService-a3de33fa-f42a-40b7-87ba-2a53cd444d39]; if (OBJECT_ID('SqlQueryNotificationService-a3de33fa-f42a-40b7-87ba-2a53cd444d39', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a3de33fa-f42a-40b7-87ba-2a53cd444d39]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a3de33fa-f42a-40b7-87ba-2a53cd444d39]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a3e94d50-7717-4444-ac1d-aade557717d7]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a3e94d50-7717-4444-ac1d-aade557717d7] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a3e94d50-7717-4444-ac1d-aade557717d7]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a3e94d50-7717-4444-ac1d-aade557717d7] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a3e94d50-7717-4444-ac1d-aade557717d7') > 0)   DROP SERVICE [SqlQueryNotificationService-a3e94d50-7717-4444-ac1d-aade557717d7]; if (OBJECT_ID('SqlQueryNotificationService-a3e94d50-7717-4444-ac1d-aade557717d7', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a3e94d50-7717-4444-ac1d-aade557717d7]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a3e94d50-7717-4444-ac1d-aade557717d7]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a70e1cad-73ca-41b9-941b-eed16e23b221]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a70e1cad-73ca-41b9-941b-eed16e23b221] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a70e1cad-73ca-41b9-941b-eed16e23b221]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a70e1cad-73ca-41b9-941b-eed16e23b221] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a70e1cad-73ca-41b9-941b-eed16e23b221') > 0)   DROP SERVICE [SqlQueryNotificationService-a70e1cad-73ca-41b9-941b-eed16e23b221]; if (OBJECT_ID('SqlQueryNotificationService-a70e1cad-73ca-41b9-941b-eed16e23b221', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a70e1cad-73ca-41b9-941b-eed16e23b221]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a70e1cad-73ca-41b9-941b-eed16e23b221]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a7338dc8-0afd-4496-9df4-8e1053c4cd92]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a7338dc8-0afd-4496-9df4-8e1053c4cd92] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a7338dc8-0afd-4496-9df4-8e1053c4cd92]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a7338dc8-0afd-4496-9df4-8e1053c4cd92] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a7338dc8-0afd-4496-9df4-8e1053c4cd92') > 0)   DROP SERVICE [SqlQueryNotificationService-a7338dc8-0afd-4496-9df4-8e1053c4cd92]; if (OBJECT_ID('SqlQueryNotificationService-a7338dc8-0afd-4496-9df4-8e1053c4cd92', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a7338dc8-0afd-4496-9df4-8e1053c4cd92]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a7338dc8-0afd-4496-9df4-8e1053c4cd92]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a77f9d8d-9eb9-416b-9694-4ee53146d4f4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a77f9d8d-9eb9-416b-9694-4ee53146d4f4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a77f9d8d-9eb9-416b-9694-4ee53146d4f4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a77f9d8d-9eb9-416b-9694-4ee53146d4f4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a77f9d8d-9eb9-416b-9694-4ee53146d4f4') > 0)   DROP SERVICE [SqlQueryNotificationService-a77f9d8d-9eb9-416b-9694-4ee53146d4f4]; if (OBJECT_ID('SqlQueryNotificationService-a77f9d8d-9eb9-416b-9694-4ee53146d4f4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a77f9d8d-9eb9-416b-9694-4ee53146d4f4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a77f9d8d-9eb9-416b-9694-4ee53146d4f4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a834992c-7d51-459b-a8a8-6d613b54d52b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a834992c-7d51-459b-a8a8-6d613b54d52b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a834992c-7d51-459b-a8a8-6d613b54d52b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a834992c-7d51-459b-a8a8-6d613b54d52b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a834992c-7d51-459b-a8a8-6d613b54d52b') > 0)   DROP SERVICE [SqlQueryNotificationService-a834992c-7d51-459b-a8a8-6d613b54d52b]; if (OBJECT_ID('SqlQueryNotificationService-a834992c-7d51-459b-a8a8-6d613b54d52b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a834992c-7d51-459b-a8a8-6d613b54d52b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a834992c-7d51-459b-a8a8-6d613b54d52b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a87a76ae-5cc7-49a4-a462-9d37a2f0638b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a87a76ae-5cc7-49a4-a462-9d37a2f0638b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a87a76ae-5cc7-49a4-a462-9d37a2f0638b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a87a76ae-5cc7-49a4-a462-9d37a2f0638b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a87a76ae-5cc7-49a4-a462-9d37a2f0638b') > 0)   DROP SERVICE [SqlQueryNotificationService-a87a76ae-5cc7-49a4-a462-9d37a2f0638b]; if (OBJECT_ID('SqlQueryNotificationService-a87a76ae-5cc7-49a4-a462-9d37a2f0638b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a87a76ae-5cc7-49a4-a462-9d37a2f0638b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a87a76ae-5cc7-49a4-a462-9d37a2f0638b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-a87b0266-2810-4912-956c-24b1285663d4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-a87b0266-2810-4912-956c-24b1285663d4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-a87b0266-2810-4912-956c-24b1285663d4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-a87b0266-2810-4912-956c-24b1285663d4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-a87b0266-2810-4912-956c-24b1285663d4') > 0)   DROP SERVICE [SqlQueryNotificationService-a87b0266-2810-4912-956c-24b1285663d4]; if (OBJECT_ID('SqlQueryNotificationService-a87b0266-2810-4912-956c-24b1285663d4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-a87b0266-2810-4912-956c-24b1285663d4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-a87b0266-2810-4912-956c-24b1285663d4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-aa268f00-ace1-4fb6-b9f7-bb7c19bce510]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-aa268f00-ace1-4fb6-b9f7-bb7c19bce510] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-aa268f00-ace1-4fb6-b9f7-bb7c19bce510]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-aa268f00-ace1-4fb6-b9f7-bb7c19bce510] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-aa268f00-ace1-4fb6-b9f7-bb7c19bce510') > 0)   DROP SERVICE [SqlQueryNotificationService-aa268f00-ace1-4fb6-b9f7-bb7c19bce510]; if (OBJECT_ID('SqlQueryNotificationService-aa268f00-ace1-4fb6-b9f7-bb7c19bce510', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-aa268f00-ace1-4fb6-b9f7-bb7c19bce510]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-aa268f00-ace1-4fb6-b9f7-bb7c19bce510]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-aa6203cc-3921-4096-aaa1-4d3d4a656ce4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-aa6203cc-3921-4096-aaa1-4d3d4a656ce4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-aa6203cc-3921-4096-aaa1-4d3d4a656ce4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-aa6203cc-3921-4096-aaa1-4d3d4a656ce4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-aa6203cc-3921-4096-aaa1-4d3d4a656ce4') > 0)   DROP SERVICE [SqlQueryNotificationService-aa6203cc-3921-4096-aaa1-4d3d4a656ce4]; if (OBJECT_ID('SqlQueryNotificationService-aa6203cc-3921-4096-aaa1-4d3d4a656ce4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-aa6203cc-3921-4096-aaa1-4d3d4a656ce4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-aa6203cc-3921-4096-aaa1-4d3d4a656ce4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9') > 0)   DROP SERVICE [SqlQueryNotificationService-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9]; if (OBJECT_ID('SqlQueryNotificationService-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-aabc83fb-5dcd-4243-b6b5-5b25d5e33ec9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-aade7444-25f5-4051-8604-bbe887987967]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-aade7444-25f5-4051-8604-bbe887987967] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-aade7444-25f5-4051-8604-bbe887987967]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-aade7444-25f5-4051-8604-bbe887987967] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-aade7444-25f5-4051-8604-bbe887987967') > 0)   DROP SERVICE [SqlQueryNotificationService-aade7444-25f5-4051-8604-bbe887987967]; if (OBJECT_ID('SqlQueryNotificationService-aade7444-25f5-4051-8604-bbe887987967', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-aade7444-25f5-4051-8604-bbe887987967]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-aade7444-25f5-4051-8604-bbe887987967]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852') > 0)   DROP SERVICE [SqlQueryNotificationService-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852]; if (OBJECT_ID('SqlQueryNotificationService-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ab5ce2fa-454d-4d1b-b5fd-f29f4e58b852]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-abab4598-c0b1-4a72-8d0b-b1f4e09713c9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-abab4598-c0b1-4a72-8d0b-b1f4e09713c9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-abab4598-c0b1-4a72-8d0b-b1f4e09713c9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-abab4598-c0b1-4a72-8d0b-b1f4e09713c9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-abab4598-c0b1-4a72-8d0b-b1f4e09713c9') > 0)   DROP SERVICE [SqlQueryNotificationService-abab4598-c0b1-4a72-8d0b-b1f4e09713c9]; if (OBJECT_ID('SqlQueryNotificationService-abab4598-c0b1-4a72-8d0b-b1f4e09713c9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-abab4598-c0b1-4a72-8d0b-b1f4e09713c9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-abab4598-c0b1-4a72-8d0b-b1f4e09713c9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6') > 0)   DROP SERVICE [SqlQueryNotificationService-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6]; if (OBJECT_ID('SqlQueryNotificationService-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-abe81ea2-39cd-443a-bfcf-ec7228fa0bb6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e') > 0)   DROP SERVICE [SqlQueryNotificationService-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e]; if (OBJECT_ID('SqlQueryNotificationService-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ac6051bf-0187-4b34-9aa1-ef0ecdcb739e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-acb1ed77-718e-4347-a24c-a54cf14c781a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-acb1ed77-718e-4347-a24c-a54cf14c781a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-acb1ed77-718e-4347-a24c-a54cf14c781a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-acb1ed77-718e-4347-a24c-a54cf14c781a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-acb1ed77-718e-4347-a24c-a54cf14c781a') > 0)   DROP SERVICE [SqlQueryNotificationService-acb1ed77-718e-4347-a24c-a54cf14c781a]; if (OBJECT_ID('SqlQueryNotificationService-acb1ed77-718e-4347-a24c-a54cf14c781a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-acb1ed77-718e-4347-a24c-a54cf14c781a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-acb1ed77-718e-4347-a24c-a54cf14c781a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-accd16a9-e670-46d3-9979-e5c3f1896c71]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-accd16a9-e670-46d3-9979-e5c3f1896c71] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-accd16a9-e670-46d3-9979-e5c3f1896c71]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-accd16a9-e670-46d3-9979-e5c3f1896c71] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-accd16a9-e670-46d3-9979-e5c3f1896c71') > 0)   DROP SERVICE [SqlQueryNotificationService-accd16a9-e670-46d3-9979-e5c3f1896c71]; if (OBJECT_ID('SqlQueryNotificationService-accd16a9-e670-46d3-9979-e5c3f1896c71', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-accd16a9-e670-46d3-9979-e5c3f1896c71]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-accd16a9-e670-46d3-9979-e5c3f1896c71]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ace55968-93d9-4520-8e86-0dac4e9756b0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ace55968-93d9-4520-8e86-0dac4e9756b0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ace55968-93d9-4520-8e86-0dac4e9756b0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ace55968-93d9-4520-8e86-0dac4e9756b0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ace55968-93d9-4520-8e86-0dac4e9756b0') > 0)   DROP SERVICE [SqlQueryNotificationService-ace55968-93d9-4520-8e86-0dac4e9756b0]; if (OBJECT_ID('SqlQueryNotificationService-ace55968-93d9-4520-8e86-0dac4e9756b0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ace55968-93d9-4520-8e86-0dac4e9756b0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ace55968-93d9-4520-8e86-0dac4e9756b0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e') > 0)   DROP SERVICE [SqlQueryNotificationService-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e]; if (OBJECT_ID('SqlQueryNotificationService-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-aea4e2c4-afe4-4a99-bb02-f22f1abb8e8e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b0ec5264-6134-4b00-a283-fd2c77c916e5]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b0ec5264-6134-4b00-a283-fd2c77c916e5] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b0ec5264-6134-4b00-a283-fd2c77c916e5]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b0ec5264-6134-4b00-a283-fd2c77c916e5] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b0ec5264-6134-4b00-a283-fd2c77c916e5') > 0)   DROP SERVICE [SqlQueryNotificationService-b0ec5264-6134-4b00-a283-fd2c77c916e5]; if (OBJECT_ID('SqlQueryNotificationService-b0ec5264-6134-4b00-a283-fd2c77c916e5', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b0ec5264-6134-4b00-a283-fd2c77c916e5]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b0ec5264-6134-4b00-a283-fd2c77c916e5]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b0f8db49-1c8c-47ce-8fe6-929d51c26348]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b0f8db49-1c8c-47ce-8fe6-929d51c26348] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b0f8db49-1c8c-47ce-8fe6-929d51c26348]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b0f8db49-1c8c-47ce-8fe6-929d51c26348] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b0f8db49-1c8c-47ce-8fe6-929d51c26348') > 0)   DROP SERVICE [SqlQueryNotificationService-b0f8db49-1c8c-47ce-8fe6-929d51c26348]; if (OBJECT_ID('SqlQueryNotificationService-b0f8db49-1c8c-47ce-8fe6-929d51c26348', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b0f8db49-1c8c-47ce-8fe6-929d51c26348]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b0f8db49-1c8c-47ce-8fe6-929d51c26348]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b1de037d-beb6-4fbd-8493-6bd7bbff08c9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b1de037d-beb6-4fbd-8493-6bd7bbff08c9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b1de037d-beb6-4fbd-8493-6bd7bbff08c9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b1de037d-beb6-4fbd-8493-6bd7bbff08c9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b1de037d-beb6-4fbd-8493-6bd7bbff08c9') > 0)   DROP SERVICE [SqlQueryNotificationService-b1de037d-beb6-4fbd-8493-6bd7bbff08c9]; if (OBJECT_ID('SqlQueryNotificationService-b1de037d-beb6-4fbd-8493-6bd7bbff08c9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b1de037d-beb6-4fbd-8493-6bd7bbff08c9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b1de037d-beb6-4fbd-8493-6bd7bbff08c9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b1de4417-484c-4c41-ba4f-7d9e53c752f4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b1de4417-484c-4c41-ba4f-7d9e53c752f4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b1de4417-484c-4c41-ba4f-7d9e53c752f4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b1de4417-484c-4c41-ba4f-7d9e53c752f4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b1de4417-484c-4c41-ba4f-7d9e53c752f4') > 0)   DROP SERVICE [SqlQueryNotificationService-b1de4417-484c-4c41-ba4f-7d9e53c752f4]; if (OBJECT_ID('SqlQueryNotificationService-b1de4417-484c-4c41-ba4f-7d9e53c752f4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b1de4417-484c-4c41-ba4f-7d9e53c752f4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b1de4417-484c-4c41-ba4f-7d9e53c752f4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b1e10f2c-931a-4880-a993-bd1c99e81295]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b1e10f2c-931a-4880-a993-bd1c99e81295] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b1e10f2c-931a-4880-a993-bd1c99e81295]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b1e10f2c-931a-4880-a993-bd1c99e81295] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b1e10f2c-931a-4880-a993-bd1c99e81295') > 0)   DROP SERVICE [SqlQueryNotificationService-b1e10f2c-931a-4880-a993-bd1c99e81295]; if (OBJECT_ID('SqlQueryNotificationService-b1e10f2c-931a-4880-a993-bd1c99e81295', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b1e10f2c-931a-4880-a993-bd1c99e81295]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b1e10f2c-931a-4880-a993-bd1c99e81295]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b2d979f0-2086-481a-9c19-89af87fa0183]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b2d979f0-2086-481a-9c19-89af87fa0183] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b2d979f0-2086-481a-9c19-89af87fa0183]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b2d979f0-2086-481a-9c19-89af87fa0183] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b2d979f0-2086-481a-9c19-89af87fa0183') > 0)   DROP SERVICE [SqlQueryNotificationService-b2d979f0-2086-481a-9c19-89af87fa0183]; if (OBJECT_ID('SqlQueryNotificationService-b2d979f0-2086-481a-9c19-89af87fa0183', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b2d979f0-2086-481a-9c19-89af87fa0183]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b2d979f0-2086-481a-9c19-89af87fa0183]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b31fe3ff-5a7e-4929-9385-b786dc268302]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b31fe3ff-5a7e-4929-9385-b786dc268302] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b31fe3ff-5a7e-4929-9385-b786dc268302]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b31fe3ff-5a7e-4929-9385-b786dc268302] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b31fe3ff-5a7e-4929-9385-b786dc268302') > 0)   DROP SERVICE [SqlQueryNotificationService-b31fe3ff-5a7e-4929-9385-b786dc268302]; if (OBJECT_ID('SqlQueryNotificationService-b31fe3ff-5a7e-4929-9385-b786dc268302', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b31fe3ff-5a7e-4929-9385-b786dc268302]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b31fe3ff-5a7e-4929-9385-b786dc268302]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b41f73a3-1315-4829-9085-8f3c9fe9f5f4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b41f73a3-1315-4829-9085-8f3c9fe9f5f4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b41f73a3-1315-4829-9085-8f3c9fe9f5f4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b41f73a3-1315-4829-9085-8f3c9fe9f5f4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b41f73a3-1315-4829-9085-8f3c9fe9f5f4') > 0)   DROP SERVICE [SqlQueryNotificationService-b41f73a3-1315-4829-9085-8f3c9fe9f5f4]; if (OBJECT_ID('SqlQueryNotificationService-b41f73a3-1315-4829-9085-8f3c9fe9f5f4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b41f73a3-1315-4829-9085-8f3c9fe9f5f4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b41f73a3-1315-4829-9085-8f3c9fe9f5f4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-bb74717b-c576-4557-aa14-ccd569a47df8]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-bb74717b-c576-4557-aa14-ccd569a47df8] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-bb74717b-c576-4557-aa14-ccd569a47df8]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-bb74717b-c576-4557-aa14-ccd569a47df8] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-bb74717b-c576-4557-aa14-ccd569a47df8') > 0)   DROP SERVICE [SqlQueryNotificationService-bb74717b-c576-4557-aa14-ccd569a47df8]; if (OBJECT_ID('SqlQueryNotificationService-bb74717b-c576-4557-aa14-ccd569a47df8', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-bb74717b-c576-4557-aa14-ccd569a47df8]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-bb74717b-c576-4557-aa14-ccd569a47df8]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-bbe20a12-dc8d-49c7-a36c-169f94a57c34]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-bbe20a12-dc8d-49c7-a36c-169f94a57c34] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-bbe20a12-dc8d-49c7-a36c-169f94a57c34]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-bbe20a12-dc8d-49c7-a36c-169f94a57c34] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-bbe20a12-dc8d-49c7-a36c-169f94a57c34') > 0)   DROP SERVICE [SqlQueryNotificationService-bbe20a12-dc8d-49c7-a36c-169f94a57c34]; if (OBJECT_ID('SqlQueryNotificationService-bbe20a12-dc8d-49c7-a36c-169f94a57c34', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-bbe20a12-dc8d-49c7-a36c-169f94a57c34]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-bbe20a12-dc8d-49c7-a36c-169f94a57c34]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-bcbc94a1-102f-45d6-a303-682120e23e59]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-bcbc94a1-102f-45d6-a303-682120e23e59] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-bcbc94a1-102f-45d6-a303-682120e23e59]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-bcbc94a1-102f-45d6-a303-682120e23e59] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-bcbc94a1-102f-45d6-a303-682120e23e59') > 0)   DROP SERVICE [SqlQueryNotificationService-bcbc94a1-102f-45d6-a303-682120e23e59]; if (OBJECT_ID('SqlQueryNotificationService-bcbc94a1-102f-45d6-a303-682120e23e59', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-bcbc94a1-102f-45d6-a303-682120e23e59]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-bcbc94a1-102f-45d6-a303-682120e23e59]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-bf81f1b2-c13f-4129-a083-6630afbd3061]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-bf81f1b2-c13f-4129-a083-6630afbd3061] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-bf81f1b2-c13f-4129-a083-6630afbd3061]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-bf81f1b2-c13f-4129-a083-6630afbd3061] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-bf81f1b2-c13f-4129-a083-6630afbd3061') > 0)   DROP SERVICE [SqlQueryNotificationService-bf81f1b2-c13f-4129-a083-6630afbd3061]; if (OBJECT_ID('SqlQueryNotificationService-bf81f1b2-c13f-4129-a083-6630afbd3061', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-bf81f1b2-c13f-4129-a083-6630afbd3061]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-bf81f1b2-c13f-4129-a083-6630afbd3061]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c305ed2f-94b1-4451-97eb-f3ef46e027dc]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c305ed2f-94b1-4451-97eb-f3ef46e027dc] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c305ed2f-94b1-4451-97eb-f3ef46e027dc]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c305ed2f-94b1-4451-97eb-f3ef46e027dc] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c305ed2f-94b1-4451-97eb-f3ef46e027dc') > 0)   DROP SERVICE [SqlQueryNotificationService-c305ed2f-94b1-4451-97eb-f3ef46e027dc]; if (OBJECT_ID('SqlQueryNotificationService-c305ed2f-94b1-4451-97eb-f3ef46e027dc', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c305ed2f-94b1-4451-97eb-f3ef46e027dc]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c305ed2f-94b1-4451-97eb-f3ef46e027dc]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c5890c65-1aaf-4e41-a716-c76b5fd1b77c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c5890c65-1aaf-4e41-a716-c76b5fd1b77c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c5890c65-1aaf-4e41-a716-c76b5fd1b77c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c5890c65-1aaf-4e41-a716-c76b5fd1b77c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c5890c65-1aaf-4e41-a716-c76b5fd1b77c') > 0)   DROP SERVICE [SqlQueryNotificationService-c5890c65-1aaf-4e41-a716-c76b5fd1b77c]; if (OBJECT_ID('SqlQueryNotificationService-c5890c65-1aaf-4e41-a716-c76b5fd1b77c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c5890c65-1aaf-4e41-a716-c76b5fd1b77c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c5890c65-1aaf-4e41-a716-c76b5fd1b77c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c66461c9-0591-490a-bf97-f49ae38abe75]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c66461c9-0591-490a-bf97-f49ae38abe75] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c66461c9-0591-490a-bf97-f49ae38abe75]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c66461c9-0591-490a-bf97-f49ae38abe75] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c66461c9-0591-490a-bf97-f49ae38abe75') > 0)   DROP SERVICE [SqlQueryNotificationService-c66461c9-0591-490a-bf97-f49ae38abe75]; if (OBJECT_ID('SqlQueryNotificationService-c66461c9-0591-490a-bf97-f49ae38abe75', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c66461c9-0591-490a-bf97-f49ae38abe75]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c66461c9-0591-490a-bf97-f49ae38abe75]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c7293233-1ba4-4dfc-be92-e77f65599a35]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c7293233-1ba4-4dfc-be92-e77f65599a35] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c7293233-1ba4-4dfc-be92-e77f65599a35]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c7293233-1ba4-4dfc-be92-e77f65599a35] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c7293233-1ba4-4dfc-be92-e77f65599a35') > 0)   DROP SERVICE [SqlQueryNotificationService-c7293233-1ba4-4dfc-be92-e77f65599a35]; if (OBJECT_ID('SqlQueryNotificationService-c7293233-1ba4-4dfc-be92-e77f65599a35', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c7293233-1ba4-4dfc-be92-e77f65599a35]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c7293233-1ba4-4dfc-be92-e77f65599a35]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c77fd1ec-7bc0-469c-8466-a954f64a3a28]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c77fd1ec-7bc0-469c-8466-a954f64a3a28] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c77fd1ec-7bc0-469c-8466-a954f64a3a28]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c77fd1ec-7bc0-469c-8466-a954f64a3a28] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c77fd1ec-7bc0-469c-8466-a954f64a3a28') > 0)   DROP SERVICE [SqlQueryNotificationService-c77fd1ec-7bc0-469c-8466-a954f64a3a28]; if (OBJECT_ID('SqlQueryNotificationService-c77fd1ec-7bc0-469c-8466-a954f64a3a28', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c77fd1ec-7bc0-469c-8466-a954f64a3a28]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c77fd1ec-7bc0-469c-8466-a954f64a3a28]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c7bea06c-be33-458a-9dcd-1b891ceb54e3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c7bea06c-be33-458a-9dcd-1b891ceb54e3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c7bea06c-be33-458a-9dcd-1b891ceb54e3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c7bea06c-be33-458a-9dcd-1b891ceb54e3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c7bea06c-be33-458a-9dcd-1b891ceb54e3') > 0)   DROP SERVICE [SqlQueryNotificationService-c7bea06c-be33-458a-9dcd-1b891ceb54e3]; if (OBJECT_ID('SqlQueryNotificationService-c7bea06c-be33-458a-9dcd-1b891ceb54e3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c7bea06c-be33-458a-9dcd-1b891ceb54e3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c7bea06c-be33-458a-9dcd-1b891ceb54e3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c869d68e-f349-4c2a-8640-e373096a397a]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c869d68e-f349-4c2a-8640-e373096a397a] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c869d68e-f349-4c2a-8640-e373096a397a]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c869d68e-f349-4c2a-8640-e373096a397a] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c869d68e-f349-4c2a-8640-e373096a397a') > 0)   DROP SERVICE [SqlQueryNotificationService-c869d68e-f349-4c2a-8640-e373096a397a]; if (OBJECT_ID('SqlQueryNotificationService-c869d68e-f349-4c2a-8640-e373096a397a', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c869d68e-f349-4c2a-8640-e373096a397a]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c869d68e-f349-4c2a-8640-e373096a397a]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c8fe5be0-669d-447a-8aee-aaf420495cf7]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c8fe5be0-669d-447a-8aee-aaf420495cf7] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c8fe5be0-669d-447a-8aee-aaf420495cf7]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c8fe5be0-669d-447a-8aee-aaf420495cf7] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c8fe5be0-669d-447a-8aee-aaf420495cf7') > 0)   DROP SERVICE [SqlQueryNotificationService-c8fe5be0-669d-447a-8aee-aaf420495cf7]; if (OBJECT_ID('SqlQueryNotificationService-c8fe5be0-669d-447a-8aee-aaf420495cf7', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c8fe5be0-669d-447a-8aee-aaf420495cf7]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c8fe5be0-669d-447a-8aee-aaf420495cf7]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c98f5183-e61b-40f2-bbb6-faac74339e94]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c98f5183-e61b-40f2-bbb6-faac74339e94] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c98f5183-e61b-40f2-bbb6-faac74339e94]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c98f5183-e61b-40f2-bbb6-faac74339e94] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c98f5183-e61b-40f2-bbb6-faac74339e94') > 0)   DROP SERVICE [SqlQueryNotificationService-c98f5183-e61b-40f2-bbb6-faac74339e94]; if (OBJECT_ID('SqlQueryNotificationService-c98f5183-e61b-40f2-bbb6-faac74339e94', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c98f5183-e61b-40f2-bbb6-faac74339e94]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c98f5183-e61b-40f2-bbb6-faac74339e94]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c9991149-60e3-4a29-94e6-5e5b4591daa1]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c9991149-60e3-4a29-94e6-5e5b4591daa1] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c9991149-60e3-4a29-94e6-5e5b4591daa1]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c9991149-60e3-4a29-94e6-5e5b4591daa1] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c9991149-60e3-4a29-94e6-5e5b4591daa1') > 0)   DROP SERVICE [SqlQueryNotificationService-c9991149-60e3-4a29-94e6-5e5b4591daa1]; if (OBJECT_ID('SqlQueryNotificationService-c9991149-60e3-4a29-94e6-5e5b4591daa1', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c9991149-60e3-4a29-94e6-5e5b4591daa1]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c9991149-60e3-4a29-94e6-5e5b4591daa1]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-c99ced4a-4aa7-474f-ac01-e634eb45e104]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-c99ced4a-4aa7-474f-ac01-e634eb45e104] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-c99ced4a-4aa7-474f-ac01-e634eb45e104]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-c99ced4a-4aa7-474f-ac01-e634eb45e104] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-c99ced4a-4aa7-474f-ac01-e634eb45e104') > 0)   DROP SERVICE [SqlQueryNotificationService-c99ced4a-4aa7-474f-ac01-e634eb45e104]; if (OBJECT_ID('SqlQueryNotificationService-c99ced4a-4aa7-474f-ac01-e634eb45e104', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-c99ced4a-4aa7-474f-ac01-e634eb45e104]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-c99ced4a-4aa7-474f-ac01-e634eb45e104]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65') > 0)   DROP SERVICE [SqlQueryNotificationService-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65]; if (OBJECT_ID('SqlQueryNotificationService-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-caf8193d-bcbf-40ed-b8bc-6c62b51f3d65]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8') > 0)   DROP SERVICE [SqlQueryNotificationService-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8]; if (OBJECT_ID('SqlQueryNotificationService-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cb896cf7-8ddf-42c4-bb24-1f3a67816cb8]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cba40588-21ae-4bd5-99b2-bdabf42ff33e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cba40588-21ae-4bd5-99b2-bdabf42ff33e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cba40588-21ae-4bd5-99b2-bdabf42ff33e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cba40588-21ae-4bd5-99b2-bdabf42ff33e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cba40588-21ae-4bd5-99b2-bdabf42ff33e') > 0)   DROP SERVICE [SqlQueryNotificationService-cba40588-21ae-4bd5-99b2-bdabf42ff33e]; if (OBJECT_ID('SqlQueryNotificationService-cba40588-21ae-4bd5-99b2-bdabf42ff33e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cba40588-21ae-4bd5-99b2-bdabf42ff33e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cba40588-21ae-4bd5-99b2-bdabf42ff33e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3') > 0)   DROP SERVICE [SqlQueryNotificationService-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3]; if (OBJECT_ID('SqlQueryNotificationService-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cbad8083-b46a-42b6-a1cb-8ef1bd9431f3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cbce078f-f400-49a4-bfc7-5a743f206529]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cbce078f-f400-49a4-bfc7-5a743f206529] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cbce078f-f400-49a4-bfc7-5a743f206529]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cbce078f-f400-49a4-bfc7-5a743f206529] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cbce078f-f400-49a4-bfc7-5a743f206529') > 0)   DROP SERVICE [SqlQueryNotificationService-cbce078f-f400-49a4-bfc7-5a743f206529]; if (OBJECT_ID('SqlQueryNotificationService-cbce078f-f400-49a4-bfc7-5a743f206529', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cbce078f-f400-49a4-bfc7-5a743f206529]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cbce078f-f400-49a4-bfc7-5a743f206529]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cc830810-775e-4177-adb0-cb737c110be0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cc830810-775e-4177-adb0-cb737c110be0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cc830810-775e-4177-adb0-cb737c110be0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cc830810-775e-4177-adb0-cb737c110be0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cc830810-775e-4177-adb0-cb737c110be0') > 0)   DROP SERVICE [SqlQueryNotificationService-cc830810-775e-4177-adb0-cb737c110be0]; if (OBJECT_ID('SqlQueryNotificationService-cc830810-775e-4177-adb0-cb737c110be0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cc830810-775e-4177-adb0-cb737c110be0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cc830810-775e-4177-adb0-cb737c110be0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cd79d705-e6c8-4155-a33b-7ba2b9b67fad]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cd79d705-e6c8-4155-a33b-7ba2b9b67fad] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cd79d705-e6c8-4155-a33b-7ba2b9b67fad]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cd79d705-e6c8-4155-a33b-7ba2b9b67fad] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cd79d705-e6c8-4155-a33b-7ba2b9b67fad') > 0)   DROP SERVICE [SqlQueryNotificationService-cd79d705-e6c8-4155-a33b-7ba2b9b67fad]; if (OBJECT_ID('SqlQueryNotificationService-cd79d705-e6c8-4155-a33b-7ba2b9b67fad', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cd79d705-e6c8-4155-a33b-7ba2b9b67fad]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cd79d705-e6c8-4155-a33b-7ba2b9b67fad]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cdeb3f31-b9e7-46ba-b244-37e5662e4d22]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cdeb3f31-b9e7-46ba-b244-37e5662e4d22] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cdeb3f31-b9e7-46ba-b244-37e5662e4d22]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cdeb3f31-b9e7-46ba-b244-37e5662e4d22] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cdeb3f31-b9e7-46ba-b244-37e5662e4d22') > 0)   DROP SERVICE [SqlQueryNotificationService-cdeb3f31-b9e7-46ba-b244-37e5662e4d22]; if (OBJECT_ID('SqlQueryNotificationService-cdeb3f31-b9e7-46ba-b244-37e5662e4d22', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cdeb3f31-b9e7-46ba-b244-37e5662e4d22]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cdeb3f31-b9e7-46ba-b244-37e5662e4d22]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f') > 0)   DROP SERVICE [SqlQueryNotificationService-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f]; if (OBJECT_ID('SqlQueryNotificationService-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ce1c2a34-687d-442d-b46c-aefbbd6e7a4f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d212eca9-978b-4488-a204-cee0567b3472]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d212eca9-978b-4488-a204-cee0567b3472] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d212eca9-978b-4488-a204-cee0567b3472]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d212eca9-978b-4488-a204-cee0567b3472] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d212eca9-978b-4488-a204-cee0567b3472') > 0)   DROP SERVICE [SqlQueryNotificationService-d212eca9-978b-4488-a204-cee0567b3472]; if (OBJECT_ID('SqlQueryNotificationService-d212eca9-978b-4488-a204-cee0567b3472', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d212eca9-978b-4488-a204-cee0567b3472]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d212eca9-978b-4488-a204-cee0567b3472]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d267cc8a-aa8a-4a18-9980-bf975ec475c6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d267cc8a-aa8a-4a18-9980-bf975ec475c6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d267cc8a-aa8a-4a18-9980-bf975ec475c6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d267cc8a-aa8a-4a18-9980-bf975ec475c6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d267cc8a-aa8a-4a18-9980-bf975ec475c6') > 0)   DROP SERVICE [SqlQueryNotificationService-d267cc8a-aa8a-4a18-9980-bf975ec475c6]; if (OBJECT_ID('SqlQueryNotificationService-d267cc8a-aa8a-4a18-9980-bf975ec475c6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d267cc8a-aa8a-4a18-9980-bf975ec475c6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d267cc8a-aa8a-4a18-9980-bf975ec475c6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d26e096d-00d4-4bab-a073-7135f0518a9d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d26e096d-00d4-4bab-a073-7135f0518a9d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d26e096d-00d4-4bab-a073-7135f0518a9d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d26e096d-00d4-4bab-a073-7135f0518a9d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d26e096d-00d4-4bab-a073-7135f0518a9d') > 0)   DROP SERVICE [SqlQueryNotificationService-d26e096d-00d4-4bab-a073-7135f0518a9d]; if (OBJECT_ID('SqlQueryNotificationService-d26e096d-00d4-4bab-a073-7135f0518a9d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d26e096d-00d4-4bab-a073-7135f0518a9d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d26e096d-00d4-4bab-a073-7135f0518a9d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517') > 0)   DROP SERVICE [SqlQueryNotificationService-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517]; if (OBJECT_ID('SqlQueryNotificationService-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d38842d9-cc5a-4ba5-9da6-8f97ccd9e517]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d39d3eda-3888-4a90-ae55-955e0200ab49]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d39d3eda-3888-4a90-ae55-955e0200ab49] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d39d3eda-3888-4a90-ae55-955e0200ab49]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d39d3eda-3888-4a90-ae55-955e0200ab49] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d39d3eda-3888-4a90-ae55-955e0200ab49') > 0)   DROP SERVICE [SqlQueryNotificationService-d39d3eda-3888-4a90-ae55-955e0200ab49]; if (OBJECT_ID('SqlQueryNotificationService-d39d3eda-3888-4a90-ae55-955e0200ab49', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d39d3eda-3888-4a90-ae55-955e0200ab49]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d39d3eda-3888-4a90-ae55-955e0200ab49]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d4d9e4f7-1606-4fc6-b403-301cb1133150]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d4d9e4f7-1606-4fc6-b403-301cb1133150] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d4d9e4f7-1606-4fc6-b403-301cb1133150]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d4d9e4f7-1606-4fc6-b403-301cb1133150] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d4d9e4f7-1606-4fc6-b403-301cb1133150') > 0)   DROP SERVICE [SqlQueryNotificationService-d4d9e4f7-1606-4fc6-b403-301cb1133150]; if (OBJECT_ID('SqlQueryNotificationService-d4d9e4f7-1606-4fc6-b403-301cb1133150', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d4d9e4f7-1606-4fc6-b403-301cb1133150]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d4d9e4f7-1606-4fc6-b403-301cb1133150]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d5cc9752-f9d4-4993-811a-2268c007f06e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d5cc9752-f9d4-4993-811a-2268c007f06e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d5cc9752-f9d4-4993-811a-2268c007f06e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d5cc9752-f9d4-4993-811a-2268c007f06e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d5cc9752-f9d4-4993-811a-2268c007f06e') > 0)   DROP SERVICE [SqlQueryNotificationService-d5cc9752-f9d4-4993-811a-2268c007f06e]; if (OBJECT_ID('SqlQueryNotificationService-d5cc9752-f9d4-4993-811a-2268c007f06e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d5cc9752-f9d4-4993-811a-2268c007f06e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d5cc9752-f9d4-4993-811a-2268c007f06e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d5d3c37e-7036-4667-bb03-5a5b68a956e5]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d5d3c37e-7036-4667-bb03-5a5b68a956e5] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d5d3c37e-7036-4667-bb03-5a5b68a956e5]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d5d3c37e-7036-4667-bb03-5a5b68a956e5] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d5d3c37e-7036-4667-bb03-5a5b68a956e5') > 0)   DROP SERVICE [SqlQueryNotificationService-d5d3c37e-7036-4667-bb03-5a5b68a956e5]; if (OBJECT_ID('SqlQueryNotificationService-d5d3c37e-7036-4667-bb03-5a5b68a956e5', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d5d3c37e-7036-4667-bb03-5a5b68a956e5]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d5d3c37e-7036-4667-bb03-5a5b68a956e5]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d5d51225-00e2-488a-a2de-35c2e04baf84]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d5d51225-00e2-488a-a2de-35c2e04baf84] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d5d51225-00e2-488a-a2de-35c2e04baf84]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d5d51225-00e2-488a-a2de-35c2e04baf84] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d5d51225-00e2-488a-a2de-35c2e04baf84') > 0)   DROP SERVICE [SqlQueryNotificationService-d5d51225-00e2-488a-a2de-35c2e04baf84]; if (OBJECT_ID('SqlQueryNotificationService-d5d51225-00e2-488a-a2de-35c2e04baf84', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d5d51225-00e2-488a-a2de-35c2e04baf84]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d5d51225-00e2-488a-a2de-35c2e04baf84]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d6523bab-0096-4f03-91e8-8abe9e45000b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d6523bab-0096-4f03-91e8-8abe9e45000b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d6523bab-0096-4f03-91e8-8abe9e45000b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d6523bab-0096-4f03-91e8-8abe9e45000b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d6523bab-0096-4f03-91e8-8abe9e45000b') > 0)   DROP SERVICE [SqlQueryNotificationService-d6523bab-0096-4f03-91e8-8abe9e45000b]; if (OBJECT_ID('SqlQueryNotificationService-d6523bab-0096-4f03-91e8-8abe9e45000b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d6523bab-0096-4f03-91e8-8abe9e45000b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d6523bab-0096-4f03-91e8-8abe9e45000b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d7c17ec4-02ef-4332-901d-e93741450632]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d7c17ec4-02ef-4332-901d-e93741450632] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d7c17ec4-02ef-4332-901d-e93741450632]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d7c17ec4-02ef-4332-901d-e93741450632] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d7c17ec4-02ef-4332-901d-e93741450632') > 0)   DROP SERVICE [SqlQueryNotificationService-d7c17ec4-02ef-4332-901d-e93741450632]; if (OBJECT_ID('SqlQueryNotificationService-d7c17ec4-02ef-4332-901d-e93741450632', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d7c17ec4-02ef-4332-901d-e93741450632]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d7c17ec4-02ef-4332-901d-e93741450632]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d85d4934-82ed-43da-bfc7-50ba1fa0833c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d85d4934-82ed-43da-bfc7-50ba1fa0833c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d85d4934-82ed-43da-bfc7-50ba1fa0833c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d85d4934-82ed-43da-bfc7-50ba1fa0833c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d85d4934-82ed-43da-bfc7-50ba1fa0833c') > 0)   DROP SERVICE [SqlQueryNotificationService-d85d4934-82ed-43da-bfc7-50ba1fa0833c]; if (OBJECT_ID('SqlQueryNotificationService-d85d4934-82ed-43da-bfc7-50ba1fa0833c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d85d4934-82ed-43da-bfc7-50ba1fa0833c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d85d4934-82ed-43da-bfc7-50ba1fa0833c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d9457bd3-3242-44c7-9805-fd125cec6f45]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d9457bd3-3242-44c7-9805-fd125cec6f45] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d9457bd3-3242-44c7-9805-fd125cec6f45]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d9457bd3-3242-44c7-9805-fd125cec6f45] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d9457bd3-3242-44c7-9805-fd125cec6f45') > 0)   DROP SERVICE [SqlQueryNotificationService-d9457bd3-3242-44c7-9805-fd125cec6f45]; if (OBJECT_ID('SqlQueryNotificationService-d9457bd3-3242-44c7-9805-fd125cec6f45', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d9457bd3-3242-44c7-9805-fd125cec6f45]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d9457bd3-3242-44c7-9805-fd125cec6f45]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241') > 0)   DROP SERVICE [SqlQueryNotificationService-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241]; if (OBJECT_ID('SqlQueryNotificationService-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-db7e2c78-71b0-4ea0-8fb1-c93ab5f41241]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-dca228fc-e938-4cf1-9807-0f8e771f8385]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-dca228fc-e938-4cf1-9807-0f8e771f8385] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-dca228fc-e938-4cf1-9807-0f8e771f8385]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-dca228fc-e938-4cf1-9807-0f8e771f8385] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-dca228fc-e938-4cf1-9807-0f8e771f8385') > 0)   DROP SERVICE [SqlQueryNotificationService-dca228fc-e938-4cf1-9807-0f8e771f8385]; if (OBJECT_ID('SqlQueryNotificationService-dca228fc-e938-4cf1-9807-0f8e771f8385', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-dca228fc-e938-4cf1-9807-0f8e771f8385]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-dca228fc-e938-4cf1-9807-0f8e771f8385]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7') > 0)   DROP SERVICE [SqlQueryNotificationService-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7]; if (OBJECT_ID('SqlQueryNotificationService-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-dd2e5d94-f7b5-4165-8c0c-d4d7d25b04c7]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-dee0f6b7-68cb-42fd-80d4-1b54038166e0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-dee0f6b7-68cb-42fd-80d4-1b54038166e0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-dee0f6b7-68cb-42fd-80d4-1b54038166e0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-dee0f6b7-68cb-42fd-80d4-1b54038166e0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-dee0f6b7-68cb-42fd-80d4-1b54038166e0') > 0)   DROP SERVICE [SqlQueryNotificationService-dee0f6b7-68cb-42fd-80d4-1b54038166e0]; if (OBJECT_ID('SqlQueryNotificationService-dee0f6b7-68cb-42fd-80d4-1b54038166e0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-dee0f6b7-68cb-42fd-80d4-1b54038166e0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-dee0f6b7-68cb-42fd-80d4-1b54038166e0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-dffcb21a-882f-441d-99eb-5d6000a72b56]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-dffcb21a-882f-441d-99eb-5d6000a72b56] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-dffcb21a-882f-441d-99eb-5d6000a72b56]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-dffcb21a-882f-441d-99eb-5d6000a72b56] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-dffcb21a-882f-441d-99eb-5d6000a72b56') > 0)   DROP SERVICE [SqlQueryNotificationService-dffcb21a-882f-441d-99eb-5d6000a72b56]; if (OBJECT_ID('SqlQueryNotificationService-dffcb21a-882f-441d-99eb-5d6000a72b56', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-dffcb21a-882f-441d-99eb-5d6000a72b56]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-dffcb21a-882f-441d-99eb-5d6000a72b56]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e0fe70f0-5928-43ad-aa7c-69c411e6525c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e0fe70f0-5928-43ad-aa7c-69c411e6525c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e0fe70f0-5928-43ad-aa7c-69c411e6525c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e0fe70f0-5928-43ad-aa7c-69c411e6525c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e0fe70f0-5928-43ad-aa7c-69c411e6525c') > 0)   DROP SERVICE [SqlQueryNotificationService-e0fe70f0-5928-43ad-aa7c-69c411e6525c]; if (OBJECT_ID('SqlQueryNotificationService-e0fe70f0-5928-43ad-aa7c-69c411e6525c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e0fe70f0-5928-43ad-aa7c-69c411e6525c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e0fe70f0-5928-43ad-aa7c-69c411e6525c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2') > 0)   DROP SERVICE [SqlQueryNotificationService-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2]; if (OBJECT_ID('SqlQueryNotificationService-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e1a377d5-7c5b-47d0-a368-e2cd9aa0dcb2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e2022b87-f40c-4bd1-99d5-87166f0182c7]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e2022b87-f40c-4bd1-99d5-87166f0182c7] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e2022b87-f40c-4bd1-99d5-87166f0182c7]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e2022b87-f40c-4bd1-99d5-87166f0182c7] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e2022b87-f40c-4bd1-99d5-87166f0182c7') > 0)   DROP SERVICE [SqlQueryNotificationService-e2022b87-f40c-4bd1-99d5-87166f0182c7]; if (OBJECT_ID('SqlQueryNotificationService-e2022b87-f40c-4bd1-99d5-87166f0182c7', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e2022b87-f40c-4bd1-99d5-87166f0182c7]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e2022b87-f40c-4bd1-99d5-87166f0182c7]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e2abe9e3-18e3-4473-9480-a24d6a34ea79]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e2abe9e3-18e3-4473-9480-a24d6a34ea79] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e2abe9e3-18e3-4473-9480-a24d6a34ea79]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e2abe9e3-18e3-4473-9480-a24d6a34ea79] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e2abe9e3-18e3-4473-9480-a24d6a34ea79') > 0)   DROP SERVICE [SqlQueryNotificationService-e2abe9e3-18e3-4473-9480-a24d6a34ea79]; if (OBJECT_ID('SqlQueryNotificationService-e2abe9e3-18e3-4473-9480-a24d6a34ea79', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e2abe9e3-18e3-4473-9480-a24d6a34ea79]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e2abe9e3-18e3-4473-9480-a24d6a34ea79]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3') > 0)   DROP SERVICE [SqlQueryNotificationService-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3]; if (OBJECT_ID('SqlQueryNotificationService-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e2ecad42-47ea-4c8a-9485-bdbb2ec65fe3]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e3206804-7a41-4866-9256-dad802588ef4]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e3206804-7a41-4866-9256-dad802588ef4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e3206804-7a41-4866-9256-dad802588ef4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e3206804-7a41-4866-9256-dad802588ef4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e3206804-7a41-4866-9256-dad802588ef4') > 0)   DROP SERVICE [SqlQueryNotificationService-e3206804-7a41-4866-9256-dad802588ef4]; if (OBJECT_ID('SqlQueryNotificationService-e3206804-7a41-4866-9256-dad802588ef4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e3206804-7a41-4866-9256-dad802588ef4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e3206804-7a41-4866-9256-dad802588ef4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628') > 0)   DROP SERVICE [SqlQueryNotificationService-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628]; if (OBJECT_ID('SqlQueryNotificationService-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e3c44302-f7bd-4aed-9f4e-0d4e55f6c628]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e3d759ba-4e40-4417-9890-ac69eca5538c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e3d759ba-4e40-4417-9890-ac69eca5538c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e3d759ba-4e40-4417-9890-ac69eca5538c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e3d759ba-4e40-4417-9890-ac69eca5538c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e3d759ba-4e40-4417-9890-ac69eca5538c') > 0)   DROP SERVICE [SqlQueryNotificationService-e3d759ba-4e40-4417-9890-ac69eca5538c]; if (OBJECT_ID('SqlQueryNotificationService-e3d759ba-4e40-4417-9890-ac69eca5538c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e3d759ba-4e40-4417-9890-ac69eca5538c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e3d759ba-4e40-4417-9890-ac69eca5538c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e3ff7b3a-e704-4f8c-9b15-8af9c912f260]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e3ff7b3a-e704-4f8c-9b15-8af9c912f260] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e3ff7b3a-e704-4f8c-9b15-8af9c912f260]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e3ff7b3a-e704-4f8c-9b15-8af9c912f260] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e3ff7b3a-e704-4f8c-9b15-8af9c912f260') > 0)   DROP SERVICE [SqlQueryNotificationService-e3ff7b3a-e704-4f8c-9b15-8af9c912f260]; if (OBJECT_ID('SqlQueryNotificationService-e3ff7b3a-e704-4f8c-9b15-8af9c912f260', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e3ff7b3a-e704-4f8c-9b15-8af9c912f260]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e3ff7b3a-e704-4f8c-9b15-8af9c912f260]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e40c5832-2fb4-4c6e-a13f-9a2727a1b443]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e40c5832-2fb4-4c6e-a13f-9a2727a1b443] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e40c5832-2fb4-4c6e-a13f-9a2727a1b443]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e40c5832-2fb4-4c6e-a13f-9a2727a1b443] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e40c5832-2fb4-4c6e-a13f-9a2727a1b443') > 0)   DROP SERVICE [SqlQueryNotificationService-e40c5832-2fb4-4c6e-a13f-9a2727a1b443]; if (OBJECT_ID('SqlQueryNotificationService-e40c5832-2fb4-4c6e-a13f-9a2727a1b443', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e40c5832-2fb4-4c6e-a13f-9a2727a1b443]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e40c5832-2fb4-4c6e-a13f-9a2727a1b443]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f') > 0)   DROP SERVICE [SqlQueryNotificationService-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f]; if (OBJECT_ID('SqlQueryNotificationService-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e44057b8-9ab1-4bbc-a6d8-3921dbdb721f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e79553d3-057b-44a6-9478-d0d6962bcf27]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e79553d3-057b-44a6-9478-d0d6962bcf27] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e79553d3-057b-44a6-9478-d0d6962bcf27]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e79553d3-057b-44a6-9478-d0d6962bcf27] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e79553d3-057b-44a6-9478-d0d6962bcf27') > 0)   DROP SERVICE [SqlQueryNotificationService-e79553d3-057b-44a6-9478-d0d6962bcf27]; if (OBJECT_ID('SqlQueryNotificationService-e79553d3-057b-44a6-9478-d0d6962bcf27', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e79553d3-057b-44a6-9478-d0d6962bcf27]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e79553d3-057b-44a6-9478-d0d6962bcf27]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e799543c-cf61-4bb3-b069-e5cf711a8f8b]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e799543c-cf61-4bb3-b069-e5cf711a8f8b] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e799543c-cf61-4bb3-b069-e5cf711a8f8b]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e799543c-cf61-4bb3-b069-e5cf711a8f8b] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e799543c-cf61-4bb3-b069-e5cf711a8f8b') > 0)   DROP SERVICE [SqlQueryNotificationService-e799543c-cf61-4bb3-b069-e5cf711a8f8b]; if (OBJECT_ID('SqlQueryNotificationService-e799543c-cf61-4bb3-b069-e5cf711a8f8b', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e799543c-cf61-4bb3-b069-e5cf711a8f8b]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e799543c-cf61-4bb3-b069-e5cf711a8f8b]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e') > 0)   DROP SERVICE [SqlQueryNotificationService-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e]; if (OBJECT_ID('SqlQueryNotificationService-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e7fc95be-5f4c-4c07-8c7e-c5a53c64ee8e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-e9eefc8c-73b2-4716-9307-2eea3bb232b9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-e9eefc8c-73b2-4716-9307-2eea3bb232b9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-e9eefc8c-73b2-4716-9307-2eea3bb232b9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-e9eefc8c-73b2-4716-9307-2eea3bb232b9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-e9eefc8c-73b2-4716-9307-2eea3bb232b9') > 0)   DROP SERVICE [SqlQueryNotificationService-e9eefc8c-73b2-4716-9307-2eea3bb232b9]; if (OBJECT_ID('SqlQueryNotificationService-e9eefc8c-73b2-4716-9307-2eea3bb232b9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-e9eefc8c-73b2-4716-9307-2eea3bb232b9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-e9eefc8c-73b2-4716-9307-2eea3bb232b9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ea1437d2-590a-4d06-b90a-cd7af5320b3f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ea1437d2-590a-4d06-b90a-cd7af5320b3f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ea1437d2-590a-4d06-b90a-cd7af5320b3f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ea1437d2-590a-4d06-b90a-cd7af5320b3f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ea1437d2-590a-4d06-b90a-cd7af5320b3f') > 0)   DROP SERVICE [SqlQueryNotificationService-ea1437d2-590a-4d06-b90a-cd7af5320b3f]; if (OBJECT_ID('SqlQueryNotificationService-ea1437d2-590a-4d06-b90a-cd7af5320b3f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ea1437d2-590a-4d06-b90a-cd7af5320b3f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ea1437d2-590a-4d06-b90a-cd7af5320b3f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ed292855-db6d-403b-aea5-fd88d02305df]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ed292855-db6d-403b-aea5-fd88d02305df] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ed292855-db6d-403b-aea5-fd88d02305df]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ed292855-db6d-403b-aea5-fd88d02305df] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ed292855-db6d-403b-aea5-fd88d02305df') > 0)   DROP SERVICE [SqlQueryNotificationService-ed292855-db6d-403b-aea5-fd88d02305df]; if (OBJECT_ID('SqlQueryNotificationService-ed292855-db6d-403b-aea5-fd88d02305df', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ed292855-db6d-403b-aea5-fd88d02305df]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ed292855-db6d-403b-aea5-fd88d02305df]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ed99a9b2-5881-4f77-86cd-4516c871cfa6]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ed99a9b2-5881-4f77-86cd-4516c871cfa6] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ed99a9b2-5881-4f77-86cd-4516c871cfa6]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ed99a9b2-5881-4f77-86cd-4516c871cfa6] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ed99a9b2-5881-4f77-86cd-4516c871cfa6') > 0)   DROP SERVICE [SqlQueryNotificationService-ed99a9b2-5881-4f77-86cd-4516c871cfa6]; if (OBJECT_ID('SqlQueryNotificationService-ed99a9b2-5881-4f77-86cd-4516c871cfa6', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ed99a9b2-5881-4f77-86cd-4516c871cfa6]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ed99a9b2-5881-4f77-86cd-4516c871cfa6]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-edcfe062-48d7-4c0e-a985-deccc2f0edb2]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-edcfe062-48d7-4c0e-a985-deccc2f0edb2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-edcfe062-48d7-4c0e-a985-deccc2f0edb2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-edcfe062-48d7-4c0e-a985-deccc2f0edb2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-edcfe062-48d7-4c0e-a985-deccc2f0edb2') > 0)   DROP SERVICE [SqlQueryNotificationService-edcfe062-48d7-4c0e-a985-deccc2f0edb2]; if (OBJECT_ID('SqlQueryNotificationService-edcfe062-48d7-4c0e-a985-deccc2f0edb2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-edcfe062-48d7-4c0e-a985-deccc2f0edb2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-edcfe062-48d7-4c0e-a985-deccc2f0edb2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ee1d87f3-650c-4722-90fb-3ebeef2ab76d]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ee1d87f3-650c-4722-90fb-3ebeef2ab76d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ee1d87f3-650c-4722-90fb-3ebeef2ab76d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ee1d87f3-650c-4722-90fb-3ebeef2ab76d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ee1d87f3-650c-4722-90fb-3ebeef2ab76d') > 0)   DROP SERVICE [SqlQueryNotificationService-ee1d87f3-650c-4722-90fb-3ebeef2ab76d]; if (OBJECT_ID('SqlQueryNotificationService-ee1d87f3-650c-4722-90fb-3ebeef2ab76d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ee1d87f3-650c-4722-90fb-3ebeef2ab76d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ee1d87f3-650c-4722-90fb-3ebeef2ab76d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-eeb9be76-1011-4b20-bd6e-b439b735ef6f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-eeb9be76-1011-4b20-bd6e-b439b735ef6f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-eeb9be76-1011-4b20-bd6e-b439b735ef6f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-eeb9be76-1011-4b20-bd6e-b439b735ef6f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-eeb9be76-1011-4b20-bd6e-b439b735ef6f') > 0)   DROP SERVICE [SqlQueryNotificationService-eeb9be76-1011-4b20-bd6e-b439b735ef6f]; if (OBJECT_ID('SqlQueryNotificationService-eeb9be76-1011-4b20-bd6e-b439b735ef6f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-eeb9be76-1011-4b20-bd6e-b439b735ef6f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-eeb9be76-1011-4b20-bd6e-b439b735ef6f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f02b769a-694d-4e85-a77a-e07679c0797e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f02b769a-694d-4e85-a77a-e07679c0797e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f02b769a-694d-4e85-a77a-e07679c0797e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f02b769a-694d-4e85-a77a-e07679c0797e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f02b769a-694d-4e85-a77a-e07679c0797e') > 0)   DROP SERVICE [SqlQueryNotificationService-f02b769a-694d-4e85-a77a-e07679c0797e]; if (OBJECT_ID('SqlQueryNotificationService-f02b769a-694d-4e85-a77a-e07679c0797e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f02b769a-694d-4e85-a77a-e07679c0797e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f02b769a-694d-4e85-a77a-e07679c0797e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f189b877-dff0-4d09-866e-68bafa815c74]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f189b877-dff0-4d09-866e-68bafa815c74] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f189b877-dff0-4d09-866e-68bafa815c74]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f189b877-dff0-4d09-866e-68bafa815c74] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f189b877-dff0-4d09-866e-68bafa815c74') > 0)   DROP SERVICE [SqlQueryNotificationService-f189b877-dff0-4d09-866e-68bafa815c74]; if (OBJECT_ID('SqlQueryNotificationService-f189b877-dff0-4d09-866e-68bafa815c74', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f189b877-dff0-4d09-866e-68bafa815c74]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f189b877-dff0-4d09-866e-68bafa815c74]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63') > 0)   DROP SERVICE [SqlQueryNotificationService-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63]; if (OBJECT_ID('SqlQueryNotificationService-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f1c6cb84-4d96-4c8e-b88c-abac9b98aa63]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9') > 0)   DROP SERVICE [SqlQueryNotificationService-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9]; if (OBJECT_ID('SqlQueryNotificationService-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f2116ec5-6dc3-4d44-b3ec-f736b566ebb9]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f2a16336-d585-4308-8c26-a5c696a5ece7]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f2a16336-d585-4308-8c26-a5c696a5ece7] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f2a16336-d585-4308-8c26-a5c696a5ece7]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f2a16336-d585-4308-8c26-a5c696a5ece7] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f2a16336-d585-4308-8c26-a5c696a5ece7') > 0)   DROP SERVICE [SqlQueryNotificationService-f2a16336-d585-4308-8c26-a5c696a5ece7]; if (OBJECT_ID('SqlQueryNotificationService-f2a16336-d585-4308-8c26-a5c696a5ece7', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f2a16336-d585-4308-8c26-a5c696a5ece7]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f2a16336-d585-4308-8c26-a5c696a5ece7]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f4d6e2ed-9a85-4b66-8259-1994364f6d03]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f4d6e2ed-9a85-4b66-8259-1994364f6d03] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f4d6e2ed-9a85-4b66-8259-1994364f6d03]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f4d6e2ed-9a85-4b66-8259-1994364f6d03] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f4d6e2ed-9a85-4b66-8259-1994364f6d03') > 0)   DROP SERVICE [SqlQueryNotificationService-f4d6e2ed-9a85-4b66-8259-1994364f6d03]; if (OBJECT_ID('SqlQueryNotificationService-f4d6e2ed-9a85-4b66-8259-1994364f6d03', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f4d6e2ed-9a85-4b66-8259-1994364f6d03]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f4d6e2ed-9a85-4b66-8259-1994364f6d03]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f508352b-a9a5-491e-8c28-3a6165004a13]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f508352b-a9a5-491e-8c28-3a6165004a13] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f508352b-a9a5-491e-8c28-3a6165004a13]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f508352b-a9a5-491e-8c28-3a6165004a13] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f508352b-a9a5-491e-8c28-3a6165004a13') > 0)   DROP SERVICE [SqlQueryNotificationService-f508352b-a9a5-491e-8c28-3a6165004a13]; if (OBJECT_ID('SqlQueryNotificationService-f508352b-a9a5-491e-8c28-3a6165004a13', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f508352b-a9a5-491e-8c28-3a6165004a13]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f508352b-a9a5-491e-8c28-3a6165004a13]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5') > 0)   DROP SERVICE [SqlQueryNotificationService-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5]; if (OBJECT_ID('SqlQueryNotificationService-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f52ae7c5-d9eb-4fb3-b500-93156e9ccaf5]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1') > 0)   DROP SERVICE [SqlQueryNotificationService-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1]; if (OBJECT_ID('SqlQueryNotificationService-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f611f84f-6509-47f5-aa3a-a7d75ceb8ad1]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f78989a7-d90b-4ad6-858c-5d010b63fe86]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f78989a7-d90b-4ad6-858c-5d010b63fe86] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f78989a7-d90b-4ad6-858c-5d010b63fe86]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f78989a7-d90b-4ad6-858c-5d010b63fe86] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f78989a7-d90b-4ad6-858c-5d010b63fe86') > 0)   DROP SERVICE [SqlQueryNotificationService-f78989a7-d90b-4ad6-858c-5d010b63fe86]; if (OBJECT_ID('SqlQueryNotificationService-f78989a7-d90b-4ad6-858c-5d010b63fe86', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f78989a7-d90b-4ad6-858c-5d010b63fe86]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f78989a7-d90b-4ad6-858c-5d010b63fe86]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f801ced5-f783-4e3f-ad1e-bd0f136090fb]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f801ced5-f783-4e3f-ad1e-bd0f136090fb] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f801ced5-f783-4e3f-ad1e-bd0f136090fb]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f801ced5-f783-4e3f-ad1e-bd0f136090fb] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f801ced5-f783-4e3f-ad1e-bd0f136090fb') > 0)   DROP SERVICE [SqlQueryNotificationService-f801ced5-f783-4e3f-ad1e-bd0f136090fb]; if (OBJECT_ID('SqlQueryNotificationService-f801ced5-f783-4e3f-ad1e-bd0f136090fb', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f801ced5-f783-4e3f-ad1e-bd0f136090fb]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f801ced5-f783-4e3f-ad1e-bd0f136090fb]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f85df0e6-d836-438f-8eb5-2c7d1189e104]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f85df0e6-d836-438f-8eb5-2c7d1189e104] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f85df0e6-d836-438f-8eb5-2c7d1189e104]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f85df0e6-d836-438f-8eb5-2c7d1189e104] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f85df0e6-d836-438f-8eb5-2c7d1189e104') > 0)   DROP SERVICE [SqlQueryNotificationService-f85df0e6-d836-438f-8eb5-2c7d1189e104]; if (OBJECT_ID('SqlQueryNotificationService-f85df0e6-d836-438f-8eb5-2c7d1189e104', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f85df0e6-d836-438f-8eb5-2c7d1189e104]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f85df0e6-d836-438f-8eb5-2c7d1189e104]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-f90b225d-4215-4988-9102-370416f7d8ad]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-f90b225d-4215-4988-9102-370416f7d8ad] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-f90b225d-4215-4988-9102-370416f7d8ad]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-f90b225d-4215-4988-9102-370416f7d8ad] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-f90b225d-4215-4988-9102-370416f7d8ad') > 0)   DROP SERVICE [SqlQueryNotificationService-f90b225d-4215-4988-9102-370416f7d8ad]; if (OBJECT_ID('SqlQueryNotificationService-f90b225d-4215-4988-9102-370416f7d8ad', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-f90b225d-4215-4988-9102-370416f7d8ad]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-f90b225d-4215-4988-9102-370416f7d8ad]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-faa416d0-7133-4085-ae74-d7e7b952df33]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-faa416d0-7133-4085-ae74-d7e7b952df33] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-faa416d0-7133-4085-ae74-d7e7b952df33]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-faa416d0-7133-4085-ae74-d7e7b952df33] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-faa416d0-7133-4085-ae74-d7e7b952df33') > 0)   DROP SERVICE [SqlQueryNotificationService-faa416d0-7133-4085-ae74-d7e7b952df33]; if (OBJECT_ID('SqlQueryNotificationService-faa416d0-7133-4085-ae74-d7e7b952df33', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-faa416d0-7133-4085-ae74-d7e7b952df33]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-faa416d0-7133-4085-ae74-d7e7b952df33]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-fc3966b8-0dc2-4059-bebe-99803dd4952f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-fc3966b8-0dc2-4059-bebe-99803dd4952f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-fc3966b8-0dc2-4059-bebe-99803dd4952f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-fc3966b8-0dc2-4059-bebe-99803dd4952f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-fc3966b8-0dc2-4059-bebe-99803dd4952f') > 0)   DROP SERVICE [SqlQueryNotificationService-fc3966b8-0dc2-4059-bebe-99803dd4952f]; if (OBJECT_ID('SqlQueryNotificationService-fc3966b8-0dc2-4059-bebe-99803dd4952f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-fc3966b8-0dc2-4059-bebe-99803dd4952f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-fc3966b8-0dc2-4059-bebe-99803dd4952f]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-fd7f793a-5e80-4de9-b1e0-578495d7ffc5]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-fd7f793a-5e80-4de9-b1e0-578495d7ffc5] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-fd7f793a-5e80-4de9-b1e0-578495d7ffc5]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-fd7f793a-5e80-4de9-b1e0-578495d7ffc5] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-fd7f793a-5e80-4de9-b1e0-578495d7ffc5') > 0)   DROP SERVICE [SqlQueryNotificationService-fd7f793a-5e80-4de9-b1e0-578495d7ffc5]; if (OBJECT_ID('SqlQueryNotificationService-fd7f793a-5e80-4de9-b1e0-578495d7ffc5', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-fd7f793a-5e80-4de9-b1e0-578495d7ffc5]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-fd7f793a-5e80-4de9-b1e0-578495d7ffc5]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-fe88d3ed-163a-47e4-9edf-c905d052459e]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-fe88d3ed-163a-47e4-9edf-c905d052459e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-fe88d3ed-163a-47e4-9edf-c905d052459e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-fe88d3ed-163a-47e4-9edf-c905d052459e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-fe88d3ed-163a-47e4-9edf-c905d052459e') > 0)   DROP SERVICE [SqlQueryNotificationService-fe88d3ed-163a-47e4-9edf-c905d052459e]; if (OBJECT_ID('SqlQueryNotificationService-fe88d3ed-163a-47e4-9edf-c905d052459e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-fe88d3ed-163a-47e4-9edf-c905d052459e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-fe88d3ed-163a-47e4-9edf-c905d052459e]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-fed84369-81ed-4b9b-bbcb-9084e26c037c]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-fed84369-81ed-4b9b-bbcb-9084e26c037c] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-fed84369-81ed-4b9b-bbcb-9084e26c037c]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-fed84369-81ed-4b9b-bbcb-9084e26c037c] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-fed84369-81ed-4b9b-bbcb-9084e26c037c') > 0)   DROP SERVICE [SqlQueryNotificationService-fed84369-81ed-4b9b-bbcb-9084e26c037c]; if (OBJECT_ID('SqlQueryNotificationService-fed84369-81ed-4b9b-bbcb-9084e26c037c', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-fed84369-81ed-4b9b-bbcb-9084e26c037c]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-fed84369-81ed-4b9b-bbcb-9084e26c037c]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0') > 0)   DROP SERVICE [SqlQueryNotificationService-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0]; if (OBJECT_ID('SqlQueryNotificationService-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ff8c72ec-5c87-4a82-bf4f-5ee78d220dc0]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ffc64113-2d65-4189-8a11-2f20ff58ce49]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ffc64113-2d65-4189-8a11-2f20ff58ce49] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ffc64113-2d65-4189-8a11-2f20ff58ce49]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ffc64113-2d65-4189-8a11-2f20ff58ce49] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ffc64113-2d65-4189-8a11-2f20ff58ce49') > 0)   DROP SERVICE [SqlQueryNotificationService-ffc64113-2d65-4189-8a11-2f20ff58ce49]; if (OBJECT_ID('SqlQueryNotificationService-ffc64113-2d65-4189-8a11-2f20ff58ce49', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ffc64113-2d65-4189-8a11-2f20ff58ce49]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ffc64113-2d65-4189-8a11-2f20ff58ce49]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f]    Script Date: 7/11/2019 3:29:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f') > 0)   DROP SERVICE [SqlQueryNotificationService-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f]; if (OBJECT_ID('SqlQueryNotificationService-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-ffcbe0a2-f53f-46cd-b410-ccd5419e9e8f]; END COMMIT TRANSACTION; END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "hd"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CTHD"
            Begin Extent = 
               Top = 6
               Left = 253
               Bottom = 136
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ph"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nv"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 268
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dv"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
En' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_InHoaDon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'd
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_InHoaDon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_InHoaDon'
GO
USE [master]
GO
ALTER DATABASE [QLPM_Karaoke] SET  READ_WRITE 
GO
