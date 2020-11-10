using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanlyKARAOKE_DTO;
using System.Data.SqlClient;
using System.Globalization;
using System.Net;
namespace QuanlyKARAOKE_DAO
{
    public class Nhanvien_DAO
    {
        public List<Nhanvien_DTO> LayDSnhanven()
        { 
             List<Nhanvien_DTO> lsNhanVien = new List<Nhanvien_DTO>();
             SqlConnection conn = DataProvider.TaoKetNoi();
             string strTruyvan = "Select * From [NhanVien] Where TrangThai = 1";
             SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyvan,conn);
             while (sdr.Read())
             {
                 Nhanvien_DTO nv = new Nhanvien_DTO();
                 nv.MaNV = sdr["MaNV"].ToString();
                 nv.HoTenNV = sdr["HoTenNV"].ToString();             
                 nv.NgaySinh = DateTime.Parse(sdr["NgaySinh"].ToString());
                 nv.GioiTinh = sdr["GioiTinh"].ToString();
                 nv.DienThoai = sdr["DienThoai"].ToString();
                 nv.DiaChi = sdr["DiaChi"].ToString();
                 nv.HinhAnhNV = sdr["HinhAnhNV"].ToString();
                 nv.LoaiNV = sdr["LoaiNV"].ToString();
                 nv.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                 lsNhanVien.Add(nv);
             }

             sdr.Close();
             conn.Close();

            return lsNhanVien;
        }

        public List<Nhanvien_DTO> RealTimeSearchNhanVienByName(string keyword)
        {
            List<Nhanvien_DTO> lsNhanVien = new List<Nhanvien_DTO>();
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("select * from NhanVien where TrangThai = 1 AND CONCAT(MaNV,dbo.ConvertToUnsign(HoTenNV),NgaySinh,dbo.ConvertToUnsign(GioiTinh),DienThoai,dbo.ConvertToUnsign(DiaChi),dbo.ConvertToUnsign(LoaiNV))  LIKE N'%' + dbo.ConvertToUnsign(N'{0}') + '%'", keyword);
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(strTruyvan, conn);
            while (sdr.Read())
            {
                Nhanvien_DTO nv = new Nhanvien_DTO();
                nv.MaNV = sdr["MaNV"].ToString();
                nv.HoTenNV = sdr["HoTenNV"].ToString();
                nv.NgaySinh = DateTime.Parse(sdr["NgaySinh"].ToString());
                nv.GioiTinh = sdr["GioiTinh"].ToString();
                nv.DienThoai = sdr["DienThoai"].ToString();
                nv.DiaChi = sdr["DiaChi"].ToString();
                nv.HinhAnhNV = sdr["HinhAnhNV"].ToString();
                nv.LoaiNV = sdr["LoaiNV"].ToString();
                nv.TrangThai = int.Parse(sdr["TrangThai"].ToString());
                lsNhanVien.Add(nv);
            }

            sdr.Close();
            conn.Close();

            return lsNhanVien;
        }


      
        public bool ThemMoiNhanVien(Nhanvien_DTO nv)
        {
            string lenhtruyvan = "Insert into NhanVien([MaNV],[HoTenNV],[NgaySinh],[GioiTinh],[DienThoai],[DiaChi],[HinhAnhNV],[LoaiNV],[TrangThai])"
                + "Values(@MaNV,@HoTenNV,@NgaySinh,@GioiTinh,@DienThoai,@DiaChi,@HinhAnhNV,@LoaiNV,1)";
            SqlParameter[] pars = new SqlParameter[9];
            pars[0] = new SqlParameter("@MaNV", nv.MaNV);
            pars[1] = new SqlParameter("@HoTenNV", nv.HoTenNV);
            pars[2] = new SqlParameter("@NgaySinh", nv.NgaySinh);
            pars[3] = new SqlParameter("@GioiTinh", nv.GioiTinh);
            pars[4] = new SqlParameter("@DienThoai", nv.DienThoai);
            pars[5] = new SqlParameter("@DiaChi", nv.DiaChi);
            pars[6] = new SqlParameter("@HinhAnhNV", nv.HinhAnhNV);
            pars[7] = new SqlParameter("@LoaiNV", nv.LoaiNV);
            pars[8] = new SqlParameter("@TrangThai", nv.TrangThai);
            SqlConnection conn = DataProvider.TaoKetNoi();
            bool kq = DataProvider.ThucThiCauLenh(lenhtruyvan, pars, conn);
            conn.Close();
            return kq;
        }

        public bool XoaNVDuocChon(Nhanvien_DTO nv)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update NhanVien Set TrangThai=0 where MaNV= '{0}'",nv.MaNV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }

        public bool CapNhatNhanVien(Nhanvien_DTO NhanVienCapNhat)
        {
            SqlConnection conn = DataProvider.TaoKetNoi();
            string strTruyvan = string.Format("Update NhanVien Set HoTenNV = N'{1}', NgaySinh = '{2}', GioiTinh = N'{3}', DienThoai = '{4}', DiaChi = N'{5}', LoaiNV = '{6}', HinhAnhNV = '{7}' Where MaNV= '{0}'", NhanVienCapNhat.MaNV, NhanVienCapNhat.HoTenNV,NhanVienCapNhat.NgaySinh,NhanVienCapNhat.GioiTinh,NhanVienCapNhat.DienThoai,NhanVienCapNhat.DiaChi,NhanVienCapNhat.LoaiNV, NhanVienCapNhat.HinhAnhNV);
            bool a = DataProvider.ThucThiCauLenh(strTruyvan, conn);
            conn.Close();
            return a;
        }
        public string LayMaNVLonNhat()
        {
            string strketqua= null;
            string lenhtruyvan = "Select MAX(MaNV) from NhanVien";
            SqlConnection conn = DataProvider.TaoKetNoi();
            SqlDataReader sdr = DataProvider.TruyVanDuLieu(lenhtruyvan, conn);
            while(sdr.Read())
            {
                strketqua = sdr[0].ToString();
            }
            sdr.Close();
            conn.Close();
            return strketqua;
        }
     
    }
}
