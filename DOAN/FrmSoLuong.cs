using DevExpress.LookAndFeel;
using DevExpress.XtraEditors;
using QuanlyKARAOKE_DTO;
using QuanlyKARAOKE_BUS;
using System;
using System.Windows.Forms;

namespace DOAN
{
    public partial class FrmSoLuong : Form
    {
        public ChiTietHD_DTO chiTietHDChon { get; set; }

        public DichVu_DTO DichVuChon { get; set; }

        public PhongHat_DTO PhongHatChon { get; set; }

        public ChiTietHD_BUS CTHDBus = new ChiTietHD_BUS();

        public DichVu_BUS Dv_BUS = new DichVu_BUS();

        public HoaDon_BUS HoaDonBUS = new HoaDon_BUS();

        public PhongHat_BUS phongHatBUS = new PhongHat_BUS();
     
        public HoaDon_DTO HoaDonChon { get; set; }

        public string MaNVTT { get; set; }

        public string maDichVu { get; set; }

        public LichSuThaoTac_BUS _lichSuThaoTaoBUS = new LichSuThaoTac_BUS();

        public ChiTietHD_DTO chiTietHoaDonDTO = new ChiTietHD_DTO();

        public ChiTietHD_BUS chiTietHoaDonBUS = new ChiTietHD_BUS();

        public FrmSoLuong()
        {
            InitializeComponent();
            UserLookAndFeel.Default.SetSkinStyle("Office 2013 Light Gray");
        }

        private void btnHuySoLuong_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void txtSoLuong1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
            {
                e.Handled = true;
                XtraMessageBox.Show("Số lượng phải là kí tự số ", "Thông Báo ");
                txtSoLuong1.Focus();
            }
        }

