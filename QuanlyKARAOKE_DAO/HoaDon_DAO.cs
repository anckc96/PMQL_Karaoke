using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class HoaDon_DAO
    {
        List<HoaDon_DTO> lsHoaDon;
        public HoaDon_DTO KiemTraPhongTrong(string MaPH)
        {
            HoaDon_DTO hd = new HoaDon_DTO();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From [HoaDon] Where MaPhong = '{0}' and DaThanhToan = 0", MaPH);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                hd.MaHD = sdr["MaHD"].ToString();
                hd.MaPhong = sdr["MaPhong"].ToString();
                hd.GioVao = sdr["GioVao"].ToString();
                hd.GioRa = sdr["GioRa"].ToString();
                hd.NhanVienLapHD = sdr["NhanVienLapHD"].ToString();
                hd.TongTien = int.Parse(sdr["TongTien"].ToString());
                hd.NgayLap = DateTime.Now;
                hd.TienGio = int.Parse(sdr["TienGio"].ToString());
                hd.TienPhut = int.Parse(sdr["TienPhut"].ToString());
                hd.GioSuDung = int.Parse(sdr["GioSuDung"].ToString());
                hd.PhutSuDung =int.Parse(sdr["PhutSuDung"].ToString());
                hd.DaThanhToan = int.Parse(sdr["DaThanhToan"].ToString());
                hd.TrangThai = int.Parse(sdr["TrangThai"].ToString());
            }
            sdr.Close();
            conn.Close();
            return hd;
        }
        public List<HoaDon_DTO> LayDanhSachHoaDon()
        {
            lsHoaDon = new List<HoaDon_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * from HoaDon where TrangThai = 1 and DaThanhToan = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                HoaDon_DTO hd = new HoaDon_DTO();
                hd.MaHD = sdr["MaHD"].ToString();
                hd.MaPhong = sdr["MaPhong"].ToString();
                hd.GioVao = sdr["GioVao"].ToString();
                hd.GioRa = sdr["GioRa"].ToString();
                hd.TongTien = int.Parse(sdr["TongTien"].ToString());
                hd.NhanVienMoPhong = sdr["NhanVienMoPhong"].ToString();
                hd.NhanVienLapHDTT = sdr["NhanVienLapHDTT"].ToString();
                hd.NhanVienLapHD = sdr["NhanVienLapHD"].ToString();
                hd.NgayLap = DateTime.Parse(sdr["NgayLap"].ToString());
                hd.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsHoaDon.Add(hd);
            }
            sdr.Close();
            conn.Close();

            return lsHoaDon;
        }

        public string LayMaLonNhat()
        {
            string strketqua = string.Empty;
            string lenhtruyvan = "Select MAX(MaHD) from [HoaDon]";
            SqlConnection conn = DataProvider.TaoKetNoi();
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(lenhtruyvan, conn);
            while (sdr.Read())
            {
                strketqua = sdr[0].ToString();
            }
            sdr.Close();
            conn.Close();
            return strketqua;
        }

        public bool ThemHoaDon(HoaDon_DTO HoaDonMoi)
        {
            string strCauLenh = "Insert into HoaDon([MaHD],[MaPhong],[GioVao],[NhanVienMoPhong],[NhanVienLapHDTT],[NhanVienLapHD],[TongTien],[NgayLap],[TienGio],[TienPhut],[GioSuDung],[PhutSuDung],[DaThanhToan],[TrangThai])"
                + "Values(@MaHD,@MaPhong,@GioVao,@NhanVienMoPhong,null,null,0,null,@TienGio,@TienPhut,@GioSuDung,@PhutSuDung,0,1)";
            SqlParameter[] pars = new SqlParameter[8];
            pars[0] = new SqlParameter("@MaHD", HoaDonMoi.MaHD);
            pars[1] = new SqlParameter("@MaPhong", HoaDonMoi.MaPhong);
            pars[2] = new SqlParameter("@GioVao", HoaDonMoi.GioVao);
            pars[3] = new SqlParameter("@TienGio", HoaDonMoi.TienGio);
            pars[4] = new SqlParameter("@TienPhut",HoaDonMoi.TienPhut);
            pars[5] = new SqlParameter("@GioSuDung", HoaDonMoi.GioSuDung);
            pars[6] = new SqlParameter("@PhutSuDung", HoaDonMoi.PhutSuDung);
            pars[7] = new SqlParameter("@NhanVienMoPhong", HoaDonMoi.NhanVienMoPhong);
            SqlConnection conn = DataProvider.TaoKetNoi();
            bool kq = DataProvider.ThucThiCauLenh(strCauLenh, pars, conn);
            conn.Close();
            return kq;
        }

        public string LayMaHDChuaThanhToan(string p)
        {
            string strketqua = string.Empty;
            string lenhtruyvan = string.Format("Select MaHD from [HoaDon] Where MaPhong = '{0}' and DaThanhToan = 0",p);
            SqlConnection conn = DataProvider.TaoKetNoi();
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(lenhtruyvan, conn);
            while (sdr.Read())
            {
                strketqua = sdr[0].ToString();
            }
            sdr.Close();
            conn.Close();
            return strketqua;
        }

        public bool UpdateTraPhong(HoaDon_DTO HoaDonDTT)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update HoaDon Set GioRa = '{1}', GioSuDung = '{2}',PhutSuDung = '{3}',TongTien='{4}',NhanVienLapHD ='{5}',NgayLap = '{6}',DaThanhToan = 1 Where MaHD = '{0}' ", HoaDonDTT.MaHD, HoaDonDTT.GioRa, HoaDonDTT.GioSuDung, HoaDonDTT.PhutSuDung, HoaDonDTT.TongTien,HoaDonDTT.NhanVienLapHD,HoaDonDTT.NgayLap);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }
        public bool UpdateHoaDonTamTinh(HoaDon_DTO HoaDonTT)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update HoaDon Set GioRa = '{1}', GioSuDung = '{2}',PhutSuDung = '{3}',TongTien='{4}' ,NhanVienLapHDTT = '{5}',NgayLap = '{6}' Where MaHD = '{0}' ", HoaDonTT.MaHD,HoaDonTT.GioRa, HoaDonTT.GioSuDung, HoaDonTT.PhutSuDung, HoaDonTT.TongTien,HoaDonTT.NhanVienLapHDTT,HoaDonTT.NgayLap);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }
        public bool HuyHoaDonTamTinh(HoaDon_DTO HoaDonTT)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update HoaDon Set GioRa = '{1}', GioSuDung = '{2}',PhutSuDung = '{3}',TongTien='{4}',NhanVienLapHDTT ='{5}',NgayLap = '{6}' Where MaHD = '{0}' ", HoaDonTT.MaHD, null, null, null, null, null,string.Empty);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }
        public string KiemTraTonTaiHoaDonTamTinh(string p)
        {
            string strketqua = string.Empty;
            string lenhtruyvan = string.Format("Select TongTien from [HoaDon] Where MaPhong = '{0}' and DaThanhToan = 0", p);
            SqlConnection conn = DataProvider.TaoKetNoi();
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(lenhtruyvan, conn);
            while (sdr.Read())
            {
                strketqua = sdr[0].ToString();
            }
            sdr.Close();
            conn.Close();
            return strketqua;
        }

        public bool XoaHoaDon(HoaDon_DTO HoaDonXoa)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update HoaDon Set TrangThai = 0, DaThanhToan = 1 Where MaHD = '{0}' and MaPhong = N'{1}'", HoaDonXoa.MaHD, HoaDonXoa.MaPhong);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool ChuyenPhong(string MaPhongChuyen, string MaPhongBiChuyen)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update HoaDon Set MaPhong = '{1}' Where MaPhong = '{0}' and DaThanhToan = 0", MaPhongChuyen, MaPhongBiChuyen);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public string LayMaPhongTheoMaHD(string MaHD)
        {
            string MaPH = string.Empty;
            string lenhtruyvan = string.Format("Select MaPhong from [HoaDon] Where MaHD = '{0}' and DaThanhToan = 0", MaHD);
            SqlConnection conn = DataProvider.TaoKetNoi();
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(lenhtruyvan, conn);
            if (sdr.Read())
            {
                MaPH = sdr[0].ToString();
            }
            sdr.Close();
            conn.Close();
            return MaPH;
        }
    }
}
