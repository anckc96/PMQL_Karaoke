using DevExpress.LookAndFeel;
using QuanlyKARAOKE_BUS;
using QuanlyKARAOKE_DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;

namespace DOAN
{
    public partial class FrmTaiKhoan : Form
    {
        public TaiKhoan_DTO TaiKhoan = new TaiKhoan_DTO();
        List<LoaiTaiKhoan_DTO> lsLoaiTK = new List<LoaiTaiKhoan_DTO>();
        LoaiTaiKhoan_BUS LoaiTK_BUS = new LoaiTaiKhoan_BUS();
        TaiKhoan_BUS tk_BUS = new TaiKhoan_BUS();
        public FrmTaiKhoan()
        {
            InitializeComponent();
            UserLookAndFeel.Default.SetSkinStyle("Office 2013 Light Gray");
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            TaiKhoan_DTO TaiKhoanCN = new TaiKhoan_DTO();
            TaiKhoanCN.MaTaiKhoan = txtMaTK1.Text;
            TaiKhoanCN.TenTaiKhoan = txtTenTK1.Text;
            TaiKhoanCN.MatKhau = Ultils.ToMD5(txtMatKhau1.Text);
            TaiKhoanCN.MaNV = txtMaNV1.Text;
            TaiKhoanCN.LoaiTaiKhoan = cbbLoaiTK.SelectedValue.ToString();
            if (tk_BUS.UpdateTaiKhoan(TaiKhoanCN))
            {
                XtraMessageBox.Show("Cập nhât thành công");
            }
            else
            {
                XtraMessageBox.Show("Cập nhât thất bại");
            }
        }

        private void FrmTaiKhoan_Load(object sender, EventArgs e)
        {
            LoadLoaiTaiKhoan();
            LoadThongTinTaiKhoan();
            if(txtTenTK1.Text != string.Empty)
            {
                btnThem.Visible = false;
                btnLuu.Visible = true;
            }
            else if (txtTenTK1.Text == string.Empty)
            {
                btnThem.Visible = true;
                btnLuu.Visible = false;
            }
        }

        private void LoadThongTinTaiKhoan()
        {
            TaiKhoan_DTO tk = new TaiKhoan_DTO();
            tk = tk_BUS.LayTTTKhoan(TaiKhoan.MaNV);
            if(tk.MaTaiKhoan == null)
            {
                txtMaNV1.Text = TaiKhoan.MaNV;
                txtMaTK1.Text = tk_BUS.LayMaLonNhat();
            }
            else
            {
                txtMaTK1.Text = tk.MaTaiKhoan;
                txtMaNV1.Text = tk.MaNV;
                txtTenTK1.Text = tk.TenTaiKhoan;
                txtMatKhau1.Text = tk.MatKhau;
                cbbLoaiTK.SelectedValue = tk.LoaiTaiKhoan;
            }

        }

        private void LoadLoaiTaiKhoan()
        {
            lsLoaiTK = LoaiTK_BUS.LayDSLoaiTK();

            cbbLoaiTK.DataSource = lsLoaiTK;
            cbbLoaiTK.DisplayMember = "TenMaLoaiTK";
            cbbLoaiTK.ValueMember = "MaLoaiTK";
        }

        private void btnThem_Click_1(object sender, EventArgs e)
        {
            TaiKhoan_DTO TaiKhoanDK = new TaiKhoan_DTO();
            TaiKhoanDK.MaTaiKhoan = txtMaTK1.Text;
            TaiKhoanDK.TenTaiKhoan = txtTenTK1.Text;
            TaiKhoanDK.MatKhau = Ultils.ToMD5(txtMatKhau1.Text);
            TaiKhoanDK.MaNV = txtMaNV1.Text;
            TaiKhoanDK.LoaiTaiKhoan = cbbLoaiTK.SelectedValue.ToString();
            if (tk_BUS.ThemMoiTK(TaiKhoanDK))
            {
                XtraMessageBox.Show("Thêm tài khoản thành công");
            }
            else
            {
                XtraMessageBox.Show("Thêm tài khoản thất bại");
            }
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            DialogResult thoat = XtraMessageBox.Show("Bạn muốn thoát ?","Thông báo",MessageBoxButtons.OKCancel,MessageBoxIcon.Question);
            if(thoat == DialogResult.OK)
            {
                this.Close();
            }
        }

        private void txtMatKhau1_EditValueChanged(object sender, EventArgs e)
        {
            txtMatKhau1.Properties.UseSystemPasswordChar = true;
        }

       
    }
}
