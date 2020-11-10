using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DOAN
{
    public partial class FrmReportThongKeDoanhThu : Form
    {
        public FrmReportThongKeDoanhThu()
        {
            InitializeComponent();
            dtpFromDay.MaxDate = DateTime.Now;
            dtpToDay.MaxDate = DateTime.Now;
        }

        private void FrmReportThongKeDoanhThu_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_DoanhThuTuNgayToiNgay' table. You can move, or remove it, as needed.
            labelTuNgay.Text = (dtpFromDay.Value.Day + "/" + dtpFromDay.Value.Month + "/" + dtpFromDay.Value.Year).ToString();
            labelDenNgay.Text = (dtpToDay.Value.Day + "/" + dtpToDay.Value.Month + "/" + dtpToDay.Value.Year).ToString();
            this.PROC_DoanhThuTuNgayToiNgayTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_DoanhThuTuNgayToiNgay,dtpFromDay.Value,dtpToDay.Value);
            this.reportViewer1.RefreshReport();
           
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            this.reportViewer1.Clear();
            this.PROC_DoanhThuTuNgayToiNgayTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_DoanhThuTuNgayToiNgay, dtpFromDay.Value, dtpToDay.Value);
            this.reportViewer1.RefreshReport();
            labelTuNgay.Text = (dtpFromDay.Value.Day + "/" + dtpFromDay.Value.Month + "/" + dtpFromDay.Value.Year).ToString();
            labelDenNgay.Text = (dtpToDay.Value.Day + "/" + dtpToDay.Value.Month + "/" + dtpToDay.Value.Year).ToString();
        }
     
      
    }
}
