using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanlyKARAOKE_DTO;
using System.Data.SqlClient;

namespace QuanlyKARAOKE_DAO
{
    public class ThongKe_DAO
    {
        public List<DichVu_DTO> ThongKeSoLuongTonSP(string soluong)
        {
            List<DichVu_DTO> ListThongKe = new List<DichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("select * from DichVu where TrangThai =1 AND SoLuong <= '{0}'", soluong);
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
                ListThongKe.Add(dv);
            }
            sdr.Close();
            conn.Close();
            return ListThongKe;
        }


        public List<HoaDon_DTO> LoadDSHoaDonFromDayToDay(DateTime fromday, DateTime today)
        {
           List<HoaDon_DTO> lsHoaDon = new List<HoaDon_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = string.Format("Select * from HoaDon where TrangThai = 1 and DaThanhToan = 1 and NgayLap between '{0}' and '{1}'", fromday, today);
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
    } 
}
