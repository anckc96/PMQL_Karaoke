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
    public partial class FrmChuyenPhong : Form
    {
        PhongHat_BUS PH_BUS = new PhongHat_BUS();
        HoaDon_BUS HoaDonBUS = new HoaDon_BUS();
        PhongHat_DTO PhongHatChon = new PhongHat_DTO();
        public string MaPH { get; set; }
        public FrmChuyenPhong()
        {
            InitializeComponent();
            UserLookAndFeel.Default.SetSkinStyle("Office 2013 Light Gray");
        }

        private void FrmChuyenPhong_Load(object sender, EventArgs e)
        {
            lblTenPhong.Text = MaPH;
            LoadDSPhong();
        }

        private void LoadDSPhong()
        {
            List<PhongHat_DTO> lsPhongTrong = new List<PhongHat_DTO>();
            lsPhongTrong = PH_BUS.LayDSPhongTrong();

            cbbPhongTrong.DataSource = lsPhongTrong;
            cbbPhongTrong.DisplayMember = "TenPH";
            cbbPhongTrong.ValueMember = "MaPH";

        }

        private void btnChuyenPhong_Click(object sender, EventArgs e)
        {
            try
            {
                string MaPhongBiChuyen = cbbPhongTrong.SelectedValue.ToString();
                if (MaPhongBiChuyen != null && MaPH != null)
                {

                    if (HoaDonBUS.ChuyenPhong(MaPH, MaPhongBiChuyen))
                    {
                        XtraMessageBox.Show("Chuyển thành công", "Thông báo");
                        PH_BUS.ChuyenPhong(MaPH, MaPhongBiChuyen);
                        FormMain f = new FormMain();
                        f.SetChuyenPhong();
                    }
                    else
                    {
                        XtraMessageBox.Show("Chuyển thất bại", "Thông báo");
                    }
                }
                else
                {
                    XtraMessageBox.Show("Chưa chọn phòng chuyển", "Thông báo");
                }
                this.Close();
            }
            catch (Exception ex)
            {
                XtraMessageBox.Show("Bạn đã thao tác sai. Vui lòng thao tác lại!");
            }

        }

        private void btnthoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
