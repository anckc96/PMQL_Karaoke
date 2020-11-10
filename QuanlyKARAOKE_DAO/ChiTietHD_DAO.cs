using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class ChiTietHD_DAO
    {
        public ChiTietHD_DTO KiemTraTonTaiDVTrongHD(string MaDV, string MaHD)
        {
            ChiTietHD_DTO CTHD = null;
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * from ChiTietHoaDon where MaHD = '{1}' and MaDV = N'{0}' and TrangThai = 1", MaDV, MaHD);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                CTHD = new ChiTietHD_DTO();
                CTHD.MaHD = sdr["MaHD"].ToString();
                CTHD.MaDV = sdr["MaDV"].ToString();
                CTHD.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                CTHD.GiaBan = double.Parse(sdr["GiaBan"].ToString());
                CTHD.TrangThai = int.Parse(sdr["TrangThai"].ToString());
            }
            sdr.Close();
            conn.Close();
            return CTHD;
        }

        public bool XoaDichVu(ChiTietHD_DTO ct1)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set TrangThai = 0 Where MaHD = '{0}' and MaDV = N'{1}'", ct1.MaHD, ct1.MaDV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool ThemDichVu(ChiTietHD_DTO CTHD)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strInsert = string.Format("Insert into ChiTietHoaDon Values ('{0}',N'{1}',{2},{3},{4},1)",   CTHD.MaHD, CTHD.MaDV, CTHD.SoLuong, CTHD.GiaBan,CTHD.SoLuong*CTHD.GiaBan);
            bool a = DataProvider.ThucThiCauLenh(strInsert, conn);
            conn.Close();
            return a;
        }

        public List<ChiTietHD_DTO> LayDSCTHD(string MaPH)
        {
            List<ChiTietHD_DTO> lsHoaDon = new List<ChiTietHD_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Select ChiTietHoaDon.* From [ChiTietHoaDon], [HoaDon] Where ChiTietHoaDon.MaHD = HoaDon.MaHD and MaPhong = '{0}' and DaThanhToan = 0 and HoaDon.TrangThai = 1 and ChiTietHoaDon.TrangThai = 1", MaPH);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyvan, conn);
            while (sdr.Read())
            {
                ChiTietHD_DTO CTHD = new ChiTietHD_DTO();
                CTHD.MaHD = sdr["MaHD"].ToString();
                CTHD.MaDV = sdr["MaDV"].ToString();
                CTHD.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                CTHD.GiaBan = double.Parse(sdr["GiaBan"].ToString());
                CTHD.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsHoaDon.Add(CTHD);
            }

            sdr.Close();
            conn.Close();

            return lsHoaDon;
        }

        public bool UpdateSoLuong(ChiTietHD_DTO CTHD)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set SoLuong = {1}, ThanhTien = {2} Where MaHD = '{0}' and MaDV = '{3}'", CTHD.MaHD, CTHD.SoLuong, CTHD.SoLuong*CTHD.GiaBan, CTHD.MaDV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public List<ChiTietHD_DTO> LayDSDVCuaHoaDon(string MaHDTT)
        {
            List<ChiTietHD_DTO> lsCT = new List<ChiTietHD_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Select * From [ChiTietHoaDon] Where MaHD = '{0}' and TrangThai = 1", MaHDTT);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyvan, conn);
            while (sdr.Read())
            {
                ChiTietHD_DTO ct = new ChiTietHD_DTO();
                ct.MaDV = sdr["MaDV"].ToString();
                ct.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                ct.GiaBan = double.Parse(sdr["GiaBan"].ToString());
                lsCT.Add(ct);
            }
            sdr.Close();
            conn.Close();

            return lsCT;
        }

        public ChiTietHD_DTO KiemTraDVDaXoaTrongHD(string MaHD, string MaDV)
        {
            ChiTietHD_DTO CTHD = null;
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * from ChiTietHoaDon where MaHD = '{0}' and MaDV = '{1}'", MaHD, MaDV);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                CTHD = new ChiTietHD_DTO();
                CTHD.MaHD = sdr["MaHD"].ToString();
                CTHD.MaDV = sdr["MaDV"].ToString();
                CTHD.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                CTHD.GiaBan = int.Parse(sdr["GiaBan"].ToString());
                CTHD.TrangThai = int.Parse(sdr["TrangThai"].ToString());
            }
            sdr.Close();
            conn.Close();
            return CTHD;
        }

        public bool CapNhatLaiDichVuDaXoa(ChiTietHD_DTO CTHD)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set TrangThai = 1, SoLuong = '{2}' Where MaHD = '{0}' and MaDV = N'{1}'", CTHD.MaHD, CTHD.MaDV, CTHD.SoLuong);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatGioHat(ChiTietHD_DTO ChiTietHD)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set SoLuong = {1}, GiaBan = {4}, ThanhTien = {2} Where MaHD = '{0}' and MaDV = '{3}'", ChiTietHD.MaHD, ChiTietHD.SoLuong, Math.Round(ChiTietHD.SoLuong * ChiTietHD.GiaBan, 2), ChiTietHD.MaDV, ChiTietHD.GiaBan);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatDVKhachGoiThem(string MaDV, string MaHD, int soLuongDvKhachGoiThem)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set SoLuong = SoLuong + {1}, ThanhTien = SoLuong*GiaBan Where MaHD = '{0}' and MaDV = '{2}'", MaHD, soLuongDvKhachGoiThem, MaDV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatDVKhachTraMon(string MaDV, string MaHD, int soLuongDvKhachTra)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set SoLuong = SoLuong - {1}, ThanhTien = (SoLuong - {3})*GiaBan Where MaHD = '{0}' and MaDV = '{2}'", MaHD, soLuongDvKhachTra, MaDV, soLuongDvKhachTra);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatDVKhachTraToanBo(string MaHD, string MaDV)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update ChiTietHoaDon Set TrangThai = 0 Where MaHD = '{0}' and MaDV = '{1}'", MaHD, MaDV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public int LayGioHat(string MaHD)
        {
            int soGioHat = 0;
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select SoLuong from ChiTietHoaDon where MaHD = '{0}' and MaDV = 'DV001'", MaHD);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                soGioHat = Convert.ToInt32(sdr["SoLuong"].ToString());
            }
            sdr.Close();
            conn.Close();
            return soGioHat;
        }
    }
}
