using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using DevExpress.XtraBars.Docking2010.Views;
using DevExpress.XtraBars;
using DevExpress.XtraBars.Navigation;
using DevExpress.LookAndFeel;
using QuanlyKARAOKE_BUS;
using QuanlyKARAOKE_DTO;
using System.IO;
using System.Drawing.Printing;
using System.Net;
using System.Threading;
using System.Data.SqlClient;
using Microsoft.Reporting.WinForms;
using System.Drawing.Imaging;

namespace DOAN
{
    public partial class FormMain : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        public string TenNV { get; set; }

        public string MaNV { get; set; }

        public string MaPhongBiChuyen { get; set; }

        public int SoLuongD = 0;

        public string MaHDThanhToan { get; set; }

        public TaiKhoan_DTO TaiKhoanDN = new TaiKhoan_DTO();
        float tien = 0, a, tiengiohat;
        int gio2, phut2, gio3, phut3, SoLuongMonBanDau;
        string PathHA = "DuLieu/NhanVien/";
        string HAPhong = "DuLieu/Phong/PhongTrong.jpg";
        string HAPhongHD = "DuLieu/Phong/PhongDangHD.jpg";
        string HAPhongVIP = "DuLieu/Phong/PhongVipTrong.jpg";
        string HAPhongVIPHD = "DuLieu/Phong/PhongVipDangHD.jpg";
        string HAPhongHat;
        string HAPhongHatHD;
        public int GioBatDau, PhutBatDau;
        string thoigian = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
        public string MaNVTT;
        public string MaHDIn;
        public double tienGioTrenPhut = 0;
        public int tongSoPhutSuDung = 0;
        public int gioMoPhong = 0;
        public int phutMoPhong = 0;

        List<Nhanvien_DTO> lsNV_DTO;
        Nhanvien_BUS NV_BUS = new Nhanvien_BUS();

        List<LoaiNV_DTO> lsLoaiNV_DTO;
        LoaiNV_BUS LoainvBUS = new LoaiNV_BUS();

        List<DichVu_DTO> lsDichVu_DTO = new List<DichVu_DTO>();
        DichVu_BUS Dv_BUS = new DichVu_BUS();

        List<LoaiPhong_DTO> lsLoaiPhong_DTO;
        LoaiPhong_BUS LoaiPhongBUS = new LoaiPhong_BUS();

        List<TinhTrangPH_DTO> lsTTP_DTO;
        TinhTrangPH_BUS TTPhongBUS = new TinhTrangPH_BUS();

        List<PhongHat_DTO> lsPhongHat_DTO;
        PhongHat_BUS PhongHatBUS = new PhongHat_BUS();

        List<LoaiDichVu_DTO> lsLoaiDV_DTO;
        LoaiDichVu_BUS LoaiDichVuBUS = new LoaiDichVu_BUS();

        Nhanvien_DTO NhanVienChon = new Nhanvien_DTO();

        DichVu_DTO DichVuChon = new DichVu_DTO();

        PhongHat_DTO PhongHatChon = new PhongHat_DTO();

        List<ChiTietHD_DTO> lsCTHD = new List<ChiTietHD_DTO>();
        List<ChiTietHD_DTO> lsCTHDTemp = new List<ChiTietHD_DTO>();
        ChiTietHD_DTO ChiTietHD = new ChiTietHD_DTO();
        ChiTietHD_BUS CTHDBus = new ChiTietHD_BUS();

        List<HoaDon_DTO> lsHD = new List<HoaDon_DTO>();
        HoaDon_DTO HoaDon = new HoaDon_DTO();
        HoaDon_BUS HoaDonBUS = new HoaDon_BUS();

        TaiKhoan_BUS TK_BUS = new TaiKhoan_BUS();
        public TaiKhoan_DTO TaiKhoanDTO = new TaiKhoan_DTO();

        List<LoaiTaiKhoan_DTO> lsLoaiTK = new List<LoaiTaiKhoan_DTO>();
        LoaiTaiKhoan_BUS LoaiTK_BUS = new LoaiTaiKhoan_BUS();

        LichSuThaoTac_BUS _LichSuThaoTacBUS = new LichSuThaoTac_BUS();

        ThongKe_BUS _ThongKeBUS = new ThongKe_BUS();

        GioHat_BUS gioHatBUS = new GioHat_BUS();
        GioHat_DTO gioHatDTO = new GioHat_DTO();

        //RealTime----------------------------------------------------------------------
        public string strKetNoiRealTime = @"Data Source=.;Initial Catalog=QLPM_Karaoke;Integrated Security=True";
        SqlConnection conn = null;
        public delegate void LoadNewDataListView();
        public event LoadNewDataListView OnLoadNewDataListView;
        //RealTime----------------------------------------------------------------------
        public FormMain()
        {
            InitializeComponent();
            //Khởi tạo skin mặc định cho FORM Xmas 2008 Blue
            UserLookAndFeel.Default.SetSkinStyle("Office 2013 Light Gray");
            CheckForIllegalCrossThreadCalls = false;

            //RealTime----------------------------------------------------------------------
            try
            {
                SqlClientPermission SCP = new SqlClientPermission(System.Security.Permissions.PermissionState.Unrestricted);
                SCP.Demand();
            }
            catch (Exception)
            {
                throw;
            }
            SqlDependency.Stop(strKetNoiRealTime);
            SqlDependency.Start(strKetNoiRealTime);
            conn = new SqlConnection(strKetNoiRealTime);
            //RealTime----------------------------------------------------------------------
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            lbGioVao.Text = DateTime.Now.ToString("HH:mm:ss");
            dgvQuanLyHoaDon.AutoGenerateColumns = false;
            dgvNhanVien.AutoGenerateColumns = false;
            dgvMenuDV.AutoGenerateColumns = false;
            dgvPhong.AutoGenerateColumns = false;
            dgvDichVu.AutoGenerateColumns = false;
            dgvCTHD.AutoGenerateColumns = false;
            MaNVTT = MaNV;
            rdThongKeDoanhThu.Checked = true;
            rdThongKeDoanhThu_Click(sender, e);
            //RealTime-------------------------------------------------------------------------
            OnLoadNewDataListView += new LoadNewDataListView(Form1_OnLoadNewDataListView);//tab
            LoadDataListViewRealTime();
            //RealTime-------------------------------------------------------------------------
            //RealTime CTHD-------------------------------------------------------------------------
            //OnLoadNewDataCTHD += new LoadNewDataCTHD(Form1_OnLoadNewDataCTHD);//tab
            //LoadDataCTHDRealTime();
            //RealTime CTHD-------------------------------------------------------------------------


            // Load danh sách loại nhân viên
            LoadLoaiNV();

            // Load danh sách nhân viên
            LoadDSNV();

            // Load Menu sản phẩm
            LoadMenuDichVu();

            //Load danh sách loại phòng
            LoadDSLoaiPhong();

            //Load danh sách tình trạng phòng
            LoadDSTinhTrangPhong();

            //Load danh sách tất cả các phòng
            LoadDanhSachPhongHat();

            //Load danh sách sản phẩm trong kho
            LoadDanhSachSanPham();

            //Load loại sản phẩm
            LoadLoaiSanPham();

            //Load tài khoản
            LoadThongTinTaiKhoan();

            //Load loại tài khoản
            LoadLoaiTaiKhoan();

            //Load Danh sách hóa đơn
            LoadDSHoaDon();

            //Chỉnh toàn màn hình thiết bị
            fullscreen();

            LoadDSPhongLenListView();
            dgvCTHD.AutoGenerateColumns = false;
            KiemTraDangNhap();

            //Set màu DataGridView
            dgvNhanVien.RowsDefaultCellStyle.BackColor = Color.LavenderBlush;
            dgvNhanVien.RowsDefaultCellStyle.ForeColor = Color.Black;
            dgvNhanVien.AlternatingRowsDefaultCellStyle.BackColor = Color.Ivory;

            dgvMenuDV.RowsDefaultCellStyle.BackColor = Color.Azure;
            dgvMenuDV.RowsDefaultCellStyle.ForeColor = Color.Black;
            dgvMenuDV.AlternatingRowsDefaultCellStyle.BackColor = Color.Ivory;


            dgvPhong.RowsDefaultCellStyle.BackColor = Color.LavenderBlush;
            dgvPhong.RowsDefaultCellStyle.ForeColor = Color.Black;
            dgvPhong.AlternatingRowsDefaultCellStyle.BackColor = Color.Ivory;

            dgvDichVu.RowsDefaultCellStyle.BackColor = Color.LavenderBlush;
            dgvDichVu.RowsDefaultCellStyle.ForeColor = Color.Black;
            dgvDichVu.AlternatingRowsDefaultCellStyle.BackColor = Color.Ivory;

            dgvQuanLyHoaDon.RowsDefaultCellStyle.BackColor = Color.LavenderBlush;
            dgvQuanLyHoaDon.RowsDefaultCellStyle.ForeColor = Color.Black;
            dgvQuanLyHoaDon.AlternatingRowsDefaultCellStyle.BackColor = Color.Ivory;

            dgvCTHD.RowsDefaultCellStyle.BackColor = Color.Azure;
            dgvCTHD.RowsDefaultCellStyle.ForeColor = Color.Black;
            dgvCTHD.AlternatingRowsDefaultCellStyle.BackColor = Color.Ivory;

            //Ràng buộc Form Quản Lý Nhân Viên
            txtMaTK1.ReadOnly = true;
            txtMaNV.ReadOnly = true;
            txtTenTK1.ReadOnly = true;
            btnThem.Enabled = false;
            btnChangePass.Enabled = false;
            btnSuaNV.Enabled = false;
            SetFalseThayDoiThongTinNhanVien();
            SetTextBoxNhanVienFalse();
            txtGhiChuNhanVien.ReadOnly = true;

            //Ràng buộc Form Quản Lý Phòng
            txtMaPhong.ReadOnly = true;
            btnThemPhong.Enabled = false;
            btnSuaPhong.Enabled = false;
            SetTextBoxPhongHatFalse();
            txtMoTaPhongHat.ReadOnly = true;

            //Ràng buộc Form Quản Lý Sản Phẩm
            txtMaSP.ReadOnly = true;
            btnThemSP.Enabled = false;
            btnSuaSP.Enabled = false;
            SetTextBoxDichVutFalse();
            txtGhiChuDichVu.ReadOnly = true;
            cbbDonViTinh.Enabled = false;

            //Ràng buộc thay đổi mật khẩu
            RangBuocThayDoiMK();
        }

        //Ràng buộc thay đổi thông tin nhân viên
        void SetFalseThayDoiThongTinNhanVien()
        {
            btnSuaNV.Enabled = false;
            btnChangePass.Enabled = false;
        }

        void SetTrueThayDoiThongTinNhanVien()
        {
            btnSuaNV.Enabled = true;
            btnChangePass.Enabled = true;
        }

        //Ràng buộc các trường nhập dữ liệu nhân viên
        void SetTextBoxNhanVienFalse()
        {
            txtHoTen.ReadOnly = true;
            txtDiaChi.ReadOnly = true;
            txtSDT.ReadOnly = true;
            dtpNgaySinh.Enabled = false;
            cbbLoainv.Enabled = false;
            rbtNam.Enabled = false;
            rbtNu.Enabled = false;
            cbbLoaiTK.Enabled = false;
            pbAvatar.Enabled = false;
        }

