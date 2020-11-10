using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class DichVu_BUS
    {
        DichVu_DAO dv_DAO = new DichVu_DAO();
        public List<DichVu_DTO> LayDanhSachDichVu()
        {
            return dv_DAO.LayDanhSachDichVu();
        }

        public List<DichVu_DTO> RealTimeSearchFoodByName(string keyword)
        {
            return dv_DAO.RealTimeSearchFoodByName(keyword);
        }
        public List<DichVu_DTO> SortFoodByTypeFood()
        {
            return dv_DAO.SortFoodByTypeFood();
        }
        public List<DichVu_DTO> SortFoodByTypeDrink()
        {
            return dv_DAO.SortFoodByTypeDrink();
        }
        public bool ThemDichVu(DichVu_DTO dv)
        {
            return dv_DAO.ThemDichVu(dv);
        }

        public bool CapNhatDichVu(DichVu_DTO dv)
        {
            return dv_DAO.CapNhatDichVu(dv);
        }

        public bool XoaDVDuocChon(DichVu_DTO dv)
        {
            return dv_DAO.XoaDVDuocChon(dv);
        }
        public string LayDichVuTiepTheo()
        {
            string MaDVLonNhat = dv_DAO.LayMaSPLonNhat();
            if (string.IsNullOrEmpty(MaDVLonNhat))
            {
                return "DV001";
            }
            // loại bỏ chữ NV
            string MaMAX = MaDVLonNhat.Replace("DV", " ");
            int SoMAX = int.Parse(MaMAX);
            int MaDVTiepTheo = SoMAX + 1;
            return "DV" + MaDVTiepTheo.ToString("000");
        }

        public bool KiemTraTT(string p)
        {
            return dv_DAO.KiemTraTT(p);
        }

        public bool CapNhatSoLuongKhiThanhToanHoaDon(string DichVu, int SoLuong)
        {
            return dv_DAO.CapNhatSoLuongKhiThanhToanHoaDon(DichVu, SoLuong);
        }

        public int LaySoLuongTonTheoMaDV(string MaDV)
        {
            return dv_DAO.LaySoLuongTonTheoMaDV(MaDV);
        }

        public string LayMaDVTheoTenDV(string TenDV)
        {
            return dv_DAO.LayMaDVTheoTenDV(TenDV);
        }

        public string LayTenDichVuTheoMaDV(string MaDV)
        {
            return dv_DAO.LayTenDichVuTheoMaDV(MaDV);
        }
    }
}
