using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class LoaiTaiKhoan_BUS
    {
        LoaiTaiKhoan_DAO LoaiTK_DAO = new LoaiTaiKhoan_DAO();
        public List<LoaiTaiKhoan_DTO> LayDSLoaiTK()
        {
            return LoaiTK_DAO.LayDSLoaiTK();
        }
    }
}
