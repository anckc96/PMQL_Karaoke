using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class PhongHat_DAO
    {
        List<PhongHat_DTO> lsPH;
        public List<PhongHat_DTO> LayDanhSachPhongHat()
        {
            lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * From [PhongHat] Where TrangThai = 1 and TinhTrang != 'TT003'";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> RealTimeSearchRoomByName(string keyword)
        {
         List<PhongHat_DTO>   lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from PhongHat where TrangThai =1 AND TinhTrang != 'TT003' AND CONCAT(MaPH,dbo.ConvertToUnsign(TenPH))  LIKE N'%' + dbo.ConvertToUnsign(N'{0}') + '%'", keyword);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> SortByTypeVIP()
        {
            List<PhongHat_DTO> lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from PhongHat where TrangThai =1 AND TinhTrang != 'TT003' AND LoaiPhong ='LP001'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> SortByTypeNormal()
        {
            List<PhongHat_DTO> lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from PhongHat where TrangThai =1 AND TinhTrang != 'TT003' AND LoaiPhong ='LP002'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> SortByTypeRoomEmpty()
        {
            List<PhongHat_DTO> lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from PhongHat where TrangThai =1 AND TinhTrang != 'TT003' AND TinhTrang ='TT001'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> SortByTypeRoomWorked()
        {
            List<PhongHat_DTO> lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from PhongHat where TrangThai =1 AND TinhTrang != 'TT003' AND TinhTrang ='TT002'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public HoaDon_DTO KiemTraPhongTrong(PhongHat_DTO PhongHatChon)
        {
            HoaDon_DTO hd = new HoaDon_DTO();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From [HoaDon] Where MaPhong = '{0}' and DaThanhToan = 0", PhongHatChon.MaPH);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if(sdr.Read())
            {
                hd.MaHD = sdr["MaHD"].ToString();
                hd.MaPhong = sdr["MaPhong"].ToString();
                hd.NhanVienLapHD = sdr["NhanVienLapHD"].ToString();
                hd.TongTien = int.Parse(sdr["TongTien"].ToString());
                hd.NgayLap = (DateTime)sdr["NgayLap"];
                hd.DaThanhToan = int.Parse(sdr["DaThanhToan"].ToString());
                hd.TrangThai = int.Parse(sdr["TrangThai"].ToString());
            }
            sdr.Close();
            conn.Close();
            return hd;
        }
        public bool ThemPhongHat(PhongHat_DTO ph)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strInsert = string.Format("Insert into PhongHat Values ('{0}',N'{1}',N'{2}','{3}','{4}',1)", ph.MaPH, ph.TenPH, ph.MoTa,ph.LoaiPhong, ph.TinhTrang);
            bool a = DataProvider.ThucThiCauLenh(strInsert, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatPhong(PhongHat_DTO ph)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update PhongHat Set TenPH = '{1}', MoTa = N'{4}' ,LoaiPhong = '{2}', TinhTrang = '{3}' Where MaPH = '{0}'", ph.MaPH, ph.TenPH, ph.LoaiPhong, ph.TinhTrang, ph.MoTa);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public void SetPhongTrong(string MaPhongTrong)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update PhongHat Set TinhTrang = 'TT001' where MaPH = '{0}'", MaPhongTrong);
            DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
        }
        public void SetPhongDangSuDung(string MaPhongDangSuDung)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update PhongHat Set TinhTrang = 'TT002' where MaPH = '{0}'", MaPhongDangSuDung);
            DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
        }
        public void ChuyenPhong(string MaPhongChuyen, string MaPhongBiChuyen)
        {
            SetPhongTrong(MaPhongChuyen);
            SetPhongDangSuDung(MaPhongBiChuyen);
        }

        public bool XoaPhongDuocChon(PhongHat_DTO ph)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update PhongHat Set TrangThai = 0 Where MaPH = '{0}'", ph.MaPH);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }




        public List<PhongHat_DTO> LayDSPhongTrong()
        {
            lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select DISTINCT PhongHat.* From [PhongHat] Where  TinhTrang = 'TT001' and TrangThai = 1 and   NOT EXISTS ( Select MaPhong From HoaDon where DaThanhToan = 0  and MaPH = MaPhong )";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> LayDSPhongDangSD()
        {
            lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select PhongHat.* From [PhongHat], [HoaDon] Where MaPH = MaPhong and PhongHat.TrangThai = 1 and TinhTrang != 'TT003' and DaThanhToan = 0";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }

        public List<PhongHat_DTO> LayDSPhongHat()
        {
            lsPH = new List<PhongHat_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * From [PhongHat] Where TrangThai = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                PhongHat_DTO ph = new PhongHat_DTO();
                ph.MaPH = sdr["MaPH"].ToString();
                ph.TenPH = sdr["TenPH"].ToString();
                ph.MoTa = sdr["MoTa"].ToString();
                ph.LoaiPhong = sdr["LoaiPhong"].ToString();
                ph.TinhTrang = sdr["TinhTrang"].ToString();
                ph.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsPH.Add(ph);
            }
            sdr.Close();
            conn.Close();

            return lsPH;
        }
        public string LayMaPhongLonNhat()
        {
            string strketqua = null;
            string lenhtruyvan = "Select MAX(MaPH) from PhongHat";
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
    }
}
