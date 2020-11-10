using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class PhongHat_BUS
    {
        PhongHat_DAO ph_DAO = new PhongHat_DAO();
        public List<PhongHat_DTO> LayDanhSachPhongHat()
        {
            return ph_DAO.LayDanhSachPhongHat();
        }

        public List<PhongHat_DTO> RealTimeSearchRoomByName(string keyword)
        {
            return ph_DAO.RealTimeSearchRoomByName(keyword);
        }
        public List<PhongHat_DTO> SortByTypeVIP()
        {
            return ph_DAO.SortByTypeVIP();
        }
        public List<PhongHat_DTO> SortByTypeNormal()
        {
            return ph_DAO.SortByTypeNormal();
        }
        public List<PhongHat_DTO> SortByTypeRoomEmpty()
        {
            return ph_DAO.SortByTypeRoomEmpty();
        }
        public List<PhongHat_DTO> SortByTypeRoomWorked()
        {
            return ph_DAO.SortByTypeRoomWorked();
        }

        public bool ThemPhongHat(PhongHat_DTO ph)
        {
            return ph_DAO.ThemPhongHat(ph);
        }

        public bool CapNhatPhong(PhongHat_DTO ph)
        {
            return ph_DAO.CapNhatPhong(ph);
        }
        public void SetPhongTrong(string MaPhongTrong)
        {
            ph_DAO.SetPhongTrong(MaPhongTrong);
        }
        public void SetPhongDangSuDung(string MaPhongDangSuDung)
        {
            ph_DAO.SetPhongDangSuDung(MaPhongDangSuDung);
        }
       
    
        public void ChuyenPhong(string MaPhongChuyen, string MaPhongBiChuyen)
        {
            ph_DAO.ChuyenPhong( MaPhongChuyen, MaPhongBiChuyen);
        }

        public bool XoaPhongDuocChon(PhongHat_DTO ph)
        {
            return ph_DAO.XoaPhongDuocChon(ph);
        }

        public HoaDon_DTO KiemTraPhongTrong(PhongHat_DTO PhongHatChon)
        {
            return ph_DAO.KiemTraPhongTrong(PhongHatChon);
        }

        public List<PhongHat_DTO> LayDSPhongTrong()
        {
            return ph_DAO.LayDSPhongTrong();
        }

        public List<PhongHat_DTO> LayDSPhongDangSD()
        {
            return ph_DAO.LayDSPhongDangSD();
        }

        public List<PhongHat_DTO> LayDSPhongHat()
        {
            return ph_DAO.LayDSPhongHat();
        }
        public string LayMaPhongTiepTheo()
        {
            string MaPhongLonNhat = ph_DAO.LayMaPhongLonNhat();
            if (string.IsNullOrEmpty(MaPhongLonNhat))
            {
                return "PH001";
            }
            // loại bỏ chữ NV
            string MaMAX = MaPhongLonNhat.Replace("PH", " ");
            int SoMAX = int.Parse(MaMAX);
            int MaPhongTiepTheo = SoMAX + 1;
            return "PH" + MaPhongTiepTheo.ToString("000");
        }
    }
}
