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
namespace DOAN
{
    public partial class FrmReportLichSuThaoTac : Form
    {
        public FrmReportLichSuThaoTac()
        {
            InitializeComponent();
        }
        ThongKe_BUS _ThongKeBUS = new ThongKe_BUS();
        private void FrmReportLichSuThaoTac_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_FilterLichSuThaoTac' table. You can move, or remove it, as needed.
            this.PROC_FilterLichSuThaoTacTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_FilterLichSuThaoTac,dtpFromDay.Value,dtpToDay.Value);
            this.reportViewer1.RefreshReport();
            
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            this.reportViewer1.Clear();
            this.PROC_FilterLichSuThaoTacTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_FilterLichSuThaoTac, dtpFromDay.Value, dtpToDay.Value);
            this.reportViewer1.RefreshReport();
        }
    
    }
}
