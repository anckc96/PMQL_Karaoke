using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_BUS
{
    public class TinhTrangPH_BUS
    {
        TinhTrangPH_DAO ttp_DAO = new TinhTrangPH_DAO();
        public List<TinhTrangPH_DTO> LayDanhSachTinhTrangPhong()
        {
            return ttp_DAO.LayDanhSachTinhTrangPhong();
        }
    }
}
