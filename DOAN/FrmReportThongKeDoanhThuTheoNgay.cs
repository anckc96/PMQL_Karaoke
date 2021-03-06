﻿using System;
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
    public partial class FrmReportThongKeDoanhThuTheoNgay : Form
    {
        public FrmReportThongKeDoanhThuTheoNgay()
        {
            InitializeComponent();
            dtpNgay.MaxDate = DateTime.Now;
        }

        private void FrmReportThongKeDoanhThuTheoNgaycs_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'QLPM_KaraokeDataSet.PROC_DoanhThuTheoNgay' table. You can move, or remove it, as needed.
            labelNgay.Text = (dtpNgay.Value.Day + "/" + dtpNgay.Value.Month + "/" + dtpNgay.Value.Year).ToString();
            this.PROC_DoanhThuTheoNgayTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_DoanhThuTheoNgay,dtpNgay.Value);
            this.reportViewer1.RefreshReport();
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            this.reportViewer1.Clear();
            this.PROC_DoanhThuTheoNgayTableAdapter.Fill(this.QLPM_KaraokeDataSet.PROC_DoanhThuTheoNgay, dtpNgay.Value);
            this.reportViewer1.RefreshReport();
            labelNgay.Text = (dtpNgay.Value.Day + "/" + dtpNgay.Value.Month + "/" + dtpNgay.Value.Year).ToString();
        }
    }
}
