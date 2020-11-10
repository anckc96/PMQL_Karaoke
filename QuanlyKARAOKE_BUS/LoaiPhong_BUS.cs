using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class LoaiPhong_BUS
    {
        LoaiPhong_DAO lp_DAO = new LoaiPhong_DAO();
        public List<LoaiPhong_DTO> LayDanhSachLoaiPhongHat()
        {
            return lp_DAO.LayDanhSachLoaiPhongHat();
        }
    }
}
