using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class TaiKhoan_DAO
    {
        public bool KiemTraDangNhap(TaiKhoan_DTO TaiKhoanDTO)
        {
            List<TaiKhoan_DTO> lsTK = new List<TaiKhoan_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From TaiKhoan Where TenTaiKhoan = '{0}' AND MatKhau = '{1}' AND TrangThai = 1", TaiKhoanDTO.TenTaiKhoan, TaiKhoanDTO.MatKhau);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                TaiKhoan_DTO tk = new TaiKhoan_DTO();
                tk.MaTaiKhoan = sdr["MaTaiKhoan"].ToString();
                tk.TenTaiKhoan = sdr["TenTaiKhoan"].ToString();
                tk.MatKhau = sdr["MatKhau"].ToString();
                tk.MaNV = sdr["MaNV"].ToString();
                tk.LoaiTaiKhoan = sdr["LoaiTaiKhoan"].ToString();
                tk.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsTK.Add(tk);
            }
            sdr.Close();
            conn.Close();
            return lsTK.Count > 0 ? true : false;
        }

        public string LayTenNV(TaiKhoan_DTO tk)
        {
            string TenNV = "";
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select HoTenNV From TaiKhoan, NhanVien Where NhanVien.MaNV = TaiKhoan.MaNV and TenTaiKhoan = '{0}'", tk.TenTaiKhoan);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if(sdr.Read())
            {
                TenNV = sdr["HoTenNV"].ToString();
            }
            return TenNV;
        }

        public TaiKhoan_DTO LayTTTK(TaiKhoan_DTO TaiKhoanDTO)
        {
            TaiKhoan_DTO tk = new TaiKhoan_DTO();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From TaiKhoan Where TenTaiKhoan = '{0}'", TaiKhoanDTO.TenTaiKhoan);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                tk = new TaiKhoan_DTO();
                tk.MaNV = sdr["MaNV"].ToString();
                tk.TenTaiKhoan = sdr["TenTaiKhoan"].ToString();
                tk.MaNV = sdr["MaNV"].ToString();
                tk.LoaiTaiKhoan = sdr["LoaiTaiKhoan"].ToString();
                tk.TrangThai = int.Parse(sdr["TrangThai"].ToString());
            }
            return tk;
        }

        public bool ChangePassword(string maTaiKhoan, string matKhau)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update TaiKhoan Set MatKhau = '{1}' Where MaTaiKhoan = '{0}'", maTaiKhoan, matKhau);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public TaiKhoan_DTO LayTTTKhoan(string p)
        {
            TaiKhoan_DTO tk = new TaiKhoan_DTO();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From TaiKhoan Where MaNV = '{0}'", p);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                tk = new TaiKhoan_DTO();
                tk.MaTaiKhoan = sdr["MaTaiKhoan"].ToString(); 
                tk.MaNV = sdr["MaNV"].ToString();
                tk.TenTaiKhoan = sdr["TenTaiKhoan"].ToString();
                tk.MatKhau = sdr["MatKhau"].ToString();
                tk.MaNV = sdr["MaNV"].ToString();
                tk.LoaiTaiKhoan = sdr["LoaiTaiKhoan"].ToString();
                tk.TrangThai = int.Parse(sdr["TrangThai"].ToString());
            }
            return tk;
        }

        public string LayMaLonNhat()
        {
            string strketqua = null;
            string lenhtruyvan = "Select MAX(MaTaiKhoan) from TaiKhoan";
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

        public bool ThemMoiTK(TaiKhoan_DTO TaiKhoanDK)
        {
            string strTruyVan = "Insert into TaiKhoan([MaTaiKhoan],[TenTaiKhoan],[MatKhau],[MaNV],[LoaiTaiKhoan],[TrangThai])"
                + "Values(@MaTaiKhoan,@TenTaiKhoan,@MatKhau,@MaNV,@LoaiTaiKhoan,1)";
            SqlParameter[] pars = new SqlParameter[6];
            pars[0] = new SqlParameter("@MaTaiKhoan", TaiKhoanDK.MaTaiKhoan);
            pars[1] = new SqlParameter("@TenTaiKhoan", TaiKhoanDK.TenTaiKhoan);
            pars[2] = new SqlParameter("@MatKhau", TaiKhoanDK.MatKhau);
            pars[3] = new SqlParameter("@MaNV", TaiKhoanDK.MaNV);
            pars[4] = new SqlParameter("@LoaiTaiKhoan", TaiKhoanDK.LoaiTaiKhoan);
            pars[5] = new SqlParameter("@TrangThai", TaiKhoanDK.TrangThai);
            SqlConnection conn = DataProvider.TaoKetNoi();
            bool kq = DataProvider.ThucThiCauLenh(strTruyVan, pars, conn);
            conn.Close();
            return kq;
        }

        public bool UpdateTaiKhoan(TaiKhoan_DTO TaiKhoanCN)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update TaiKhoan Set TenTaiKhoan = '{1}', LoaiTaiKhoan = N'{2}'  Where MaTaiKhoan = '{0}'", TaiKhoanCN.MaTaiKhoan,TaiKhoanCN.TenTaiKhoan,TaiKhoanCN.LoaiTaiKhoan);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool XoaTaiKhoan(Nhanvien_DTO nv)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update TaiKhoan Set TrangThai=0 where MaNV = '{0}'", nv.MaNV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public int KiemTraCoPhaiLaAdminCC()
        {
            int i = 0;          
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select Count(*) From TaiKhoan Where TrangThai = 1 and LoaiTaiKhoan = 'LOAITK001'");
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                i = int.Parse(sdr[0].ToString());
            }
            sdr.Close();
            conn.Close();

            return i;
        }

        public bool KiemTraCoPhaiLaTKAdmin(Nhanvien_DTO nv)
        {
            List<TaiKhoan_DTO> lsTK = new List<TaiKhoan_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * From TaiKhoan Where TrangThai = 1 and LoaiTaiKhoan = 'LOAITK001' and MaNV = '{0}'", nv.MaNV);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                TaiKhoan_DTO tk = new TaiKhoan_DTO();
                tk.MaTaiKhoan = sdr["MaTaiKhoan"].ToString();
                tk.MaNV = sdr["MaNV"].ToString();
                tk.TenTaiKhoan = sdr["TenTaiKhoan"].ToString();
                tk.MatKhau = sdr["MatKhau"].ToString();
                tk.MaNV = sdr["MaNV"].ToString();
                tk.LoaiTaiKhoan = sdr["LoaiTaiKhoan"].ToString();
                tk.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsTK.Add(tk);
            }
            sdr.Close();
            conn.Close();
            if (lsTK.Count > 0)
                return true;
            else
                return false;
        }

        public string LayMaNV(string TenTK)
        {
            string MaNV = "";
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select MaNV From TaiKhoan Where TenTaiKhoan = '{0}'", TenTK);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            if (sdr.Read())
            {
                MaNV = sdr["MaNV"].ToString();
            }
            return MaNV;
        }
    }
}
