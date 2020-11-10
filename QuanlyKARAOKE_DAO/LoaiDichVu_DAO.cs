using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class LoaiDichVu_DAO
    {
        List<LoaiDichVu_DTO> lsLoaiDV;
        public List<LoaiDichVu_DTO> LayDanhSachLoaiDichVu()
        {
            lsLoaiDV = new List<LoaiDichVu_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * From [LoaiDichVu] Where TrangThai = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                LoaiDichVu_DTO LoaiDV = new LoaiDichVu_DTO();
                LoaiDV.MaLoaiDV = sdr["MaLoaiDV"].ToString();
                LoaiDV.TenLoaiDV = sdr["TenLoaiDV"].ToString();
                lsLoaiDV.Add(LoaiDV);
            }
            sdr.Close();
            conn.Close();

            return lsLoaiDV;
        }
    }
}
