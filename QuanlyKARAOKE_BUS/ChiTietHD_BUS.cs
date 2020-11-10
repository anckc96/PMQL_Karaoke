using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class ChiTietHD_BUS
    {
        ChiTietHD_DAO ct = new ChiTietHD_DAO();
        List<ChiTietHD_DTO> lsDSCTHD = new List<ChiTietHD_DTO>();
        DichVu_DAO dichVu_DAO = new DichVu_DAO();
        public ChiTietHD_DTO KiemTraTonTaiDVTrongHD(string MaDV, string MaHD)
        {
            return ct.KiemTraTonTaiDVTrongHD(MaDV, MaHD);
        }

        public bool ThemDichVu(ChiTietHD_DTO CTHD)
        {
            return ct.ThemDichVu(CTHD);
        }

        public List<ChiTietHD_DTO> LayDSCTHD(string MaPH)
        {
            string TenDV = string.Empty;
            List<ChiTietHD_DTO> lsDSCTHD = ct.LayDSCTHD(MaPH);
            for (int i = 0; i < lsDSCTHD.Count; i++ )
            {
                TenDV = dichVu_DAO.LayTenDichVuTheoMaDV(lsDSCTHD[i].MaDV);
                lsDSCTHD[i].MaDV = TenDV;
            }
            return lsDSCTHD;
        }

        public bool UpdateSoLuong(ChiTietHD_DTO CTHD)
        {
            return ct.UpdateSoLuong(CTHD);
        }

        public List<ChiTietHD_DTO> LayDSDVCuaHoaDon(string MaHDTT)
        {
            return ct.LayDSDVCuaHoaDon(MaHDTT);
        }

        public bool XoaDichVu(ChiTietHD_DTO ct1)
        {
            return ct.XoaDichVu(ct1);
        }

        public ChiTietHD_DTO KiemTraDVDaXoaTrongHD(string MaHD, string MaDV)
        {
            return ct.KiemTraDVDaXoaTrongHD(MaHD, MaDV);
        }

        public bool CapNhatLaiDichVuDaXoa(ChiTietHD_DTO CTHD)
        {
            return ct.CapNhatLaiDichVuDaXoa(CTHD);
        }

        public bool CapNhatGioHat(ChiTietHD_DTO ChiTietHD)
        {
            return ct.CapNhatGioHat(ChiTietHD);
        }

        public bool CapNhatDVKhachGoiThem(string MaDV, string MaHD, int soLuongDvKhachGoiThem)
        {
            return ct.CapNhatDVKhachGoiThem(MaDV, MaHD, soLuongDvKhachGoiThem);
        }

        public bool CapNhatDVKhachTraMon(string MaDV, string MaHD, int soLuongDvKhachTra)
        {
            return ct.CapNhatDVKhachTraMon(MaDV, MaHD, soLuongDvKhachTra);
        }

        public bool CapNhatDVKhachTraToanBo(string MaHD, string MaDV)
        {
            return ct.CapNhatDVKhachTraToanBo(MaHD, MaDV);
        }

        public int LayGioHat(string MaHD)
        {
            return ct.LayGioHat(MaHD);
        }
    }
}
