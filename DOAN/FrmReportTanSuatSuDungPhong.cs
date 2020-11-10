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
    public partial class FrmReportTanSuatSuDungPhong : Form
    {
        public FrmReportTanSuatSuDungPhong()
        {
            InitializeComponent();
            dtpFromDay.MaxDate = DateTime.Now;

        }

        private void FrmReportTanSuatSuDungPhong_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_ThongKeTanSuatSuDungPhong' table. You can move, or remove it, as needed.
            labelTuNgay.Text = (dtpFromDay.Value.Month + "/" + dtpFromDay.Value.Year).ToString();
            this.PROC_ThongKeTanSuatSuDungPhongTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_ThongKeTanSuatSuDungPhong,dtpFromDay.Value.Month);
            this.reportViewer1.RefreshReport();

        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            this.PROC_ThongKeTanSuatSuDungPhongTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_ThongKeTanSuatSuDungPhong, dtpFromDay.Value.Month);
            this.reportViewer1.RefreshReport();
            labelTuNgay.Text = (dtpFromDay.Value.Month + "/" + dtpFromDay.Value.Year).ToString();
        }
    }
}
