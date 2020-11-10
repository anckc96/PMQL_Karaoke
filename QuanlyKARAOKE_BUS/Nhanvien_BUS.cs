using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanlyKARAOKE_DTO;
using QuanlyKARAOKE_DAO;
namespace QuanlyKARAOKE_BUS
{
    public class Nhanvien_BUS
    {
        Nhanvien_DAO nvDAO = new Nhanvien_DAO();
        public List<Nhanvien_DTO> LayDSnhanven()
        {         
            return nvDAO.LayDSnhanven();
        }

        public List<Nhanvien_DTO> RealTimeSearchNhanVienByName(string keyword)
        {
            return nvDAO.RealTimeSearchNhanVienByName(keyword);
        }
 

        public bool ThemNhanVien(Nhanvien_DTO nv)
        {
            return nvDAO.ThemMoiNhanVien(nv);
        }

        public bool XoaNVDuocChon(Nhanvien_DTO nv)
        {
            return nvDAO.XoaNVDuocChon(nv);
        }

        public bool CapNhatNhanVien(Nhanvien_DTO NhanVienCapNhat)
        {
            return nvDAO.CapNhatNhanVien(NhanVienCapNhat);
        }
        public string LayMaNVTiepTheo()
        {
            string MaNVLonNhat = nvDAO.LayMaNVLonNhat();
            if(string.IsNullOrEmpty(MaNVLonNhat))
            {
                return "NV001";
            }
            // loại bỏ chữ NV
            string MaMAX = MaNVLonNhat.Replace("NV", " ");
            int SoMAX = int.Parse(MaMAX);
            int MaNVTiepTheo = SoMAX + 1;
            return "NV" + MaNVTiepTheo.ToString("000");
        }
    }
}