        private void FrmSoLuong_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                btnKhachGoiThemDV.PerformClick();
        }

        private void btnKhachGoiThemDV_Click(object sender, EventArgs e)
        {
            if (txtSoLuong1.Text == string.Empty)
            {
                XtraMessageBox.Show("Vui lòng nhập số lượng");
                txtSoLuong1.Focus();
            }
            else
            {
                if (int.Parse(txtSoLuong1.Text) <= 0)
                {
                    XtraMessageBox.Show("Vui lòng nhập số lượng lớn hơn 0");
                    txtSoLuong1.Focus();
                }
                else
                {
                    if (DichVuChon == null || PhongHatChon == null)
                    {
                        if (chiTietHDChon.MaDV != "DV001")
                        {
                            if (int.Parse(txtSoLuong1.Text) > Dv_BUS.LaySoLuongTonTheoMaDV(maDichVu))
                            {
                                XtraMessageBox.Show("Số lượng tồn trong kho không đủ");
                                txtSoLuong1.Focus();
                            }
                            else
                            {
                                CTHDBus.CapNhatDVKhachGoiThem(chiTietHDChon.MaDV, chiTietHDChon.MaHD, Convert.ToInt32(txtSoLuong1.Text));
                                _lichSuThaoTaoBUS.CapNhatThaoTac(MaNVTT, "TT017", "Khách phòng " + HoaDonBUS.LayMaPhong(chiTietHDChon.MaHD) + " gọi món " + Dv_BUS.LayTenDichVuTheoMaDV(chiTietHDChon.MaDV) + " với số lượng " + Convert.ToInt32(txtSoLuong1.Text), DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                this.Close();
                            }
                        }
                    }
                    else
                    {
                        if (int.Parse(txtSoLuong1.Text) > Dv_BUS.LaySoLuongTonTheoMaDV(DichVuChon.MaDV))
                        {
                            XtraMessageBox.Show("Số lượng tồn trong kho không đủ");
                            txtSoLuong1.Focus();
                        }
                        else
                        {
                            if (CTHDBus.KiemTraTonTaiDVTrongHD(DichVuChon.MaDV, HoaDonChon.MaHD) != null)
                            {
                                CTHDBus.CapNhatDVKhachGoiThem(DichVuChon.MaDV, HoaDonChon.MaHD, Convert.ToInt32(txtSoLuong1.Text));
                                _lichSuThaoTaoBUS.CapNhatThaoTac(MaNVTT, "TT017", "Khách " + HoaDonChon.MaPhong + " gọi món " + Dv_BUS.LayTenDichVuTheoMaDV(DichVuChon.MaDV) + " với số lượng " + Convert.ToInt32(txtSoLuong1.Text), DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                this.Close();
                            }
                            else
                            {
                                if (DichVuChon != null && PhongHatChon != null)
                                {
                                    ChiTietHD_DTO CTHD = new ChiTietHD_DTO();
                                    CTHD.MaHD = HoaDonBUS.LayMaHDChuaThanhToan(PhongHatChon.MaPH);
                                    CTHD.MaDV = DichVuChon.MaDV;
                                    CTHD.GiaBan = DichVuChon.DonGiaBan;
                                    CTHD.SoLuong += int.Parse(txtSoLuong1.Text);
                                    if (CTHDBus.KiemTraDVDaXoaTrongHD(CTHD.MaHD, CTHD.MaDV) == null)
                                    {
                                        if (CTHDBus.ThemDichVu(CTHD))
                                        {
                                            FormMain f = new FormMain();
                                            f.ThemDichVu(CTHD, MaNVTT, PhongHatChon.TenPH);
                                            this.Close();
                                        }
                                        else
                                        {
                                            XtraMessageBox.Show("Thêm thất bại", "Thông báo");
                                        }
                                    }
                                    else
                                    {
                                        if (CTHDBus.CapNhatLaiDichVuDaXoa(CTHD))
                                        {
                                            FormMain f = new FormMain();
                                            f.ThemDichVu(CTHD, MaNVTT, PhongHatChon.TenPH);
                                            this.Close();
                                        }
                                        else
                                        {
                                            XtraMessageBox.Show("Thêm thất bại", "Thông báo");
                                        }
                                    }
                                }
                                else
                                {
                                    XtraMessageBox.Show("Bạn chưa chọn phòng", "Thông báo");
                                }
                            }
                        }
                    }
                }
            }
        }

        private void btnKhachTraLaiDV_Click(object sender, EventArgs e)
        {
            if (txtSoLuong1.Text == string.Empty)
            {
                XtraMessageBox.Show("Vui lòng nhập số lượng");
                txtSoLuong1.Focus();
            }
            else
            {
                if (int.Parse(txtSoLuong1.Text) <= 0)
                {
                    XtraMessageBox.Show("Vui lòng nhập số lượng lớn hơn 0");
                    txtSoLuong1.Focus();
                }
                else
                {
                    if (DichVuChon == null || PhongHatChon == null)
                    {
                        if (chiTietHDChon.MaDV != "DV001")
                        {
                            if (chiTietHDChon.SoLuong < Convert.ToInt32(txtSoLuong1.Text))
                            {
                                XtraMessageBox.Show("Số lượng trả lại lớn hơn số lượng đã gọi");
                                txtSoLuong1.Focus();
                            }
                            else if (chiTietHDChon.SoLuong == Convert.ToInt32(txtSoLuong1.Text))
                            {
                                DialogResult dr = XtraMessageBox.Show("Bạn có chắc muốn trả lại toàn bộ?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                                if (dr == DialogResult.Yes)
                                {
                                    chiTietHoaDonBUS.CapNhatDVKhachTraToanBo(chiTietHDChon.MaHD, chiTietHDChon.MaDV);
                                    this.Close();
                                }
                                else
                                {
                                    txtSoLuong1.Focus();
                                }
                            }
                            else
                            {
                                CTHDBus.CapNhatDVKhachTraMon(chiTietHDChon.MaDV, chiTietHDChon.MaHD, Convert.ToInt32(txtSoLuong1.Text));
                                _lichSuThaoTaoBUS.CapNhatThaoTac(MaNVTT, "TT018", "Khách phòng " + HoaDonBUS.LayMaPhong(chiTietHDChon.MaHD) + " trả món " + Dv_BUS.LayTenDichVuTheoMaDV(chiTietHDChon.MaDV) + " với số lượng " + Convert.ToInt32(txtSoLuong1.Text), DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                this.Close();
                            }
                        }
                    }
                    else
                    {
                        chiTietHoaDonDTO = CTHDBus.KiemTraTonTaiDVTrongHD(DichVuChon.MaDV, HoaDonChon.MaHD);
                        if (chiTietHoaDonDTO != null)
                        {
                            if (chiTietHoaDonDTO.SoLuong < Convert.ToInt32(txtSoLuong1.Text))
                            {
                                XtraMessageBox.Show("Số lượng trả lại lớn hơn số lượng đã gọi");
                                txtSoLuong1.Focus();
                            }
                            else if (chiTietHoaDonDTO.SoLuong == Convert.ToInt32(txtSoLuong1.Text))
                            {
                                DialogResult dr = XtraMessageBox.Show("Bạn có chắc muốn trả lại toàn bộ?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                                if (dr == DialogResult.Yes)
                                {
                                    chiTietHoaDonBUS.CapNhatDVKhachTraToanBo(chiTietHoaDonDTO.MaHD, chiTietHoaDonDTO.MaDV);
                                    this.Close();
                                }
                                else
                                {
                                    txtSoLuong1.Focus();
                                }
                            }
                            else
                            {
                                CTHDBus.CapNhatDVKhachTraMon(DichVuChon.MaDV, HoaDonChon.MaHD, Convert.ToInt32(txtSoLuong1.Text));
                                _lichSuThaoTaoBUS.CapNhatThaoTac(MaNVTT, "TT018", "Khách phòng " + HoaDonChon.MaPhong + " trả món " + Dv_BUS.LayTenDichVuTheoMaDV(DichVuChon.MaDV) + " với số lượng " + Convert.ToInt32(txtSoLuong1.Text), DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                this.Close();
                            }
                        }
                        else
                        {
                            XtraMessageBox.Show("Dịch vụ chưa có trong hóa đơn nên không thể trả lại!", "Cảnh báo");
                            txtSoLuong1.Focus();
                        }
                    }
                }
            }
        }
    }
}
