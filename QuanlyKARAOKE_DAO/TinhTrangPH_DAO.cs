using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class TinhTrangPH_DAO
    {
        List<TinhTrangPH_DTO> lsTTP;
        public List<TinhTrangPH_DTO> LayDanhSachTinhTrangPhong()
        {
            lsTTP = new List<TinhTrangPH_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * From [TinhTrangPhong] Where TrangThai = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                TinhTrangPH_DTO tt = new TinhTrangPH_DTO();
                tt.MaTinhTrang = sdr["MaTinhTrang"].ToString();
                tt.TinhTrang = sdr["TinhTrang"].ToString();
                tt.MoTa = sdr["MoTa"].ToString();
                tt.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsTTP.Add(tt);
            }
            sdr.Close();
            conn.Close();

            return lsTTP;
        }
    }
}
