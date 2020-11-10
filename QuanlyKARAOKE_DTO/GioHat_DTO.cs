using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DTO
{
    public class GioHat_DTO
    {
      public int ID { get; set; }
      public DateTime ThoiGianBatDau { get; set; }
      public DateTime ThoiGianKetThuc { get; set; }
      public string LoaiNgay { get; set; }
      public string LoaiPhong { get; set; }
      public int Gia { get; set; }
      public int TrangThai { get; set; }
    }
}
