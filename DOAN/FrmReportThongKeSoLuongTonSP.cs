using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanlyKARAOKE_BUS;
using QuanlyKARAOKE_DTO;
namespace DOAN
{
    public partial class frmThongKeSoLuongTonSP : Form
    {
        public frmThongKeSoLuongTonSP()
        {
            InitializeComponent();
        }
        ThongKe_BUS _ThongKeBUS = new ThongKe_BUS();
        DichVu_BUS _DichVuBUS = new DichVu_BUS();
        LoaiDichVu_BUS _LoaiDichVuBUS = new LoaiDichVu_BUS();
        List<LoaiDichVu_DTO> lsLoaiDV_DTO;

      
        LoaiDichVu_BUS LoaiDichVuBUS = new LoaiDichVu_BUS();
        private void frmThongKeSoLuongTonSP_Load(object sender, EventArgs e)
        {
            dgvThongKeSLTSP.AutoGenerateColumns = false;
            LoadLoaiSanPham();
            LoadDSSP();
            this.reportViewer1.RefreshReport();
        }

        void LoadDSSoLuongTonSP()
        {
            dgvThongKeSLTSP.DataSource = _ThongKeBUS.ThongKeSoLuongTonSP(txtSoLuongTonSP.Text);
        }
        private void LoadLoaiSanPham()
        {
            lsLoaiDV_DTO = _LoaiDichVuBUS.LayDanhSachLoaiDichVu();
            colLoaiDVThongKe.DataSource = lsLoaiDV_DTO;
            colLoaiDVThongKe.DisplayMember = "TenLoaiDV";
            colLoaiDVThongKe.ValueMember = "MaLoaiDV";
        }
        private void LoadDSSP()
        {
            dgvThongKeSLTSP.DataSource = _DichVuBUS.LayDanhSachDichVu();
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {

            if (txtSoLuongTonSP.Text == string.Empty)
            {
                LoadDSSP();
            }
            else
            {
                LoadDSSoLuongTonSP();
            }
        }

        
    }
}
