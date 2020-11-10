using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class LoaiTaiKhoan_DAO
    {
        LoaiTaiKhoan_DTO TaiKhoan = new LoaiTaiKhoan_DTO();
        List<LoaiTaiKhoan_DTO> lsLoaiTK = new List<LoaiTaiKhoan_DTO>();
        public List<LoaiTaiKhoan_DTO> LayDSLoaiTK()
        {
            lsLoaiTK = new List<LoaiTaiKhoan_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = "Select * From [LoaiTaiKhoan] Where TrangThai = 1";
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyvan, conn);
            while (sdr.Read())
            {
                LoaiTaiKhoan_DTO ltk = new LoaiTaiKhoan_DTO();
                ltk.MaLoaiTK = sdr["MaLoaiTK"].ToString();
                ltk.TenMaLoaiTK = sdr["TenMaLoaiTK"].ToString();
                ltk.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsLoaiTK.Add(ltk);
            }
            sdr.Close();
            conn.Close();
            return lsLoaiTK;
        }
    }
}
