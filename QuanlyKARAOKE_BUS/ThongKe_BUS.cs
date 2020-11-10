using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
namespace QuanlyKARAOKE_BUS
{
  public  class ThongKe_BUS
    {
        ThongKe_DAO _ThongKeDao = new ThongKe_DAO();
          public List<DichVu_DTO> ThongKeSoLuongTonSP(string soluong)
        {
            return _ThongKeDao.ThongKeSoLuongTonSP(soluong);
        }

          public List<HoaDon_DTO> LoadDSHoaDonFromDayToDay(DateTime fromday, DateTime today)
          {
              return _ThongKeDao.LoadDSHoaDonFromDayToDay(fromday,today);
          }

        
    }
}
