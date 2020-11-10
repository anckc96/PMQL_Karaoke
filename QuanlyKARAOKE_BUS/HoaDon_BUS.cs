using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class HoaDon_BUS
    {
        HoaDon_DAO hd = new HoaDon_DAO();
        public HoaDon_DTO KiemTraPhongTrong(string MaPH)
        {
            return hd.KiemTraPhongTrong(MaPH);
        }
        public List<HoaDon_DTO> LayDanhSachHoaDon()
        {
            return hd.LayDanhSachHoaDon();
        }

        public string LayMaLonNhat()
        {
            string MaHDLonNhat = hd.LayMaLonNhat();
            if (string.IsNullOrEmpty(MaHDLonNhat))
            {
                return "HD001";
            }
            // loại bỏ chữ NV
            string MaMAX = MaHDLonNhat.Replace("HD", " ");
            int SoMAX = int.Parse(MaMAX);
            int MaNVTiepTheo = SoMAX + 1;
            return "HD" + MaNVTiepTheo.ToString("000");
        }

        public bool ThemHoaDon(HoaDon_DTO HoaDonMoi)
        {
            return hd.ThemHoaDon(HoaDonMoi);
        }

        public string LayMaHDChuaThanhToan(string p)
        {
            return hd.LayMaHDChuaThanhToan(p);
        }

        public bool UpdateTraPhong(HoaDon_DTO HoaDonDTT)
        {
            return hd.UpdateTraPhong(HoaDonDTT);
        }
        public bool UpdateHoaDonTamTinh(HoaDon_DTO HoaDonTT)
        {
            return hd.UpdateHoaDonTamTinh(HoaDonTT);
        }
        public bool HuyHoaDonTamTinh(HoaDon_DTO HoaDonTT)
        {
            return hd.HuyHoaDonTamTinh(HoaDonTT);
        }
        public string KiemTraTonTaiHoaDonTamTinh(string p)
        {
            return hd.KiemTraTonTaiHoaDonTamTinh(p);
        }

        public bool XoaHoaDon(HoaDon_DTO HoaDonXoa)
        {
            return hd.XoaHoaDon(HoaDonXoa);
        }

        public bool ChuyenPhong(string MaPhongChuyen, string MaPhongBiChuyen)
        {
            return hd.ChuyenPhong(MaPhongChuyen, MaPhongBiChuyen);
        }

        public string LayMaPhong(string MaHD)
        {
            return hd.LayMaPhongTheoMaHD(MaHD);
        }
    }
}
