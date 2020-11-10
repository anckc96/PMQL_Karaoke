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
    public partial class FrmReportHoaDonDaThanhToan : Form
    {
        public string MaHDDaThanhToan;
        public FrmReportHoaDonDaThanhToan()
        {
            InitializeComponent();
        }

        private void FrmReportHoaDonDaThanhToan_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_HoaDonDaThanhToan' table. You can move, or remove it, as needed.
            this.PROC_HoaDonDaThanhToanTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_HoaDonDaThanhToan,MaHDDaThanhToan);
            this.reportViewer1.RefreshReport();
        }
    }
}
