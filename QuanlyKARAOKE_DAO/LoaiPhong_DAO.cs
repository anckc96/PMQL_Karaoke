using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class LoaiPhong_DAO
    {
        List<LoaiPhong_DTO> lsLoaiPhong;
        public List<LoaiPhong_DTO> LayDanhSachLoaiPhongHat()
        {
            lsLoaiPhong = new List<LoaiPhong_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyVan = "Select * From [LoaiPhongHat] Where TrangThai = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyVan, conn);
            while (sdr.Read())
            {
                LoaiPhong_DTO lp = new LoaiPhong_DTO();
                lp.MaLoai = sdr["MaLoai"].ToString();
                lp.TenPhong = sdr["TenPhong"].ToString();
                lp.GioBinhThuong = int.Parse(sdr["GioBinhThuong"].ToString());
                lp.GioCaoDiem = int.Parse(sdr["GioCaoDiem"].ToString());
                lp.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsLoaiPhong.Add(lp);
            }
            sdr.Close();
            conn.Close();

            return lsLoaiPhong;
        }
    }
}