        void SetTextBoxNhanVienTrue()
        {
            txtHoTen.ReadOnly = false;
            txtDiaChi.ReadOnly = false;
            txtSDT.ReadOnly = false;
            dtpNgaySinh.Enabled = true;
            cbbLoainv.Enabled = true;
            rbtNam.Enabled = true;
            rbtNu.Enabled = true;
            cbbLoaiTK.Enabled = true;
            pbAvatar.Enabled = true;
        }

        //Ràng buộc thay đổi mật khẩu
        private void RangBuocThayDoiMK()
        {
            txtPass.ReadOnly = true;
            txtRePass.ReadOnly = true;
            btnCPass.Enabled = false;
            txtRePass.Text = string.Empty;
            txtPass.Text = string.Empty;
        }

        //Ràng buộc các trường nhập dữ liệu phòng hát
        void SetTextBoxPhongHatFalse()
        {
            txtTenPhong.ReadOnly = true;
            cbbLoaiPhong.Enabled = false;
            cbbTinhTrangPhong.Enabled = false;

        }

        void SetTextBoxPhongHatTrue()
        {
            txtTenPhong.ReadOnly = false;
            cbbLoaiPhong.Enabled = true;
            cbbTinhTrangPhong.Enabled = true;
        }

        //Ràng buộc các trường nhập dữ liệu dịch vụ
        void SetTextBoxDichVutFalse()
        {
            txtTenSP.ReadOnly = true;
            cbbDonViTinh.Enabled = true;
            txtGiaBan.ReadOnly = true;
            txtMoTa.ReadOnly = true;
            txtGiaNhap.ReadOnly = true;
            txtSLT.ReadOnly = true;
            cbbLoaiDV.Enabled = false;
            cbbDonViTinh.Enabled = false;
        }

        void SetTextBoxDichVuTrue()
        {
            txtTenSP.ReadOnly = false;
            cbbDonViTinh.Enabled = false;
            txtGiaBan.ReadOnly = false;
            txtMoTa.ReadOnly = false;
            txtGiaNhap.ReadOnly = false;
            txtSLT.ReadOnly = false;
            cbbLoaiDV.Enabled = true;
            cbbDonViTinh.Enabled = true;
        }

        private void LoadLoaiTaiKhoan()
        {
            lsLoaiTK = LoaiTK_BUS.LayDSLoaiTK();
            cbbLoaiTK.DataSource = lsLoaiTK;
            cbbLoaiTK.DisplayMember = "TenMaLoaiTK";
            cbbLoaiTK.ValueMember = "MaLoaiTK";
        }

