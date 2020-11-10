using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanlyKARAOKE_DTO;
using System.Data.SqlClient;
namespace QuanlyKARAOKE_DAO
{
    public class LoaiNV_DAO
    {
        List<LoaiNV_DTO> lsLoaiNV;
        public List<LoaiNV_DTO> LayLoaiNV()
        {
            lsLoaiNV = new List<LoaiNV_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = "Select * From [LoaiNhanVien] Where TrangThai = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyvan,conn);
            while (sdr.Read())
            {
                LoaiNV_DTO loainv = new LoaiNV_DTO();
                loainv.MaLoaiNV = sdr["MaLoaiNV"].ToString();
                loainv.ChucVu = sdr["ChucVu"].ToString();
                loainv.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsLoaiNV.Add(loainv);
            }
            sdr.Close();
            conn.Close();
            return lsLoaiNV;
        }
    }
}
