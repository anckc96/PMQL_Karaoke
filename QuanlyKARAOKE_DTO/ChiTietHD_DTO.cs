using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DTO
{
    public class ChiTietHD_DTO
    {
        public string MaHD { get; set; }
        public string MaDV { get; set; }
        public int SoLuong { get; set; }
        public double GiaBan { get; set; }
        public int ThanhTien
        {
            get
            {
                return Convert.ToInt32(Math.Round(GiaBan * SoLuong,3));
            }
        }
        public int TrangThai { get; set; }
    }
}
