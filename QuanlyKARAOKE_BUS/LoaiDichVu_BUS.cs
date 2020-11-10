using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class LoaiDichVu_BUS
    {
        LoaiDichVu_DAO LoaiDV_DAO = new LoaiDichVu_DAO();
        public List<LoaiDichVu_DTO> LayDanhSachLoaiDichVu()
        {
            return LoaiDV_DAO.LayDanhSachLoaiDichVu();
        }
    }
}
