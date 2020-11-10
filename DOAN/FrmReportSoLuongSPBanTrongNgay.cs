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
    public partial class FrmReportSoLuongSPBanTrongNgay : Form
    {
        public FrmReportSoLuongSPBanTrongNgay()
        {
            InitializeComponent();
            dtpNgay.MaxDate = DateTime.Now;
        }

        private void FrmReportSoLuongSPBanTrongNgay_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_SoLuongSPBanTrongNgay' table. You can move, or remove it, as needed.
            this.PROC_SoLuongSPBanTrongNgayTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_SoLuongSPBanTrongNgay,dtpNgay.Value.Date);
            labelNgay.Text = (dtpNgay.Value.Day + "/" + dtpNgay.Value.Month + "/" + dtpNgay.Value.Year).ToString();
            this.reportViewer1.RefreshReport();
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            this.reportViewer1.Clear();
            this.PROC_SoLuongSPBanTrongNgayTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_SoLuongSPBanTrongNgay, dtpNgay.Value.Date);
            this.reportViewer1.RefreshReport();
            labelNgay.Text = (dtpNgay.Value.Day + "/" + dtpNgay.Value.Month + "/" +dtpNgay.Value.Year ).ToString();
        }
    }
}
