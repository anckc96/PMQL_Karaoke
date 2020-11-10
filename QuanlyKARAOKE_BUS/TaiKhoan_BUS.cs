using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class TaiKhoan_BUS
    {
        TaiKhoan_DAO tkDAO = new TaiKhoan_DAO();
        public bool KiemTraDangNhap(TaiKhoan_DTO TaiKhoanDTO)
        {
            return tkDAO.KiemTraDangNhap(TaiKhoanDTO);
        }

        public string LayTenNV(TaiKhoan_DTO tk)
        {
            return tkDAO.LayTenNV(tk);
        }

        public TaiKhoan_DTO LayTTTK(TaiKhoan_DTO TaiKhoanDTO)
        {
            return tkDAO.LayTTTK(TaiKhoanDTO);
        }

        public TaiKhoan_DTO LayTTTKhoan(string p)
        {
            return tkDAO.LayTTTKhoan(p);
        }

        public string LayMaLonNhat()
        {
            string MaTKLonNhat = tkDAO.LayMaLonNhat();
            if (string.IsNullOrEmpty(MaTKLonNhat))
            {
                return "TK001";
            }
            // loại bỏ chữ NV
            string MaMAX = MaTKLonNhat.Replace("TK", " ");
            int SoMAX = int.Parse(MaMAX);
            int MaNVTiepTheo = SoMAX + 1;
            return "TK" + MaNVTiepTheo.ToString("000");
        }

        public bool ThemMoiTK(TaiKhoan_DTO TaiKhoanDK)
        {
            return tkDAO.ThemMoiTK(TaiKhoanDK);
        }

        public bool UpdateTaiKhoan(TaiKhoan_DTO TaiKhoanCN)
        {
            return tkDAO.UpdateTaiKhoan(TaiKhoanCN);
        }

        public bool XoaTaiKhoan(Nhanvien_DTO nv)
        {
            return tkDAO.XoaTaiKhoan(nv);
        }

        public int KiemTraCoPhaiLaAdminCC()
        {
            return tkDAO.KiemTraCoPhaiLaAdminCC();
        }

        public bool KiemTraCoPhaiLaTKAdmin(Nhanvien_DTO nv)
        {
            return tkDAO.KiemTraCoPhaiLaTKAdmin(nv);
        }

        public bool ChangePassword(string maTaiKhoan, string matKhau)
        {
            return tkDAO.ChangePassword(maTaiKhoan, matKhau);
        }

        public string LayMaNV(string TenTK)
        {
            return tkDAO.LayMaNV(TenTK);
        }
    }
}
