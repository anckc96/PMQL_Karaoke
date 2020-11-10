using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanlyKARAOKE_DAO;
using QuanlyKARAOKE_DTO;
namespace QuanlyKARAOKE_BUS
{
   public class LoaiNV_BUS
    {
       public List<LoaiNV_DTO> LayLoaiNV()
       {
           LoaiNV_DAO loainvDAO = new LoaiNV_DAO();
           return loainvDAO.LayLoaiNV();
       }
    }
}
