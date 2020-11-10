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
    public partial class FrmReportHoaDonTamTinh : Form
    {
        public string MaHDTamTinh;
        public FrmReportHoaDonTamTinh()
        {
            InitializeComponent();
        }

        private void FrmReportHoaDonTamTinh_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_HoaDonTamTinh' table. You can move, or remove it, as needed.
            this.PROC_HoaDonTamTinhTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_HoaDonTamTinh, MaHDTamTinh);
            this.reportViewer1.RefreshReport();
        }
    }
}
