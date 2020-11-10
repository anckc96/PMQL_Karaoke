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
    public partial class FrmReportThongKeDoanhThuTheoThang : Form
    {
        public FrmReportThongKeDoanhThuTheoThang()
        {
            InitializeComponent();
            dtpThang.MaxDate = DateTime.Now;
        }

        private void FrmReportThongKeDoanhThuTheoThang_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_DoanhThuTheoThang' table. You can move, or remove it, as needed.
            labelNgay.Text = (dtpThang.Value.Month + "/" + dtpThang.Value.Year).ToString();
            this.PROC_DoanhThuTheoThangTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_DoanhThuTheoThang,dtpThang.Value.Month,dtpThang.Value.Year);
            this.reportViewer1.RefreshReport();
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            this.reportViewer1.Clear();
            this.PROC_DoanhThuTheoThangTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_DoanhThuTheoThang, dtpThang.Value.Month, dtpThang.Value.Year);
            this.reportViewer1.RefreshReport();
            labelNgay.Text = (dtpThang.Value.Month + "/" + dtpThang.Value.Year).ToString();
        }
    }
}
