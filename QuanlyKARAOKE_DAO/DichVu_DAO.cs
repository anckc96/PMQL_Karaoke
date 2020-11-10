using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class DichVu_DAO
    {
        List<DichVu_DTO> lsMenuDV;
        public List<DichVu_DTO> LayDanhSachDichVu()
        {
            lsMenuDV = new List<DichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * From [DichVu] Where TrangThai = 1 and TenDV <> N'Giờ Hát'";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while(sdr.Read())
            {
                DichVu_DTO dv = new DichVu_DTO();
                dv.MaDV = sdr["MaDV"].ToString();
                dv.TenDV = sdr["TenDV"].ToString();
                dv.DonGiaBan = int.Parse(sdr["DonGiaBan"].ToString());
                dv.DonViTinh = sdr["DonViTinh"].ToString();
                dv.DonGiaBanHienTai = int.Parse(sdr["DonGiaBanHienTai"].ToString());
                dv.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                dv.MoTa = sdr["MoTa"].ToString();
                dv.MaLoaiDV = sdr["MaLoaiDV"].ToString();
                dv.TrangThai = int.Parse(sdr["TrangThai"].ToString());

                lsMenuDV.Add(dv);
            }
            sdr.Close();
            conn.Close();

            return lsMenuDV;
        }

       

        public List<DichVu_DTO> RealTimeSearchFoodByName(string keyword)
        {
            List<DichVu_DTO> SearchList = new List<DichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from DichVu where TrangThai =1 AND CONCAT(MaDV,dbo.ConvertToUnsign(TenDV),dbo.ConvertToUnsign(DonViTinh),dbo.ConvertToUnsign(MoTa),DonGiaBanHienTai,DonGiaBan) LIKE N'%' + dbo.ConvertToUnsign(N'{0}') + '%'", keyword);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                DichVu_DTO dv = new DichVu_DTO();
                dv.MaDV = sdr["MaDV"].ToString();
                dv.TenDV = sdr["TenDV"].ToString();
                dv.DonGiaBan = int.Parse(sdr["DonGiaBan"].ToString());
                dv.DonViTinh = sdr["DonViTinh"].ToString();
                dv.DonGiaBanHienTai = int.Parse(sdr["DonGiaBanHienTai"].ToString());
                dv.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                dv.MoTa = sdr["MoTa"].ToString();
                dv.MaLoaiDV = sdr["MaLoaiDV"].ToString();
                dv.TrangThai = int.Parse(sdr["TrangThai"].ToString());

                SearchList.Add(dv);
            }
            sdr.Close();
            conn.Close();

            return SearchList;
        }

        public List<DichVu_DTO> SortFoodByTypeFood()
        {
            List<DichVu_DTO> SortList = new List<DichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from DichVu where TrangThai =1 AND MaLoaiDV = 'LOAIDV002'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                DichVu_DTO dv = new DichVu_DTO();
                dv.MaDV = sdr["MaDV"].ToString();
                dv.TenDV = sdr["TenDV"].ToString();
                dv.DonGiaBan = int.Parse(sdr["DonGiaBan"].ToString());
                dv.DonViTinh = sdr["DonViTinh"].ToString();
                dv.DonGiaBanHienTai = int.Parse(sdr["DonGiaBanHienTai"].ToString());
                dv.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                dv.MoTa = sdr["MoTa"].ToString();
                dv.MaLoaiDV = sdr["MaLoaiDV"].ToString();
                dv.TrangThai = int.Parse(sdr["TrangThai"].ToString());

                SortList.Add(dv);
            }
            sdr.Close();
            conn.Close();

            return SortList;
        }

        public List<DichVu_DTO> SortFoodByTypeDrink()
        {
            List<DichVu_DTO> SortList = new List<DichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from DichVu where TrangThai =1 AND MaLoaiDV = 'LOAIDV001'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                DichVu_DTO dv = new DichVu_DTO();
                dv.MaDV = sdr["MaDV"].ToString();
                dv.TenDV = sdr["TenDV"].ToString();
                dv.DonGiaBan = int.Parse(sdr["DonGiaBan"].ToString());
                dv.DonViTinh = sdr["DonViTinh"].ToString();
                dv.DonGiaBanHienTai = int.Parse(sdr["DonGiaBanHienTai"].ToString());
                dv.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                dv.MoTa = sdr["MoTa"].ToString();
                dv.MaLoaiDV = sdr["MaLoaiDV"].ToString();
                dv.TrangThai = int.Parse(sdr["TrangThai"].ToString());

                SortList.Add(dv);
            }
            sdr.Close();
            conn.Close();

            return SortList;
        }


        public bool ThemDichVu(DichVu_DTO dv)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strInsert = string.Format("Insert into DichVu Values ('{0}',N'{1}',N'{2}','{3}','{4}','{5}',N'{6}','{7}',1)", dv.MaDV, dv.TenDV, dv.DonViTinh, dv.DonGiaBanHienTai, dv.DonGiaBan, dv.SoLuong, dv.MoTa, dv.MaLoaiDV);
            bool a = DataProvider.ThucThiCauLenh(strInsert, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatDichVu(DichVu_DTO dv)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update DichVu Set TenDV = N'{1}', DonViTinh = N'{2}', DonGiaBanHienTai = '{3}', DonGiaBan = '{4}', SoLuong = '{5}', MoTa = N'{6}', MaLoaiDV = '{7}'  Where MaDV = '{0}'", dv.MaDV, dv.TenDV, dv.DonViTinh, dv.DonGiaBanHienTai, dv.DonGiaBan, dv.SoLuong, dv.MoTa, dv.MaLoaiDV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool XoaDVDuocChon(DichVu_DTO dv)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update DichVu Set TrangThai= 0 where MaDV = '{0}'", dv.MaDV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }
        public string LayMaSPLonNhat()
        {
            string strketqua = null;
            string lenhtruyvan = "Select MAX(MaDV) from DichVu";
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

        public bool KiemTraTT(string p)
        {
            DichVu_DTO dv = new DichVu_DTO();
            lsMenuDV = new List<DichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From [DichVu] Where TrangThai = 1 and TenDV = N'{0}'", p);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                dv = new DichVu_DTO();
                dv.MaDV = sdr["MaDV"].ToString();
                dv.TenDV = sdr["TenDV"].ToString();
                dv.DonGiaBan = int.Parse(sdr["DonGiaBan"].ToString());
                dv.DonViTinh = sdr["DonViTinh"].ToString();
                dv.DonGiaBanHienTai = int.Parse(sdr["DonGiaBanHienTai"].ToString());
                dv.SoLuong = int.Parse(sdr["SoLuong"].ToString());
                dv.MoTa = sdr["MoTa"].ToString();
                dv.MaLoaiDV = sdr["MaLoaiDV"].ToString();
                dv.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsMenuDV.Add(dv);
            }
            sdr.Close();
            conn.Close();
            if (lsMenuDV.Count > 0)
                return true;
            else
                return false;
            
        }

        public bool CapNhatSoLuongKhiThanhToanHoaDon(string DichVu, int SoLuong)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update DichVu Set SoLuong = SoLuong - {1} Where TenDV = N'{0}'", DichVu, SoLuong);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public int LaySoLuongTonTheoMaDV(string MaDV)
        {
            int SoLuongTon = 0;
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select SoLuong from DichVu where MaDV = '{0}'",MaDV);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                SoLuongTon = int.Parse(sdr["SoLuong"].ToString());
            }
            sdr.Close();
            conn.Close();
            return SoLuongTon;
        }

        public string LayTenDichVuTheoMaDV(string MaDV)
        {
            string TenDV = string.Empty;
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select TenDV from DichVu where MaDV = '{0}'", MaDV);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                TenDV = sdr["TenDV"].ToString();
            }
            sdr.Close();
            conn.Close();
            return TenDV;
        }

        public string LayMaDVTheoTenDV(string TenDV)
        {
            string MaDV = string.Empty;
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select MaDV from DichVu where TenDV = N'{0}'", TenDV);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                MaDV = sdr["MaDV"].ToString();
            }
            sdr.Close();
            conn.Close();
            return MaDV;
        }
    }
}
