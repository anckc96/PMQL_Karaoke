using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DTO
{
    public class HoaDon_DTO
    {
        public string MaHD { get; set; }
        public string MaPhong { get; set; }
        public string GioVao { get; set; }
        public string GioRa { get; set; }
        public string NhanVienMoPhong { get; set; }
        public string NhanVienLapHDTT { get; set; }
        public string NhanVienLapHD { get; set; }
        public double TongTien { get; set; }
        public DateTime NgayLap { get; set; }
        public int TienGio { get; set; }
        public int TienPhut { get; set; }
        public int GioSuDung { get; set; }
        public int PhutSuDung { get; set; }
        public int DaThanhToan { get; set; }
        public int TrangThai { get; set; }
    }
}