        private void LoadThongTinTaiKhoan()
        {
            try
            {
                TaiKhoan_DTO tk = new TaiKhoan_DTO();
                tk = TK_BUS.LayTTTKhoan(NhanVienChon.MaNV);
                if (tk.MaTaiKhoan == null)
                {
                    txtMaTK1.Text = TK_BUS.LayMaLonNhat();
                }
                else
                {
                    txtMaTK1.Text = tk.MaTaiKhoan;
                    txtTenTK1.Text = tk.TenTaiKhoan;
                    cbbLoaiTK.SelectedValue = tk.LoaiTaiKhoan;
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void KiemTraDangNhap()
        {
            try
            {
                if (TaiKhoanDN == null)
                {
                    DialogResult dr = XtraMessageBox.Show("Vui lòng đăng nhập", "Đăng nhập", MessageBoxButtons.YesNo);
                    if (dr == DialogResult.Yes)
                    {
                        FrmDangNhap f = new FrmDangNhap();
                        f.Show();
                    }
                    else
                    {
                        this.Close();
                    }
                }
                else
                {
                    lbTenNhanVien.Text = TenNV;
                    KiemTraQuyen();
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void KiemTraQuyen()
        {
            if (TaiKhoanDN.LoaiTaiKhoan == "LOAITK001") //Admin
            {
                CapNhatBtnKhiChuaMoPhong();
            }
            else   if (TaiKhoanDN.LoaiTaiKhoan == "LOAITK002") // Quản lý
            {
                tabPane1.SelectedPage = frmQLNV;   
                frmMain.PageVisible = false;
            }
            else if (TaiKhoanDN.LoaiTaiKhoan == "LOAITK003") // Kế toán
            {
                tabPane1.SelectedPage = frmThongKe;   
                frmMain.PageVisible = false;
                frmQLNV.PageVisible = false;
                frmQLPhong.PageVisible = false;
                frmThietLap.PageVisible = false;
            }
            else if (TaiKhoanDN.LoaiTaiKhoan == "LOAITK004") // Thu ngân
            {
                CapNhatBtnKhiChuaMoPhong();
                btnInHD.Visible = false;
                btnHuyHDTT.Visible = false;
                frmQLNV.PageVisible = false;
                frmQLPhong.PageVisible = false;
                frmThietLap.PageVisible = false;
                frmQLKho.PageVisible = false;
                frmThongKe.PageVisible = false;
                frmQLHoaDon.PageVisible = false;
            }
            else if (TaiKhoanDN.LoaiTaiKhoan == "LOAITK005") // Phục vụ
            {
                CapNhatBtnKhiChuaMoPhong();
                btntinhtien.Visible = false;
                btnXoaHD.Visible = false;
                frmQLNV.PageVisible = false;
                frmQLPhong.PageVisible = false;
                frmThietLap.PageVisible = false;
                frmQLKho.PageVisible = false;
                frmThongKe.PageVisible = false;
                frmQLHoaDon.PageVisible = false;
            }
        }

        private void CapNhatBtnKhiChuaMoPhong()
        {
            btnADD.Enabled = false;
            btnDelSP.Enabled = false;
            btnMoPhong.Enabled = true;
            btnChuyenPhong.Enabled = false;
            btntinhtien.Enabled = false;
            btnXoaHD.Enabled = false;
            btnInHD.Enabled = false;
            btnHuyHDTT.Enabled = false;
        }

        private void LoadDSPhongLenListView()
        {
            try
            {
                lvwPhong.Clear();
                lsPhongHat_DTO = PhongHatBUS.LayDanhSachPhongHat();
                imlPhong.ColorDepth = ColorDepth.Depth32Bit;
                imlPhong.ImageSize = new Size(120, 120);
                imlPhong.Images.Clear();
                lvwPhong.LargeImageList = imlPhong;
                for (int i = 0; i < lsPhongHat_DTO.Count; i++)
                {
                    ListViewItem lvi = new ListViewItem(lsPhongHat_DTO[i].TenPH);
                    lvi.SubItems.Add(lsPhongHat_DTO[i].MaPH);
                    if (lsPhongHat_DTO[i].LoaiPhong == "LP002")
                    {
                        HAPhongHat = HAPhong;
                        HAPhongHatHD = HAPhongHD;
                    }
                    else
                    {
                        HAPhongHat = HAPhongVIP;
                        HAPhongHatHD = HAPhongVIPHD;

                    }
                    if (File.Exists(HAPhongHat) && lsPhongHat_DTO[i].TinhTrang != "TT002")
                    {
                        byte[] byteHA = File.ReadAllBytes(HAPhongHat);
                        MemoryStream ms = new MemoryStream(byteHA);
                        Image img = Image.FromStream(ms);
                        imlPhong.Images.Add(img);
                        lvi.ImageIndex = imlPhong.Images.Count - 1;
                    }
                    else
                    {
                        byte[] byteHA = File.ReadAllBytes(HAPhongHatHD);
                        MemoryStream ms = new MemoryStream(byteHA);
                        Image img = Image.FromStream(ms);
                        imlPhong.Images.Add(img);
                        lvi.ImageIndex = imlPhong.Images.Count - 1;
                    }
                    lvwPhong.Items.Add(lvi);
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void LoadLoaiSanPham()
        {
            lsLoaiDV_DTO = LoaiDichVuBUS.LayDanhSachLoaiDichVu();

            cbbLoaiDV.DataSource = lsLoaiDV_DTO;
            cbbLoaiDV.DisplayMember = "TenLoaiDV";
            cbbLoaiDV.ValueMember = "MaLoaiDV";

            colLoaiDV.DataSource = lsLoaiDV_DTO;
            colLoaiDV.DisplayMember = "TenLoaiDV";
            colLoaiDV.ValueMember = "MaLoaiDV";
        }

        private void LoadDanhSachSanPham()
        {
            dgvDichVu.DataSource = Dv_BUS.LayDanhSachDichVu();
        }

        private void LoadDanhSachPhongHat()
        {
            lsPhongHat_DTO = PhongHatBUS.LayDSPhongHat();
            dgvPhong.DataSource = lsPhongHat_DTO;
        }

        private void LoadDSTinhTrangPhong()
        {
            TTPhongBUS = new TinhTrangPH_BUS();
            lsTTP_DTO = TTPhongBUS.LayDanhSachTinhTrangPhong();
            cbbTinhTrangPhong.DataSource = lsTTP_DTO;
            cbbTinhTrangPhong.DisplayMember = "TinhTrang";
            cbbTinhTrangPhong.ValueMember = "MaTinhTrang";

            colTinhTrang.DataSource = lsTTP_DTO;
            colTinhTrang.DisplayMember = "TinhTrang";
            colTinhTrang.ValueMember = "MaTinhTrang";
        }

        private void LoadDSLoaiPhong()
        {
            LoaiPhongBUS = new LoaiPhong_BUS();
            lsLoaiPhong_DTO = LoaiPhongBUS.LayDanhSachLoaiPhongHat();
            cbbLoaiPhong.DataSource = lsLoaiPhong_DTO;
            cbbLoaiPhong.DisplayMember = "TenPhong";
            cbbLoaiPhong.ValueMember = "MaLoai";


            colLoaiPhong.DataSource = lsLoaiPhong_DTO;
            colLoaiPhong.DisplayMember = "TenPhong";
            colLoaiPhong.ValueMember = "MaLoai";
        }

        private void LoadMenuDichVu()
        {
            lsDichVu_DTO = Dv_BUS.LayDanhSachDichVu();
            dgvMenuDV.DataSource = lsDichVu_DTO;
        }

        private void LoadDSNV()
        {
            lsNV_DTO = NV_BUS.LayDSnhanven();
            dgvNhanVien.DataSource = lsNV_DTO;
        }

        private void LoadLoaiNV()
        {
            LoainvBUS = new LoaiNV_BUS();
            lsLoaiNV_DTO = LoainvBUS.LayLoaiNV();
            cbbLoainv.DataSource = lsLoaiNV_DTO;
            cbbLoainv.DisplayMember = "ChucVu";
            cbbLoainv.ValueMember = "MaLoaiNV";

            colloainv.DataSource = lsLoaiNV_DTO;
            colloainv.DisplayMember = "ChucVu";
            colloainv.ValueMember = "MaLoaiNV";
        }

        private void dgvMenuDV_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {
            for (int i = 0; i < dgvMenuDV.Rows.Count; i++)
            {
                //Lấy giá trị tăng dần dgvMenuDV[0,1] : 0 là cột, 1 là hàng
                dgvMenuDV[0, i].Value = (i < 9) ? "0" + (i + 1) : "" + (i + 1);
            }
        }

        private void dgvNhanVien_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvNhanVien.SelectedRows.Count > 0)
            {
                cbbLoainv.SelectionLength = 0;
                NhanVienChon = (Nhanvien_DTO)dgvNhanVien.CurrentRow.DataBoundItem;
                TaiKhoanDTO = TK_BUS.LayTTTKhoan(NhanVienChon.MaNV);
                txtTenTK1.ReadOnly = true;
                txtGhiChuNhanVien.ReadOnly = true;
                txtGhiChuNhanVien.Clear();
                btnXoaNV.Enabled = true;
                btnThem.Enabled = false;
                btnLamMoi.Enabled = true;
                btnSuaNV.Enabled = false;
                btnChangePass.Enabled = false;
                btnSuaThongTinNV.Enabled = true;
                SetTextBoxNhanVienFalse();
            }
            else
            {
                NhanVienChon = null;
                TaiKhoanDTO = null;
            }
            HienThiChiTietNhanVien();
        }

        private void HienThiChiTietNhanVien()
        {
            if (NhanVienChon != null)
            {
                RangBuocThayDoiMK();
                txtMaNV.Text = NhanVienChon.MaNV;
                txtHoTen.Text = NhanVienChon.HoTenNV;
                txtSDT.Text = NhanVienChon.DienThoai;
                txtDiaChi.Text = NhanVienChon.DiaChi;
                cbbLoainv.SelectedValue = NhanVienChon.LoaiNV;
                if (NhanVienChon.GioiTinh == "Nam")
                    rbtNam.Checked = true;
                else
                    rbtNu.Checked = true;
                dtpNgaySinh.Value = NhanVienChon.NgaySinh;
                if (File.Exists(NhanVienChon.HinhAnhNV))
                {
                    byte[] HA = File.ReadAllBytes(NhanVienChon.HinhAnhNV);
                    MemoryStream ms = new MemoryStream(HA);
                    pbAvatar.Image = Image.FromStream(ms);

                }
                else
                {
                    pbAvatar.Image = null;
                }
                LoadThongTinTaiKhoan();
            }
            else
            {
                txtMaNV.Text = "";
                txtHoTen.Text = "";
                txtSDT.Text = "";
                txtDiaChi.Text = "";
                cbbLoainv.SelectedValue = -1;
                rbtNam.Checked = false;
                rbtNu.Checked = false;
                dtpNgaySinh.Value = DateTime.Now;
                pbAvatar.Image = null;
            }
        }
        private void dgvDichVu_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                if (dgvDichVu.SelectedRows.Count > 0)
                {
                    DichVuChon = (DichVu_DTO)dgvDichVu.CurrentRow.DataBoundItem;
                    btnLamMoiSP.Enabled = true;
                    btnSuaThongTinDichVu.Enabled = true;
                    btnXoaSP.Enabled = true;
                    btnThemSP.Enabled = false;
                    btnSuaSP.Enabled = false;
                    txtGhiChuDichVu.ReadOnly = true;
                    txtGhiChuDichVu.Clear();
                    SetTextBoxDichVutFalse();
                    cbbDonViTinh.Enabled = false;
                }
                else
                    DichVuChon = null;
                HienThiChiTietDichVu();
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void HienThiChiTietDichVu()
        {
            if (DichVuChon != null)
            {
                txtMaSP.Text = DichVuChon.MaDV;
                txtTenSP.Text = DichVuChon.TenDV;
                cbbDonViTinh.Text = DichVuChon.DonViTinh;
                txtGiaNhap.Text = DichVuChon.DonGiaBanHienTai.ToString();
                txtGiaBan.Text = DichVuChon.DonGiaBan.ToString();
                txtSLT.Text = DichVuChon.SoLuong.ToString();
                txtMoTa.Text = DichVuChon.MoTa;
                cbbLoaiDV.SelectedValue = DichVuChon.MaLoaiDV;
            }
            else
            {
                txtMaSP.Text = "";
                txtTenSP.Text = "";
                cbbDonViTinh.SelectedIndex = -1;
                txtGiaNhap.Text = "0";
                txtGiaBan.Text = "0";
                txtSLT.Text = "0";
                txtMoTa.Text = "";
                cbbLoaiDV.SelectedValue = -1;
            }
        }

        private void dgvHoaDon_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {
            for (int i = 0; i < dgvCTHD.Rows.Count; i++)
            {
                dgvCTHD[0, i].Value = (i < 9) ? "0" + (i + 1) : "" + (i + 1);
            }
        }

        private bool KiemTraTonTaiDVTrongHD(DataGridViewRow DongThemMoi)
        {
            for (int i = 0; i < dgvCTHD.Rows.Count; i++)
            {
                if (DongThemMoi.Cells[1].Value == dgvCTHD.Rows[i].Cells[1].Value)
                    return true;
            }
            return false;
        }

        private void dgvPhong_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvPhong.SelectedRows.Count > 0)
            {
                PhongHatChon = (PhongHat_DTO)dgvPhong.CurrentRow.DataBoundItem;
                SetTextBoxPhongHatFalse();
                btnThemPhong.Enabled = false;
                txtMoTaPhongHat.ReadOnly = true;
                txtMoTaPhongHat.Clear();
                btnSuaThongTinPhong.Enabled = true;
                btnSuaPhong.Enabled = false;
                btnXoaPhong.Enabled = true;
                btnLamMoiPhong.Enabled = true;
            }
            else
            {
                PhongHatChon = null;
            }
            HienThiChiTietPhongHat();
        }

        private void HienThiChiTietPhongHat()
        {
            if (PhongHatChon != null)
            {
                txtMaPhong.Text = PhongHatChon.MaPH;
                txtTenPhong.Text = PhongHatChon.TenPH;
                txtMoTaPhongHat.Text = PhongHatChon.MoTa;
                cbbLoaiPhong.SelectedValue = PhongHatChon.LoaiPhong;
                cbbTinhTrangPhong.SelectedValue = PhongHatChon.TinhTrang;

            }
            else
            {
                txtMaPhong.Text = "";
                txtTenPhong.Text = "";
                cbbLoaiPhong.SelectedValue = -1;
                cbbTinhTrangPhong.SelectedValue = -1;
            }
        }

        private void GetDataChiTietNhanVien()
        {
            if (NhanVienChon == null)
            {
                NhanVienChon = new Nhanvien_DTO();
            }
            NhanVienChon.MaNV = txtMaNV.Text;
            NhanVienChon.HoTenNV = txtHoTen.Text;
            NhanVienChon.NgaySinh = Convert.ToDateTime(dtpNgaySinh.Value.ToShortDateString());
            if (rbtNam.Checked)
                NhanVienChon.GioiTinh = "Nam";
            else
                NhanVienChon.GioiTinh = "Nữ";
            NhanVienChon.DienThoai = txtSDT.Text;
            NhanVienChon.DiaChi = txtDiaChi.Text;
            NhanVienChon.HinhAnhNV = PathHA + "NV005.jpg";
            NhanVienChon.LoaiNV = cbbLoainv.SelectedValue.ToString();
        }

        // Làm mới form Quản lý Nhân Viên
        private void btnLamMoi_Click(object sender, EventArgs e)
        {
            btnThem.Enabled = true;
            dgvNhanVien.ClearSelection();
            txtMaNV.Text = NV_BUS.LayMaNVTiepTheo();
            txtMaTK1.Text = TK_BUS.LayMaLonNhat();
            cbbLoaiTK.SelectedIndex = 0;
            cbbLoainv.SelectedIndex = 0;
            rbtNam.Checked = true;
            txtTenTK1.ReadOnly = false;
            txtTenTK1.Text = string.Empty;
            btnSuaNV.Enabled = false;
            btnXoaNV.Enabled = false;
            btnLamMoi.Enabled = false;
            btnSuaThongTinNV.Enabled = false;
            txtPass.ReadOnly = true;
            txtRePass.ReadOnly = true;
            txtPass.Text = string.Empty;
            txtRePass.Text = string.Empty;
            btnChangePass.Enabled = false;
            btnCPass.Enabled = false;
            SetTextBoxNhanVienTrue();
        }

        //Thêm nhân viên
        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                if (NhanVienChon == null)
                {
                    if (txtHoTen.Text == string.Empty || txtSDT.Text == string.Empty || txtDiaChi.Text == string.Empty || txtTenTK1.Text == string.Empty)
                    {
                        XtraMessageBox.Show("Vui lòng điền đầy đủ các trường");
                    }
                    else
                    {
                        if (txtSDT.Text.Length > 10 || txtSDT.Text.Length <= 9)
                        {
                            XtraMessageBox.Show("Số điện thoại bắt buộc 10 số");
                        }
                        else
                        {
                            GetDataChiTietNhanVien();
                            GetThongTinTaiKhoan();
                            if (NV_BUS.ThemNhanVien(NhanVienChon) && TK_BUS.ThemMoiTK(TaiKhoanDTO))
                            {
                                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT006", "Thêm mới nhân viên " + NhanVienChon.MaNV, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                if (pbAvatar.Image != null)
                                {
                                    pbAvatar.Image.Save(NhanVienChon.HinhAnhNV);
                                }
                                XtraMessageBox.Show("Thêm mới thành công", "Thông báo");
                                btnThem.Enabled = false;
                                txtTenTK1.ReadOnly = true;
                                SetTextBoxNhanVienFalse();
                                LoadDSNV();
                            }
                            else
                            {
                                XtraMessageBox.Show("Thêm mới thất bại", "Thông báo");
                                NhanVienChon = null;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show(ex.ToString());
            }
        }

        private void GetThongTinTaiKhoan()
        {
            TaiKhoanDTO = new TaiKhoan_DTO();
            TaiKhoanDTO.MaTaiKhoan = txtMaTK1.Text;
            TaiKhoanDTO.TenTaiKhoan = txtTenTK1.Text;
            TaiKhoanDTO.MatKhau = Ultils.ToMD5(txtMaNV.Text);
            TaiKhoanDTO.MaNV = txtMaNV.Text;
            TaiKhoanDTO.LoaiTaiKhoan = cbbLoaiTK.SelectedValue.ToString();
        }

        //Xóa nhân viên. Update TrangThai = 1;
        private void btnXoaNV_Click(object sender, EventArgs e)
        {
            try
            {
                Nhanvien_DTO nv = dgvNhanVien.CurrentRow.DataBoundItem as Nhanvien_DTO;
                DialogResult a = XtraMessageBox.Show("Bạn có muốn chắc chắn xóa nhân viên này!", "Cảnh cáo!", MessageBoxButtons.YesNo);
                if (a == DialogResult.Yes)
                {
                    if (TK_BUS.KiemTraCoPhaiLaTKAdmin(nv))
                    {
                        if (TK_BUS.KiemTraCoPhaiLaAdminCC() == 1)
                        {
                            XtraMessageBox.Show("Không được xóa nhân viên admin cuối cùng này", "Thông báo");
                        }
                        else
                        {
                            if (NV_BUS.XoaNVDuocChon(nv))
                            {
                                TK_BUS.XoaTaiKhoan(nv);
                                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT012", "Xóa nhân viên " + NhanVienChon.MaNV, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                XtraMessageBox.Show("Xóa thành công", "Thông báo");
                                LoadDSNV();
                            }
                        }
                    }
                    else
                    {
                        if (NV_BUS.XoaNVDuocChon(nv))
                        {
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT007", "Xóa nhân viên " + NhanVienChon.MaNV, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            TK_BUS.XoaTaiKhoan(nv);
                            XtraMessageBox.Show("Xóa thành công", "Thông báo");
                            LoadDSNV();
                        }
                    }
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        //Cập nhật nhân viên
        private void btnSuaNV_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtHoTen.Text == string.Empty || txtSDT.Text == string.Empty || txtDiaChi.Text == string.Empty || txtTenTK1.Text == string.Empty)
                {
                    XtraMessageBox.Show("Vui lòng điền đầy đủ các trường");
                }
                else
                {
                    if (txtSDT.Text.Length > 10 || txtSDT.Text.Length <= 9)
                    {
                        XtraMessageBox.Show("Số điện thoại bắt buộc 10 số");
                        txtSDT.Focus();
                    }
                    else
                    {
                        SuaThongTinNhanVien();
                        SetTextBoxNhanVienFalse();
                    }
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        public void SuaThongTinNhanVien()
        {
            try
            {
                //Nhân viên được cập nhật
                Nhanvien_DTO NhanVienCapNhat = new Nhanvien_DTO();
                NhanVienCapNhat.MaNV = txtMaNV.Text;
                NhanVienCapNhat.HoTenNV = txtHoTen.Text;
                NhanVienCapNhat.DienThoai = txtSDT.Text;
                NhanVienCapNhat.DiaChi = txtDiaChi.Text;
                NhanVienCapNhat.LoaiNV = cbbLoainv.SelectedValue.ToString();
                if (rbtNam.Checked)
                    NhanVienCapNhat.GioiTinh = "Nam";
                else
                    NhanVienCapNhat.GioiTinh = "Nữ";
                NhanVienCapNhat.HinhAnhNV = PathHA + NhanVienChon.MaNV + ".jpg";
                NhanVienCapNhat.NgaySinh = Convert.ToDateTime(dtpNgaySinh.Value.ToShortDateString());

                //Tài khoản của nhân viên được cập nhật
                TaiKhoan_DTO TaiKhoanCN = new TaiKhoan_DTO();
                TaiKhoanCN.MaTaiKhoan = txtMaTK1.Text;
                TaiKhoanCN.TenTaiKhoan = txtTenTK1.Text;
                TaiKhoanCN.MaNV = txtMaNV.Text;
                TaiKhoanCN.LoaiTaiKhoan = cbbLoaiTK.SelectedValue.ToString();
                if (NhanVienChon.LoaiNV != NhanVienCapNhat.LoaiNV || TaiKhoanDTO.LoaiTaiKhoan != TaiKhoanCN.LoaiTaiKhoan)
                {
                    if (txtGhiChuNhanVien.Text == string.Empty)
                    {
                        XtraMessageBox.Show("BẮT BUỘC thêm lý do cập nhật nhân viên " + NhanVienChon.MaNV + " tại ô GHI CHÚ!");
                        txtGhiChuNhanVien.Focus();
                    }
                    else
                    {
                        if (NV_BUS.CapNhatNhanVien(NhanVienCapNhat) && TK_BUS.UpdateTaiKhoan(TaiKhoanCN))
                        {
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT014", txtGhiChuNhanVien.Text, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            if (pbAvatar.Image != null)
                            {
                                pbAvatar.Image.Save(NhanVienCapNhat.HinhAnhNV);
                            }
                            XtraMessageBox.Show("Cập nhật thành công nhân viên mã " + NhanVienCapNhat.MaNV);
                            txtGhiChuNhanVien.Clear();
                            txtGhiChuNhanVien.ReadOnly = true;
                            LoadDSNV();
                        }
                    }
                }
                else
                {
                    if (NV_BUS.CapNhatNhanVien(NhanVienCapNhat) && TK_BUS.UpdateTaiKhoan(TaiKhoanCN))
                    {
                        _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT013", txtGhiChuNhanVien.Text, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                        XtraMessageBox.Show("Cập nhật thành công nhân viên mã " + NhanVienCapNhat.MaNV);
                        txtGhiChuNhanVien.Clear();
                        txtGhiChuNhanVien.ReadOnly = true;
                        LoadDSNV();
                    }
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        // Làm mới phòng để thêm mới phòng
        private void btnLamMoiPhong_Click(object sender, EventArgs e)
        {
            try
            {
                btnThemPhong.Enabled = true;
                btnSuaThongTinPhong.Enabled = false;
                btnSuaPhong.Enabled = false;
                btnXoaPhong.Enabled = false;
                btnLamMoiPhong.Enabled = false;
                dgvPhong.ClearSelection();
                txtMaPhong.Text = PhongHatBUS.LayMaPhongTiepTheo();
                SetTextBoxPhongHatTrue();
                cbbLoaiPhong.SelectedIndex = 0;
                cbbTinhTrangPhong.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex);
            }
        }

        //Thêm mới phòng
        private void btnThemPhong_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtTenPhong.Text == string.Empty || txtMoTaPhongHat.Text == string.Empty)
                {
                    XtraMessageBox.Show("Vui lòng không để trống các trường");
                }
                else
                {
                    PhongHat_DTO ph = new PhongHat_DTO();
                    ph.MaPH = txtMaPhong.Text;
                    ph.TenPH = txtTenPhong.Text;
                    ph.MoTa = txtMoTaPhongHat.Text;
                    ph.LoaiPhong = cbbLoaiPhong.SelectedValue.ToString();
                    ph.TinhTrang = cbbTinhTrangPhong.SelectedValue.ToString();

                    if (PhongHatBUS.ThemPhongHat(ph))
                    {
                        XtraMessageBox.Show("Thêm mới thành công", "Thông báo");
                        _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT010", "Thêm phòng hát mới" + ph.TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                        LoadDSPhongLenListView();
                    }
                    else
                    {
                        XtraMessageBox.Show("Thêm mới thất bại", "Thông báo");
                    }
                    SetTextBoxPhongHatFalse();
                    btnThemPhong.Enabled = false;
                    btnSuaThongTinPhong.Enabled = true;
                    btnXoaPhong.Enabled = true;
                    btnLamMoiPhong.Enabled = true;
                    LoadDanhSachPhongHat();
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }

        }

        //Cập nhật thông tin phòng
        private void btnSuaPhong_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult a = XtraMessageBox.Show("Bạn có muốn chắc chắn sửa phòng này!", "Cảnh cáo!", MessageBoxButtons.YesNo);
                if ((a == DialogResult.Yes))
                {

                    if (PhongHatChon.TinhTrang == "TT002")
                    {
                        XtraMessageBox.Show("Phòng đang sử dụng không thể sửa!", "Error!", MessageBoxButtons.OK);
                    }
                    else
                    {
                        PhongHat_DTO ph = new PhongHat_DTO();
                        ph.MaPH = txtMaPhong.Text;
                        ph.TenPH = txtTenPhong.Text;
                        ph.MoTa = txtMoTaPhongHat.Text;
                        ph.LoaiPhong = cbbLoaiPhong.SelectedValue.ToString();
                        ph.TinhTrang = cbbTinhTrangPhong.SelectedValue.ToString();
                        if (PhongHatBUS.CapNhatPhong(ph))
                        {
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT009", txtMoTaPhongHat.Text, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            txtMoTaPhongHat.Clear();
                            txtMoTaPhongHat.ReadOnly = true;
                            SetTextBoxPhongHatFalse();
                            btnSuaPhong.Enabled = false;
                            LoadDanhSachPhongHat();
                            LoadDSPhongLenListView();
                        }
                    }
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        // Xóa phòng
        private void btnXoaPhong_Click(object sender, EventArgs e)
        {
            try
            {
                PhongHat_DTO ph = dgvPhong.CurrentRow.DataBoundItem as PhongHat_DTO;
                DialogResult a = XtraMessageBox.Show("Bạn có muốn chắc chắn xóa phòng này!", "Cảnh cáo!", MessageBoxButtons.YesNo);
                if (a == DialogResult.Yes)
                {
                    if (ph.TinhTrang == "TT002")
                    {
                        XtraMessageBox.Show("Phòng đang sử dụng không thể xóa!", "Error!", MessageBoxButtons.OK);
                    }
                    else
                    {
                        if (PhongHatBUS.XoaPhongDuocChon(ph))
                        {
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT011",MaNVTT + " xóa " + PhongHatChon.TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            LoadDanhSachPhongHat();
                            LoadDSPhongLenListView();
                        }
                    }

                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        //Làm mới sản phẩm
        private void btnLamMoiSP_Click(object sender, EventArgs e)
        {
            SetTextBoxDichVuTrue();
            btnThemSP.Enabled = true;
            btnLamMoiSP.Enabled = false;
            btnSuaThongTinDichVu.Enabled = false;
            btnXoaSP.Enabled = false;
            btnSuaSP.Enabled = false;
            cbbDonViTinh.Enabled = true;
            dgvDichVu.ClearSelection();
            txtMaSP.Text = Dv_BUS.LayDichVuTiepTheo();
        }

        //Thêm sản phẩm
        private void btnThemSP_Click(object sender, EventArgs e)
        {
            try
            {
                DichVu_DTO dv = new DichVu_DTO();
                dv.MaDV = txtMaSP.Text;
                dv.TenDV = txtTenSP.Text;
                dv.DonViTinh = cbbDonViTinh.Text;
                dv.DonGiaBanHienTai = int.Parse(txtGiaNhap.Text);
                dv.DonGiaBan = int.Parse(txtGiaBan.Text);
                dv.SoLuong = int.Parse(txtSLT.Text);
                dv.MoTa = txtMoTa.Text;
                dv.MaLoaiDV = cbbLoaiDV.SelectedValue.ToString();
                if (Dv_BUS.KiemTraTT(txtTenSP.Text))
                {
                    MessageBox.Show("Dịch vụ đã có trong kho");
                }
                else
                {
                    if (Dv_BUS.ThemDichVu(dv))
                    {
                        XtraMessageBox.Show("Thêm sản phẩm thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        btnThemSP.Enabled = false;
                        btnLamMoiSP.Enabled = true;
                        btnSuaThongTinDichVu.Enabled = true;
                        btnXoaSP.Enabled = true;
                        SetTextBoxDichVutFalse();
                        LoadDanhSachSanPham();
                        LoadMenuDichVu();
                    }
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        // Cập nhật thông tin dịch vu
        private void btnSuaSP_Click(object sender, EventArgs e)
        {
            try
            {
                DichVu_DTO dv = new DichVu_DTO();
                dv.MaDV = txtMaSP.Text;
                dv.TenDV = txtTenSP.Text;
                dv.DonViTinh = cbbDonViTinh.Text;
                dv.DonGiaBanHienTai = int.Parse(txtGiaNhap.Text);
                dv.DonGiaBan = int.Parse(txtGiaBan.Text);
                dv.SoLuong = int.Parse(txtSLT.Text);
                dv.MoTa = txtMoTa.Text;
                dv.MaLoaiDV = cbbLoaiDV.SelectedValue.ToString();

                if (DichVuChon.SoLuong != dv.SoLuong || DichVuChon.DonGiaBanHienTai != dv.DonGiaBanHienTai)
                {
                    if (txtGhiChuDichVu.Text == string.Empty)
                    {
                        XtraMessageBox.Show("Bạn vừa sửa GIÁ BÁN hoặc SỐ LƯỢNG. Vui lòng ghi lý do tại ô GHI CHÚ DỊCH VỤ", "Thông báo");
                        txtGhiChuDichVu.Focus();
                    }
                    else
                    {
                        if (DichVuChon.SoLuong != dv.SoLuong)
                        {
                            if (Dv_BUS.CapNhatDichVu(dv))
                            {
                                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT004", txtGhiChuDichVu.Text, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                XtraMessageBox.Show("Sửa sản phẩm thành công", "Thông báo");
                                txtGhiChuDichVu.Clear();
                                txtGhiChuDichVu.ReadOnly = true;
                                SetTextBoxDichVutFalse();
                                LoadDanhSachSanPham();
                                LoadMenuDichVu();
                            }
                            else if (DichVuChon.DonGiaBanHienTai != dv.DonGiaBanHienTai)
                            {
                                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT005", txtGhiChuDichVu.Text, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                XtraMessageBox.Show("Sửa sản phẩm thành công", "Thông báo");
                                txtGhiChuDichVu.Clear();
                                txtGhiChuDichVu.ReadOnly = true;
                                SetTextBoxDichVutFalse();
                                LoadDanhSachSanPham();
                                LoadMenuDichVu();
                            }
                        }
                    }
                }
                else
                {
                    if (Dv_BUS.CapNhatDichVu(dv))
                    {
                        XtraMessageBox.Show("Sửa sản phẩm thành công", "Thông báo");
                        txtGhiChuDichVu.Clear();
                        txtGhiChuDichVu.ReadOnly = true;
                        SetTextBoxDichVutFalse();
                        LoadDanhSachSanPham();
                        LoadMenuDichVu();
                    }
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        //Xóa dịch vụ
        private void btnXoaSP_Click(object sender, EventArgs e)
        {
            try
            {
                DichVu_DTO dv = dgvDichVu.CurrentRow.DataBoundItem as DichVu_DTO;
                DialogResult a = XtraMessageBox.Show("Bạn có muốn chắc chắn xóa phòng này!", "Cảnh cáo!", MessageBoxButtons.YesNo);
                if (a == DialogResult.Yes)
                {
                    if (Dv_BUS.XoaDVDuocChon(dv))
                    {
                        LoadDanhSachSanPham();
                        LoadMenuDichVu();
                    }
                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        private void btnDangXuat_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (XtraMessageBox.Show("Bạn có muốn đăng xuất", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                //NV_BUS.CapNhatIPNhanVienKhiDangXuat(MaNV);
                this.Hide();
                FrmDangNhap frm = new FrmDangNhap();
                frm.Show();
            }
        }

        private void fullscreen()
        {
            int w = Screen.PrimaryScreen.Bounds.Width;
            int h = Screen.PrimaryScreen.Bounds.Height;
            this.Location = new Point(0, 0);
            this.Size = new Size(w, h);
        }
        
        private void timer_Tick(object sender, EventArgs e)
        {
            ngaythang.Text = DateTime.Now.ToString("dd/MM/yyyy      HH:mm:ss");
        }

        private void HienThiNhanVienTimKiem()
        {
            if (NhanVienChon != null)
            {
                txtMaNV.Text = NhanVienChon.MaNV;
                txtHoTen.Text = NhanVienChon.HoTenNV;
                dtpNgaySinh.Text = NhanVienChon.NgaySinh.ToString();
                if (NhanVienChon.GioiTinh == "Nam")
                {
                    rbtNam.Checked = true;
                }
                else
                {
                    rbtNu.Checked = true;
                }
                txtSDT.Text = NhanVienChon.DienThoai;
                txtDiaChi.Text = NhanVienChon.DiaChi;
                cbbLoainv.SelectedValue = NhanVienChon.LoaiNV;

                if (File.Exists(NhanVienChon.HinhAnhNV))
                {
                    byte[] HA = File.ReadAllBytes(NhanVienChon.HinhAnhNV);
                    MemoryStream ms = new MemoryStream(HA);
                    pbAvatar.Image = Image.FromStream(ms);
                }
                else
                {
                    pbAvatar.Image = null;
                }
            }
        }
        private void HienThiPhongHatTimKiem()
        {
            if (PhongHatChon != null)
            {
                txtMaPhong.Text = PhongHatChon.MaPH;
                txtTenPhong.Text = PhongHatChon.TenPH;
                cbbLoaiPhong.SelectedValue = PhongHatChon.LoaiPhong;
                cbbTinhTrangPhong.SelectedValue = PhongHatChon.TinhTrang;
            }
        }
        private void HienThiSanPhamTimKiem()
        {
            if (DichVuChon != null)
            {
                txtMaSP.Text = DichVuChon.MaDV;
                txtTenSP.Text = DichVuChon.TenDV;
                cbbDonViTinh.SelectedValue = DichVuChon.DonViTinh.ToString();
                txtGiaNhap.Text = DichVuChon.DonGiaBanHienTai.ToString();
                txtGiaBan.Text = DichVuChon.DonGiaBan.ToString();
                txtSLT.Text = DichVuChon.SoLuong.ToString();
                txtMoTa.Text = DichVuChon.MoTa;
                cbbLoaiDV.SelectedValue = DichVuChon.MaLoaiDV;
            }
        }

        private void pbAvatar_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog ofd = new OpenFileDialog();
                ofd.Multiselect = false;
                ofd.Filter = "Hình ảnh | *.png; *.jpg";
                DialogResult dr = ofd.ShowDialog();
                if (dr == DialogResult.Cancel)
                {
                    pbAvatar.Image = null;
                }
                else
                {
                    byte[] HA = File.ReadAllBytes(ofd.FileName);
                    MemoryStream ms = new MemoryStream(HA);
                    pbAvatar.Image = Image.FromStream(ms);
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void btnThongKe_Click(object sender, EventArgs e)
        {
            if (rdThongKeDoanhThu.Checked)
            {
                if (cbbThongKeDoanhThu.SelectedItem == "Doanh thu theo ngày")
                {
                    FrmReportThongKeDoanhThuTheoNgay frmReportDoanhThuTheoNgay = new FrmReportThongKeDoanhThuTheoNgay();
                    frmReportDoanhThuTheoNgay.Dock = DockStyle.Fill;
                    frmReportDoanhThuTheoNgay.Show();

                }
                else if (cbbThongKeDoanhThu.SelectedItem == "Doanh thu theo tháng")
                {
                    FrmReportThongKeDoanhThuTheoThang frmReportDoanhThuTheoThang = new FrmReportThongKeDoanhThuTheoThang();
                    frmReportDoanhThuTheoThang.Dock = DockStyle.Fill;
                    frmReportDoanhThuTheoThang.Show();
                }
                else if (cbbThongKeDoanhThu.SelectedItem == "Doanh thu từ ngày đến ngày")
                {
                    FrmReportThongKeDoanhThu frmReportDoanhThu = new FrmReportThongKeDoanhThu();
                    frmReportDoanhThu.Dock = DockStyle.Fill;
                    frmReportDoanhThu.Show();
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn thống kê");
                }
            }
            else if(rdThongkeSoLuongSPBan.Checked)
            {
                if (cbbThongKeSoLuongSanPhamBan.SelectedItem == "SL sản phẩm bán theo ngày")
                {
                    FrmReportSoLuongSPBanTrongNgay frmReportSoLuongSPBanTrongNgay = new FrmReportSoLuongSPBanTrongNgay();
                    frmReportSoLuongSPBanTrongNgay.Dock = DockStyle.Fill;
                    frmReportSoLuongSPBanTrongNgay.Show();
                }
                else if (cbbThongKeSoLuongSanPhamBan.SelectedItem == "SL sản phẩm bán theo tháng")
                {
                    FrmReportSoLuongSPBanTrongThang frmReportSoLuongSPBanTrongThang = new FrmReportSoLuongSPBanTrongThang();
                    frmReportSoLuongSPBanTrongThang.Dock = DockStyle.Fill;
                    frmReportSoLuongSPBanTrongThang.Show();
                }
                else if (cbbThongKeSoLuongSanPhamBan.SelectedItem == "SL sản phẩm bán từ ngày đến ngày")
                {
                    FrmReportSoLuongSPBan frmReportSoLuongSPBan = new FrmReportSoLuongSPBan();
                    frmReportSoLuongSPBan.Dock = DockStyle.Fill;
                    frmReportSoLuongSPBan.Show();
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn thống kê");
                }
            }
            else if(rdThongKeSLTSanPham.Checked)
            {
                if (cbbThongKeSoLuongTonSP.SelectedItem == "Số lượng tồn SP từ ngày đến ngày")
                {
                    frmThongKeSoLuongTonSP frmReportSLTon = new frmThongKeSoLuongTonSP();
                    frmReportSLTon.Dock = DockStyle.Fill;
                    frmReportSLTon.Show();
                }
                else if(cbbThongKeSoLuongTonSP.SelectedItem == "Tần suất sử dụng phòng")
                {
                    FrmReportTanSuatSuDungPhong frm = new FrmReportTanSuatSuDungPhong();
                    frm.Dock = DockStyle.Fill;
                    frm.Show();
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn thống kê");
                }
            }
        }
        //
     
        private void btnADD_Click(object sender, EventArgs e)
        {
            try
            {
                var frmSL = new FrmSoLuong();
                frmSL.Location = this.Location;
                frmSL.FormClosing += delegate { this.LoadDSCTHD(); this.Show(); };
                frmSL.chiTietHDChon = ChiTietHD;
                frmSL.HoaDonChon = HoaDon;
                frmSL.DichVuChon = DichVuChon;
                frmSL.PhongHatChon = PhongHatChon;
                frmSL.MaNVTT = MaNVTT;
                frmSL.ShowDialog();
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        
        private void dgvMenuDV_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvMenuDV.SelectedRows.Count > 0)
            {
                int i = Convert.ToInt32(dgvMenuDV.CurrentRow.Index);
                string TenDV = (string)dgvMenuDV.Rows[i].Cells[1].Value;
                DichVuChon = lsDichVu_DTO.Find(o => o.TenDV == TenDV);
                ChiTietHD = null;
            }
            else
            {
                DichVuChon = null;
            }
        }

        private void btnDelSP_Click(object sender, EventArgs e)
        {

            if (dgvCTHD.SelectedRows.Count > 0)
            {
                ChiTietHD_DTO ct = dgvCTHD.CurrentRow.DataBoundItem as ChiTietHD_DTO;
                if (ct.MaDV != "Giờ Hát")
                {
                    string maDichVu = String.Empty;
                    maDichVu = Dv_BUS.LayMaDVTheoTenDV(ChiTietHD.MaDV);
                    ct.MaDV = maDichVu;
                    DialogResult dr = XtraMessageBox.Show("Bạn có chắc muốn xóa?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                    if (dr == DialogResult.Yes)
                    {
                        if (ct.MaDV == "DV001")
                        {
                            XtraMessageBox.Show("Không thể xóa Giờ hát");
                        }
                        else
                        {
                            if (CTHDBus.XoaDichVu(ct))
                            {
                                this.LoadDSPhongLenListView();
                                this.LoadDSCTHD();
                                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT003", MaNVTT + " xóa món " + Dv_BUS.LayTenDichVuTheoMaDV(ct.MaDV) + " tại " + PhongHatChon.TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            }
                        }
                    }
                }
            }
        }

        private void lvwPhong_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (lvwPhong.SelectedItems.Count > 0)
                {
                    ListViewItem lviChon = lvwPhong.SelectedItems[0];
                    PhongHatChon = lsPhongHat_DTO.Find(o => o.MaPH == lviChon.SubItems[1].Text);
                    lbPhong.Text = PhongHatChon.TenPH;
                    HoaDon = HoaDonBUS.KiemTraPhongTrong(PhongHatChon.MaPH);
                    ChiTietHD = CTHDBus.LayDSCTHD(PhongHatChon.MaPH).SingleOrDefault(x => x.MaHD == HoaDon.MaHD && x.MaDV == "Giờ Hát");
                    if (HoaDon.MaHD == null || ChiTietHD == null)
                    {
                        lbSumMoney.Text = "0";
                        lbGioVao.Text = DateTime.Now.ToString("HH:mm:ss");
                        dgvCTHD.DataSource = null;
                        CapNhatBtnKhiChuaMoPhong();
                    }
                    else
                    {
                        CapNhatGioHat();
                        if (tongSoPhutSuDung > 0)
                        {
                            string maDichVu = Dv_BUS.LayMaDVTheoTenDV(ChiTietHD.MaDV);
                            ChiTietHD.MaDV = maDichVu;
                            ChiTietHD.SoLuong = tongSoPhutSuDung;
                            ChiTietHD.GiaBan = tienGioTrenPhut;
                            CTHDBus.CapNhatGioHat(ChiTietHD);
                            this.LoadDSCTHD();
                        }
                        SetMaHD(HoaDon.MaHD);
                        MaHDIn = HoaDon.MaHD;
                        lsCTHD = CTHDBus.LayDSCTHD(PhongHatChon.MaPH);
                        dgvCTHD.DataSource = null;
                        dgvCTHD.DataSource = lsCTHD;
                        lbSumMoney.Text = lsCTHD.Sum(o => o.ThanhTien).ToString();
                        lbGioVao.Text = HoaDon.GioVao.ToString();
                        CapNhatBtnKhiMoPhong();
                        if (HoaDonBUS.KiemTraTonTaiHoaDonTamTinh(PhongHatChon.MaPH) != "0")
                        {
                            btnHuyHDTT.Enabled = true;
                        }
                        else
                        {
                            btnHuyHDTT.Enabled = false;
                        }

                    }
                }
                else
                {
                    PhongHatChon = null;
                    this.LoadDSCTHD();
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void SetMaHD(string p)
        {
            this.MaHDThanhToan = p;
        }
        private string GetMaHD()
        {
            return MaHDThanhToan;
        }
        private void CapNhatBtnKhiMoPhong()
        {
            btnADD.Enabled = true;
            btnDelSP.Enabled = true;
            btnMoPhong.Enabled = false;
            btnChuyenPhong.Enabled = true;
            btntinhtien.Enabled = true;
            btnXoaHD.Enabled = true;
            btnInHD.Enabled = true;

        }

        void SetButtonFormMainFalseWhenLostConnect()
        {
            dgvCTHD.Enabled = false;
            groupMenuDV.Enabled = false;
        }
        private void btnMoPhong_Click(object sender, EventArgs e)
        {
            try
            {
                if (lvwPhong.SelectedItems.Count == 0)
                {
                    XtraMessageBox.Show("Vui lòng chọn phòng", "Thông báo");
                }
                else
                {
                    HoaDon_DTO HDTim = HoaDonBUS.KiemTraPhongTrong(PhongHatChon.MaPH);
                    if (HDTim.MaHD != null)
                    {
                        XtraMessageBox.Show("Vui lòng chọn phòng khác", "Thông báo");
                    }
                    else
                    {
                        HoaDon_DTO HoaDonMoi = new HoaDon_DTO();
                        HoaDonMoi.MaHD = HoaDonBUS.LayMaLonNhat();
                        HoaDonMoi.MaPhong = PhongHatChon.MaPH;
                        HoaDonMoi.NhanVienMoPhong = MaNVTT;
                        HoaDonMoi.NhanVienLapHD = TaiKhoanDN.MaNV;
                        HoaDonMoi.GioVao = DateTime.Now.ToString("HH:mm:ss");
                        string a = DateTime.Now.ToString("HH");
                        string b = DateTime.Now.ToString("mm");
                        gioMoPhong = int.Parse(a);
                        phutMoPhong = int.Parse(b);
                        HoaDonMoi.TienGio = int.Parse(a);
                        HoaDonMoi.TienPhut = int.Parse(b);
                        gio2 = HoaDonMoi.TienGio;
                        phut2 = HoaDonMoi.TienPhut;
                        if (HoaDonBUS.ThemHoaDon(HoaDonMoi))
                        {
                            double tienGioTrenPhut = 0;
                            int gioVao = int.Parse(a);
                            int phutVao = int.Parse(b);
                            // Tính tiền ngày cuối tiền
                            if (DateTime.Now.DayOfWeek.ToString().Equals("Sunday") || DateTime.Now.DayOfWeek.ToString().Equals("Saturday"))
                            {
                                // Tính tiền phòng VIP
                                if (PhongHatChon.LoaiPhong.Equals("LP001"))
                                {
                                    if (gioVao < 17)
                                    {
                                        tienGioTrenPhut = Math.Round(120000 / 60.0, 3);
                                    }
                                    else if (gioVao >= 17)
                                    {
                                        tienGioTrenPhut = Math.Round(150000 / 60.0, 3);
                                    }
                                }
                                // Tính tiền phòng thường
                                else
                                {
                                    if (gioVao < 17)
                                    {
                                        tienGioTrenPhut = Math.Round(10000 / 60.0, 3);
                                    }
                                    else if (gioVao >= 17)
                                    {
                                        tienGioTrenPhut = Math.Round(120000 / 60.0, 3);
                                    }
                                }
                            }
                            // Tính tiền ngày thường
                            else
                            {
                                // Tính tiền phòng VIP
                                if (PhongHatChon.LoaiPhong.Equals("LP001"))
                                {
                                    if (gioVao < 17)
                                    {
                                        tienGioTrenPhut = Math.Round(100000 / 60.0, 3);
                                    }
                                    else if (gioVao >= 17)
                                    {
                                        tienGioTrenPhut = Math.Round(120000 / 60.0, 3);
                                    }
                                }
                                // Tính tiền phòng thường
                                else
                                {
                                    if (gioVao < 17)
                                    {
                                        tienGioTrenPhut = Math.Round(80000 / 60.0, 3);
                                    }
                                    else if (gioVao >= 17)
                                    {
                                        tienGioTrenPhut = Math.Round(100000 / 60.0, 3);
                                    }
                                    else if (gioVao < 17)
                                    {
                                        tienGioTrenPhut = Math.Round(((80000 + 100000) / 2) / 60.0, 3);
                                    }
                                }
                            }
                            ChiTietHD = new ChiTietHD_DTO();
                            ChiTietHD.MaHD = HoaDonMoi.MaHD;
                            ChiTietHD.MaDV = "DV001";
                            ChiTietHD.GiaBan = tienGioTrenPhut;
                            ChiTietHD.SoLuong = 1;
                            CTHDBus.ThemDichVu(ChiTietHD);
                            XtraMessageBox.Show("Mở phòng thành công", "Thông báo");
                            lsCTHD = new List<ChiTietHD_DTO>();
                            dgvCTHD.DataSource = lsCTHD;
                            CapNhatBtnKhiMoPhong();
                            PhongHatBUS.SetPhongDangSuDung(PhongHatChon.MaPH.ToString());
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT007",MaNVTT + " mở " + PhongHatChon.TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            this.LoadDanhSachPhongHat();
                            this.LoadDSPhongLenListView();
                            this.LoadDSCTHD();
                            this.lvwPhong.Refresh();
                        }
                        else
                        {
                            XtraMessageBox.Show("Mở phòng thất bại", "Thông báo");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void dgvHoaDon_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            try
            {

                if (dgvCTHD.SelectedRows.Count > 0)
                {
                    try
                    {
                        this.BeginInvoke(new MethodInvoker(() =>
                        {
                            UpdateSL(dgvCTHD);
                        }));
                    }
                    catch (Exception er)
                    {
                        XtraMessageBox.Show(er.Message);
                    }

                }
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        private void UpdateSL(DataGridView dgvCTHD)
        {
            try
            {
                int i = Convert.ToInt32(dgvCTHD.CurrentRow.Index);
                ChiTietHD_DTO CTHD = new ChiTietHD_DTO();
                CTHD.MaDV = (string)dgvCTHD.Rows[i].Cells[1].Value;
                CTHD.MaHD = HoaDonBUS.LayMaHDChuaThanhToan(PhongHatChon.MaPH);
                CTHD.SoLuong = (int)dgvCTHD.Rows[i].Cells[3].Value;
                CTHD.GiaBan = (int)dgvCTHD.Rows[i].Cells[2].Value;
                lsCTHD.Add(CTHD);

                if (CTHDBus.UpdateSoLuong(CTHD))
                {
                    XtraMessageBox.Show("Cập nhật thành công", "Thông báo");
                    LoadDSCTHD();
                }
                else
                    XtraMessageBox.Show("Cập nhật thất bại", "Thông báo");
            }
            catch (Exception er)
            {
                XtraMessageBox.Show(er.Message);
            }
        }

        private void LoadDSCTHD()
        {
            if (PhongHatChon != null)
            {
                lsCTHD = new List<ChiTietHD_DTO>();
                lsCTHD = CTHDBus.LayDSCTHD(PhongHatChon.MaPH);
                dgvCTHD.DataSource = null;
                dgvCTHD.DataSource = lsCTHD;
                lbSumMoney.Text = lsCTHD.Sum(o => o.ThanhTien).ToString();
            }
        }

        public float tinhtiengio(int gio3, int phut3, int gio2, int phut2)
        {
            //2 giờ bị trùng, hệ thống ko lấy khoảng cách của 2 vùng thời gian
            int a;
            if (phut3 < phut2)
            {
                a = (gio3 - gio2) * 60;
                phut3 = phut3 + a - phut2;
                tien = (600000 / 60) * phut3;
            }
            else
            {
                phut3 = phut3 - phut2;
                tien = (600000 / 60) * phut3;
            }

            return tien;

        }
   

        private void btntinhtien_Click(object sender, EventArgs e)
        {
            try
            {
                if (lvwPhong.SelectedItems.Count > 0)
                {
                    HoaDon_DTO HoaDonTT = new HoaDon_DTO();
                   
                        HoaDonTT.MaHD = HoaDonBUS.LayMaHDChuaThanhToan(PhongHatChon.MaPH);
                        HoaDonTT.MaPhong = PhongHatChon.MaPH;
                        HoaDonTT.GioVao = lbGioVao.Text;
                        HoaDonTT.GioRa = DateTime.Now.ToString("HH:mm:ss");
                        HoaDonTT.GioSuDung = DateTime.Now.Hour;
                        HoaDonTT.PhutSuDung = DateTime.Now.Minute;
                        HoaDonTT.NgayLap = DateTime.Now;
                        HoaDonTT.NhanVienLapHD = MaNVTT;
                        a = float.Parse(lbSumMoney.Text);
                        lbSumMoney.Text = (a + tiengiohat).ToString();
                        HoaDonTT.TongTien = int.Parse(lbSumMoney.Text);
                    
                    if (HoaDonBUS.UpdateTraPhong(HoaDonTT))
                    {
                        _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT008", MaNVTT + " lập hóa đơn thanh toán hóa đơn " + HoaDonTT.MaHD + " cho " + PhongHatChon.TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                        //Trừ số lượng khi thanh toán phòng
                        lsCTHDTemp = CTHDBus.LayDSDVCuaHoaDon(HoaDon.MaHD);
                        for (int i = 0; i < lsCTHDTemp.Count; i++)
                        {
                            if (lsCTHDTemp[i].MaDV != "DV001")
                            {
                                Dv_BUS.CapNhatSoLuongKhiThanhToanHoaDon(lsCTHDTemp[i].MaDV, lsCTHDTemp[i].SoLuong);
                            }
                        }
                        FrmReportHoaDonDaThanhToan frmHDDTT = new FrmReportHoaDonDaThanhToan();
                        frmHDDTT.MaHDDaThanhToan = MaHDIn;
                        frmHDDTT.Show();
                        PhongHatBUS.SetPhongTrong(PhongHatChon.MaPH.ToString());
                        lvwPhong.Clear();
                        LoadDSPhongLenListView();
                        dgvCTHD.DataSource = null;
                        lbSumMoney.Text = "0";
                     
                        HoaDonTT.GioRa = DateTime.Now.ToString("HH:mm:ss");
                        HoaDonTT.GioSuDung = DateTime.Now.Hour;
                        HoaDonTT.PhutSuDung = DateTime.Now.Minute;
                        a = float.Parse(lbSumMoney.Text);
                        lbSumMoney.Text = a.ToString();
                        HoaDonTT.TongTien = double.Parse(lbSumMoney.Text);
                        lbGioVao.Text = DateTime.Now.ToString("HH:mm:ss");
                        this.LoadDanhSachPhongHat();
                        this.LoadDSPhongLenListView();
                        this.LoadDSHoaDon();
                        CapNhatBtnKhiChuaMoPhong();
                    }
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        
        }


        private void btnXoaHD_Click(object sender, EventArgs e)
        {
            try
            {
                if (lvwPhong.SelectedItems.Count > 0)
                {
                    HoaDon_DTO HoaDonXoa = new HoaDon_DTO();
                    HoaDonXoa.MaHD = HoaDonBUS.LayMaHDChuaThanhToan(PhongHatChon.MaPH);
                    HoaDonXoa.MaPhong = PhongHatChon.MaPH;
                    if (CTHDBus.LayGioHat(HoaDonXoa.MaHD) > 30)
                    {
                        XtraMessageBox.Show("Bạn không thể xóa phòng đã mở hơn 30 phút!", "Cảnh báo");
                    }
                    else
                    {
                        DialogResult dr = XtraMessageBox.Show("Bạn có chắc chắn đóng phòng này?", "Hủy Hóa Đơn!", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dr == DialogResult.Yes)
                    {
                        if (HoaDonBUS.XoaHoaDon(HoaDonXoa))
                        {
                            XtraMessageBox.Show("Đóng phòng thành công thành công", "Thông báo");
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT006", MaNVTT + " đóng phòng " + PhongHatChon.TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            dgvCTHD.DataSource = null;
                            lbSumMoney.Text = "0";
                            lbGioVao.Text = DateTime.Now.ToString("HH:mm:ss");
                            PhongHatBUS.SetPhongTrong(PhongHatChon.MaPH.ToString());
                            LoadDanhSachPhongHat();
                            LoadDSPhongLenListView();
                            CapNhatBtnKhiChuaMoPhong();
                        }
                        else
                        {
                            XtraMessageBox.Show("Hủy thất bại", "Thông báo");
                        }
                    }
                    }
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void txtLuong_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
                e.Handled = true;
        }

        private void txtGiaNhap_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
                e.Handled = true;
        }

        private void txtGiaBan_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
                e.Handled = true;
        }

        private void txtSLT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
                e.Handled = true;
        }

        private void btnChuyenPhong_Click(object sender, EventArgs e)
        {
            try
            {
                if (PhongHatChon.MaPH == null)
                {
                    XtraMessageBox.Show("Vui lòng chọn phòng trước khi chuyển phòng!");
                }
                else
                {
                    FrmChuyenPhong f = new FrmChuyenPhong();
                    f.MaPH = PhongHatChon.MaPH;
                    f.Show();
                    f.FormClosing += delegate { this.LoadDSPhongLenListView(); this.LoadDSCTHD(); };
                }
            }
           catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }


        internal void SetChuyenPhong()
        {
            LoadDSPhongLenListView();

        }

        private void txtSDT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void txtHoTen_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (Char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void txtDVT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (Char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void dgvMenuDV_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btnADD.PerformClick();
            }
        }

      

        private void txtTenSPMenu_TextChanged(object sender, EventArgs e)
        {
            dgvMenuDV.DataSource = Dv_BUS.RealTimeSearchFoodByName(txtTenSPMenu.Text);
        }

        private void txttimkiemphonghat_TextChanged(object sender, EventArgs e)
        {
            dgvPhong.DataSource = PhongHatBUS.RealTimeSearchRoomByName(txttimkiemphonghat.Text);
        }

        private void btntypephongvip_Click(object sender, EventArgs e)
        {
            dgvPhong.DataSource = PhongHatBUS.SortByTypeVIP();
        }

        private void btntypephongthuong_Click(object sender, EventArgs e)
        {
            dgvPhong.DataSource = PhongHatBUS.SortByTypeNormal();
        }

        private void btntypephongtrong_Click(object sender, EventArgs e)
        {
            dgvPhong.DataSource = PhongHatBUS.SortByTypeRoomEmpty();
        }

        private void btntypephongsudung_Click(object sender, EventArgs e)
        {
            dgvPhong.DataSource = PhongHatBUS.SortByTypeRoomWorked();
        }

        private void txttimkiemSP_TextChanged(object sender, EventArgs e)
        {
            dgvDichVu.DataSource = Dv_BUS.RealTimeSearchFoodByName(txttimkiemSP.Text);
        }

        private void btnSortByTypeDrink_Click(object sender, EventArgs e)
        {
            dgvDichVu.DataSource = Dv_BUS.SortFoodByTypeFood();
        }

        private void btnSortByTypeFood_Click(object sender, EventArgs e)
        {
            dgvDichVu.DataSource = Dv_BUS.SortFoodByTypeDrink();
        }

        private void txttimkiemnhanvien_TextChanged(object sender, EventArgs e)
        {
            dgvNhanVien.DataSource = NV_BUS.RealTimeSearchNhanVienByName(txttimkiemnhanvien.Text);
        }

        private void btnTaoTK_Click(object sender, EventArgs e)
        {
            txtPass.ReadOnly = false;
            txtRePass.ReadOnly = false;
            btnCPass.Enabled = true;
        }

        private void btnCPass_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtPass.Text == txtRePass.Text)
                {
                    if (TK_BUS.ChangePassword(txtMaTK1.Text, Ultils.ToMD5(txtPass.Text)))
                    {
                        XtraMessageBox.Show("Thay đổi mật khẩu thành công", "Thông báo");
                        RangBuocThayDoiMK();
                        SetTextBoxNhanVienFalse();
                        LoadDSNV();
                    }
                }
                else
                {
                    XtraMessageBox.Show("Mật khẩu không khớp, kiểm tra lại", "Thông báo");
                }

            }
            catch (Exception ex)
            {
                XtraMessageBox.Show(ex.ToString());
            }
        }

        private void txtPass_EditValueChanged(object sender, EventArgs e)
        {
            txtPass.Properties.UseSystemPasswordChar = true;
        }

        private void btnshowpassword_Click(object sender, EventArgs e)
        {
            txtPass.Properties.UseSystemPasswordChar = !txtPass.Properties.UseSystemPasswordChar;
        }

        private void txtRePass_EditValueChanged(object sender, EventArgs e)
        {
            txtRePass.Properties.UseSystemPasswordChar = true;
        }

        private void simpleButton2_Click(object sender, EventArgs e)
        {
            txtRePass.Properties.UseSystemPasswordChar = !txtRePass.Properties.UseSystemPasswordChar;
        }

       
        //RealTime LoadDaTa--------------------------------------------------------------------------------
        private void Form1_OnLoadNewDataListView()
        {
            ISynchronizeInvoke i = (ISynchronizeInvoke)this;
            if (i.InvokeRequired)
            {
                LoadNewDataListView dd = new LoadNewDataListView(Form1_OnLoadNewDataListView);
                i.BeginInvoke(dd, null);
                return;
            }
            LoadDataListViewRealTime();

        }

        void LoadDataListViewRealTime()
        {
            DataTable dt = new DataTable();
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }

            SqlCommand cmd = new SqlCommand("SELECT dbo.HoaDon.MaHD,dbo.PhongHat.TinhTrang,dbo.ChiTietHoaDon.MaDV,dbo.ChiTietHoaDon.SoLuong  from dbo.PhongHat, dbo.ChiTietHoaDon,dbo.HoaDon where dbo.ChiTietHoaDon.MaHD = dbo.HoaDon.MaHD and dbo.ChiTietHoaDon.TrangThai = 1", conn);
            cmd.Notification = null;

            SqlDependency de = new SqlDependency(cmd);
            de.OnChange += new OnChangeEventHandler(de_OnChange);

            dt.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection));
            LoadDSPhongLenListView();
            LoadDSCTHD();

        }
        void de_OnChange(object sender, SqlNotificationEventArgs e)
        {

            SqlDependency de = sender as SqlDependency;
            de.OnChange -= de_OnChange;
            if (OnLoadNewDataListView != null)
            {
                OnLoadNewDataListView();
            }
        }

        private void dgvCTHD_Click(object sender, EventArgs e)
        {
            ChiTietHD = dgvCTHD.CurrentRow.DataBoundItem as ChiTietHD_DTO;
        }

        private void dgvCTHD_DoubleClick(object sender, EventArgs e)
        {
            try
            {
                string maDichVu = String.Empty;
                maDichVu = Dv_BUS.LayMaDVTheoTenDV(ChiTietHD.MaDV);
                ChiTietHD.MaDV = maDichVu;
                if (ChiTietHD.MaDV != "DV001")
                {
                    var frmSL = new FrmSoLuong();
                    frmSL.Location = this.Location;
                    frmSL.MaNVTT = MaNVTT;
                    frmSL.maDichVu = maDichVu;
                    frmSL.chiTietHDChon = ChiTietHD;
                    frmSL.FormClosing += delegate { this.LoadDSCTHD(); this.Show(); };
                    frmSL.ShowDialog();
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex.ToString());
            }
        }

        private void CapNhatGioHat()
        {
            try
            {
                int gioVao = 0;
                int phutVao = 0;
                if (HoaDon.TienGio != 0 || HoaDon.TienPhut != 0)
                {
                    gioVao = HoaDon.TienGio;
                    phutVao = HoaDon.TienPhut;
                }
                else
                {
                    gioVao = gioMoPhong;
                    phutVao = phutMoPhong;
                }
                int gioRa = int.Parse(DateTime.Now.ToString("HH:mm:ss").Substring(0, 2));
                int phutRa = int.Parse(DateTime.Now.ToString("HH:mm:ss").Substring(3, 2));
                // Tính tiền ngày cuối tiền
                if (DateTime.Now.DayOfWeek.ToString().Equals("Sunday") || DateTime.Now.DayOfWeek.ToString().Equals("Saturday"))
                {
                    // Tính tiền phòng VIP
                    if (PhongHatChon.LoaiPhong.Equals("LP001"))
                    {
                        if (gioVao < 17 && gioRa < 17)
                        {
                            tienGioTrenPhut = Math.Round(120000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);
                        }
                        else if (gioVao >= 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(150000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);

                        }
                        else if (gioVao < 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(((120000 + 150000) / 2) / 60.0, 3);
                            tongSoPhutSuDung = ((16 * 60 + 59) - (gioVao * 60 + phutVao)) + ((gioRa * 60 + phutRa) - (17 * 60));
                        }
                    }
                    // Tính tiền phòng thường
                    else
                    {
                        if (gioVao < 17 && gioRa < 17)
                        {
                            tienGioTrenPhut = Math.Round(10000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);
                        }
                        else if (gioVao >= 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(120000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);

                        }
                        else if (gioVao < 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(((100000 + 120000) / 2) / 60.0, 3);
                            tongSoPhutSuDung = ((16 * 60 + 59) - (gioVao * 60 + phutVao)) + ((gioRa * 60 + phutRa) - (17 * 60));
                        }
                    }
                }
                // Tính tiền ngày thường
                else
                {
                    // Tính tiền phòng VIP
                    if (PhongHatChon.LoaiPhong.Equals("LP001"))
                    {
                        if (gioVao < 17 && gioRa < 17)
                        {
                            tienGioTrenPhut = Math.Round(100000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);
                        }
                        else if (gioVao >= 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(120000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);

                        }
                        else if (gioVao < 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(((100000 + 120000) / 2) / 60.0, 3);
                            tongSoPhutSuDung = ((16 * 60 + 59) - (gioVao * 60 + phutVao)) + ((gioRa * 60 + phutRa) - (17 * 60));
                        }
                    }
                    // Tính tiền phòng thường
                    else
                    {
                        if (gioVao < 17 && gioRa < 17)
                        {
                            tienGioTrenPhut = Math.Round(80000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);
                        }
                        else if (gioVao >= 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(100000 / 60.0, 3);
                            tongSoPhutSuDung = (gioRa * 60 + phutRa) - (gioVao * 60 + phutVao);

                        }
                        else if (gioVao < 17 && gioRa >= 17)
                        {
                            tienGioTrenPhut = Math.Round(((80000 + 100000) / 2) / 60.0, 3);
                            tongSoPhutSuDung = ((16 * 60 + 59) - (gioVao * 60 + phutVao)) + ((gioRa * 60 + phutRa) - (17 * 60));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex);
            }
        }

        //RealTime LoadDaTa--------------------------------------------------------------------------------
              //RealTime LoadDaTa CTHD--------------------------------------------------------------------------------
        private void btnSuaThongTinNV_Click(object sender, EventArgs e)
        {
            SetTextBoxNhanVienTrue();
            SetTrueThayDoiThongTinNhanVien();
            txtGhiChuNhanVien.ReadOnly = false;
        }

        private void btnSuaThongTinPhong_Click(object sender, EventArgs e)
        {
            SetTextBoxPhongHatTrue();
            btnSuaPhong.Enabled = true;
            txtMoTaPhongHat.ReadOnly = false;
        }

        private void btnSuaThongTinDichVu_Click(object sender, EventArgs e)
        {
            SetTextBoxDichVuTrue();
            btnSuaSP.Enabled = true;
            txtGhiChuDichVu.ReadOnly = false;
        }

        private void btnInHD_Click(object sender, EventArgs e)
        {
            try
            {
                if (PhongHatChon != null)
                {
                    if (ChiTietHD.MaDV != null)
                    {
                        CapNhatGioHat();
                        if (ChiTietHD.MaDV == "DV001")
                        {
                            if (tongSoPhutSuDung > 0)
                            {
                                ChiTietHD.SoLuong = tongSoPhutSuDung;
                                ChiTietHD.GiaBan = tienGioTrenPhut;
                                CTHDBus.CapNhatGioHat(ChiTietHD);
                                this.LoadDSCTHD();
                            }
                            HoaDon_DTO HoaDonTT = new HoaDon_DTO();
                            HoaDonTT.MaHD = HoaDonBUS.LayMaHDChuaThanhToan(PhongHatChon.MaPH);
                            HoaDonTT.GioRa = DateTime.Now.ToString("HH:mm:ss");
                            HoaDonTT.GioSuDung = DateTime.Now.Hour;
                            HoaDonTT.PhutSuDung = DateTime.Now.Minute;
                            HoaDonTT.NhanVienLapHDTT = MaNVTT;
                            HoaDonTT.NgayLap = DateTime.Now;
                            a = float.Parse(lbSumMoney.Text);
                            lbSumMoney.Text = (a + tiengiohat).ToString();
                            HoaDonTT.TongTien = double.Parse(lbSumMoney.Text);
                            if (HoaDonBUS.UpdateHoaDonTamTinh(HoaDonTT))
                            {
                                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT015", MaNVTT + " lập hóa đơn tạm tính hóa đơn " + HoaDonTT.MaHD, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                                FrmReportHoaDonTamTinh frmHDTT = new FrmReportHoaDonTamTinh();
                                frmHDTT.MaHDTamTinh = MaHDIn;
                                frmHDTT.Show();
                                //DEMO_HOADONTAMTINH demo = new DEMO_HOADONTAMTINH();
                                //demo.mahdtamtinh = MaHDIn;
                                //demo.Show();
                                btnHuyHDTT.Enabled = true;
                            }
                        }
                        else
                        {
                            XtraMessageBox.Show("Vui lòng chọn dòng Giờ Hát trước khi in hóa đơn");
                        }
                    }
                    else
                    {
                        XtraMessageBox.Show("OK");
                    }
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn phòng cần in hóa đơn tạm tính!", "Thông báo");
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Vui lòng chọn dòng Giờ Hát trước khi in hóa đơn");
            }
        }

        private void btnHuyHDTT_Click(object sender, EventArgs e)
        {
            try
            {
                if (PhongHatChon != null)
                {
                    DialogResult dialogconfirm = XtraMessageBox.Show("Bạn có chắc chắn muốn hủy hóa đơn tạm tính?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dialogconfirm == DialogResult.Yes)
                    {
                        HoaDon_DTO HoaDonTT = new HoaDon_DTO();
                        HoaDonTT.MaHD = HoaDonBUS.LayMaHDChuaThanhToan(PhongHatChon.MaPH);
                        if (HoaDonBUS.HuyHoaDonTamTinh(HoaDonTT))
                        {
                            _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT016", MaNVTT + " hủy hóa đơn tạm tính cho hóa đơn " + HoaDonTT.MaHD, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                            XtraMessageBox.Show("Hủy hóa đơn tạm tính thành công!", "Thông báo");
                            btnHuyHDTT.Enabled = false;
                        }
                    }
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn phòng cần hủy hóa đơn tạm tính!", "Thông báo");
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex);
            }
        }
        private void btnLogHistory_ItemClick(object sender, ItemClickEventArgs e)
        {
            try
            {
                FrmReportLichSuThaoTac frmLichSuThaoTac = new FrmReportLichSuThaoTac();
                frmLichSuThaoTac.Show();
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex);
            }
        }
        internal void ThemDichVu(ChiTietHD_DTO CTHD, string MaNVTT, string TenPH)
        {
            try 
            {
                lsCTHD.Add(CTHD);
                dgvCTHD.DataSource = null;
                dgvCTHD.DataSource = lsCTHD;
                lbSumMoney.Text = lsCTHD.Sum(o => o.ThanhTien).ToString();
                _LichSuThaoTacBUS.CapNhatThaoTac(MaNVTT, "TT002", MaNVTT + " thêm món " + Dv_BUS.LayTenDichVuTheoMaDV(CTHD.MaDV) + " vào " + TenPH, DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex);
            }
        }

        private void txtSDT_KeyPress_1(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
            {
                e.Handled = true;
                XtraMessageBox.Show("Số điện thoại phải là kí tự số ", "Thông Báo ");
            }
        }

        private void txtHoTen_KeyPress_1(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
                XtraMessageBox.Show("Họ tên phải là kí tự chữ ", "Thông Báo ");
            } 
        }
        void LoadDSHoaDon()
        {
            dgvQuanLyHoaDon.DataSource = HoaDonBUS.LayDanhSachHoaDon();
        }

        void LoadDSHoaDonFromDayToDay()
        {
            dgvQuanLyHoaDon.DataSource = null;
            dgvQuanLyHoaDon.DataSource = _ThongKeBUS.LoadDSHoaDonFromDayToDay(dtpFromDay.Value, dtpToDay.Value);
        }

        private void btnXemCTHD_Click(object sender, EventArgs e)
        {
            try
            {
                if (dgvQuanLyHoaDon.SelectedRows.Count > 0)
                {
                    HoaDon = dgvQuanLyHoaDon.CurrentRow.DataBoundItem as HoaDon_DTO;
                    FrmReportHoaDonDaThanhToan frm = new FrmReportHoaDonDaThanhToan();
                    frm.MaHDDaThanhToan = HoaDon.MaHD;
                    frm.Show();
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn HĐ cần in");
                }
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Lỗi: " + ex);
            }
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            LoadDSHoaDonFromDayToDay();
        }

        private void dgvQuanLyHoaDon_DoubleClick(object sender, EventArgs e)
        {
            btnXemCTHD.PerformClick();
        }

        private void rdThongKeDoanhThu_Click(object sender, EventArgs e)
        {
            cbbThongKeDoanhThu.Enabled = true;
            cbbThongKeSoLuongSanPhamBan.Enabled = false;
            cbbThongKeSoLuongSanPhamBan.Text = string.Empty;
            cbbThongKeSoLuongSanPhamBan.SelectedItem = null;
            cbbThongKeSoLuongTonSP.Enabled = false;
            cbbThongKeSoLuongTonSP.Text = string.Empty;
            cbbThongKeSoLuongTonSP.SelectedItem = null;
        }

        private void rdThongkeSoLuongSPBan_Click(object sender, EventArgs e)
        {
            cbbThongKeDoanhThu.Enabled = false;
            cbbThongKeDoanhThu.Text = string.Empty;
            cbbThongKeDoanhThu.SelectedItem = null;
            cbbThongKeSoLuongSanPhamBan.Enabled = true;
            cbbThongKeSoLuongTonSP.Enabled = false;
            cbbThongKeSoLuongTonSP.Text = string.Empty;
            cbbThongKeSoLuongTonSP.SelectedItem = null;
        }

        private void rdThongKeSLTSanPham_Click(object sender, EventArgs e)
        {
            cbbThongKeDoanhThu.Enabled = false;
            cbbThongKeDoanhThu.Text = string.Empty;
            cbbThongKeDoanhThu.SelectedItem = null;
            cbbThongKeSoLuongSanPhamBan.Enabled = false;
            cbbThongKeSoLuongSanPhamBan.Text = string.Empty;
            cbbThongKeSoLuongSanPhamBan.SelectedItem = null;
            cbbThongKeSoLuongTonSP.Enabled = true;
        }

        private void lvwPhong_DoubleClick(object sender, EventArgs e)
        {
            XtraMessageBox.Show(PhongHatChon.MoTa, "Thông tin " + PhongHatChon.TenPH);
        }

        private void labelControl2_Click(object sender, EventArgs e)
        {

        }
           
    }
}