using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
   public class LichSuThaoTac_DAO
    {
       public void CapNhatThaoTac(string MaNVTT, string MaTT, string GhiChu, string ThoiGian)
       {
           SqlConnection conn = DataProvider.TaoKetNoi();
           string strInsert = string.Format("EXEC InsertOperationHistory '{0}', '{1}', N'{2}', '{3}';", MaNVTT, MaTT, GhiChu, ThoiGian);
           DataProvider.ThucThiCauLenh(strInsert, conn);
           conn.Close();
       }
     
    }
}
