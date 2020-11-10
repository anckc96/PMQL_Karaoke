using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
  public  class LichSuThaoTac_BUS
    {
      LichSuThaoTac_DAO _LichSuThaoTacDAO = new LichSuThaoTac_DAO();
      public void CapNhatThaoTac(string MaNVTT, string MaTT, string GhiChu, string ThoiGian)
      {
           _LichSuThaoTacDAO.CapNhatThaoTac(MaNVTT,MaTT,GhiChu,ThoiGian);
      }


    }
}
