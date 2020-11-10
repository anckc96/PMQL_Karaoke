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
using System.Threading;
using DevExpress.LookAndFeel;
using DevExpress.XtraEditors;

namespace DOAN
{
    public partial class FrmDangNhap : Form
    {
        List<TaiKhoan_DTO> lsTaiKhoan = new List<TaiKhoan_DTO>();
        TaiKhoan_DTO TaiKhoanDTO = new TaiKhoan_DTO();
        Nhanvien_BUS NhanVienBUS = new Nhanvien_BUS();
        TaiKhoan_BUS TaiKhoanBUS = new TaiKhoan_BUS();
        LichSuThaoTac_BUS _LichSuThaoTacBUS = new LichSuThaoTac_BUS();
        public string MaNV { get; set; }

        int dem = 0,thoigiancho=0;
        public FrmDangNhap()
        {
            InitializeComponent();

            UserLookAndFeel.Default.SetSkinStyle("Office 2013 Light Gray");
        }
    

        private void KhoaDangNhap()
        {
            Thread.Sleep(10000);
            this.BeginInvoke((Action)delegate() 
            {
                XtraMessageBox.Show("Bạn đã có thể đăng nhập", "Thông báo");
                hienthi();
            });
        }
      

        private void btndangnhap_Click(object sender, EventArgs e)
        {
            try
            {
                TaiKhoanDTO = new TaiKhoan_DTO();
                TaiKhoanDTO.TenTaiKhoan = txtTaiKhoan.Text;
                TaiKhoanDTO.MatKhau = Ultils.ToMD5(txtMatKhau.Text);
                TaiKhoanDTO.MaNV = TaiKhoanBUS.LayMaNV(TaiKhoanDTO.TenTaiKhoan);
                //FormMain f = new FormMain();
                //f.MaNV = MaNV;
                //f.Dispose();
                if (TaiKhoanBUS.KiemTraDangNhap(TaiKhoanDTO))
                {
                    //NhanVienBUS.CapNhatIPNhanVien(TaiKhoanDTO.MaNV);
                    _LichSuThaoTacBUS.CapNhatThaoTac(TaiKhoanDTO.MaNV, "TT001", null,DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                    this.Hide();
                    TaiKhoan_DTO tkdn = TaiKhoanBUS.LayTTTK(TaiKhoanDTO);
                    FormMain frm = new FormMain();
                    frm.TenNV = TaiKhoanBUS.LayTenNV(TaiKhoanDTO);
                    frm.MaNV = TaiKhoanBUS.LayMaNV(TaiKhoanDTO.TenTaiKhoan);
                    frm.TaiKhoanDN = tkdn;
                    frm.Show();
                }
                else
                {
                     XtraMessageBox.Show("Tài khoản hoặc mật khẩu không đúng", "Thông báo");
                    dem++;
                    if(dem == 3)
                    {
                        XtraMessageBox.Show("Bạn đã nhập sai 3 lần", "Thông báo");
                    }
                    if(dem == 5)
                    {
                        XtraMessageBox.Show("Bạn đã nhập sai 5 lần, bạn không thể đăng nhập trong 10 giây sau", "Thông báo");
                        xoadulieu();
                        Thread thread = new Thread(KhoaDangNhap);
                        thread.Start();
                        dem = 0;
                    }

                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
            

        }

        private void btnshowpassword_Click(object sender, EventArgs e)
        {
          txtMatKhau.Properties.UseSystemPasswordChar = !txtMatKhau.Properties.UseSystemPasswordChar;
        }
        private void xoadulieu()
        {
            txtTaiKhoan.Text = "";
            txtMatKhau.Text = "";
            txtTaiKhoan.Enabled = false;
            txtMatKhau.Enabled = false;
            btndangnhap.Enabled = false;
        }
        private void hienthi()
        {
            txtTaiKhoan.Enabled = true;
            txtMatKhau.Enabled = true;
            btndangnhap.Enabled = true;
        }
        private void timerlogin_Tick(object sender, EventArgs e)
        {
            ngaythanglogin.Text = DateTime.Now.ToString("dd/MM/yyyy      HH:mm:ss");
            thoigiancho += DateTime.Now.Second;
        }

        private void simpleButton1_Click(object sender, EventArgs e)
        {
            if (XtraMessageBox.Show("Bạn có muốn thoát", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                this.Close();
            }
        }

        private void textEdit1_EditValueChanged(object sender, EventArgs e)
        {
            txtMatKhau.Properties.UseSystemPasswordChar = true;
        }

        private void FrmDangNhap_Load(object sender, EventArgs e)
        {
            
        }
    }
}
