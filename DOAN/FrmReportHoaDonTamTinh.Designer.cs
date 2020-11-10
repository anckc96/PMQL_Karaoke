namespace DOAN
{
    partial class FrmReportHoaDonTamTinh
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.PROC_HoaDonTamTinhBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.PROC_HoaDonTamTinhTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_HoaDonTamTinhTableAdapter();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_HoaDonTamTinhBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_HoaDonTamTinhBindingSource
            // 
            this.PROC_HoaDonTamTinhBindingSource.DataMember = "PROC_HoaDonTamTinh";
            this.PROC_HoaDonTamTinhBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DataSetReportHoaDonTamTinh";
            reportDataSource1.Value = this.PROC_HoaDonTamTinhBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportHoaDonTamTinh.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(461, 298);
            this.reportViewer1.TabIndex = 0;
            // 
            // PROC_HoaDonTamTinhTableAdapter
            // 
            this.PROC_HoaDonTamTinhTableAdapter.ClearBeforeFill = true;
            // 
            // FrmReportHoaDonTamTinh
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(461, 298);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportHoaDonTamTinh";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmReportHoaDonTamTinh";
            this.Load += new System.EventHandler(this.FrmReportHoaDonTamTinh_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_HoaDonTamTinhBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource PROC_HoaDonTamTinhBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.PROC_HoaDonTamTinhTableAdapter PROC_HoaDonTamTinhTableAdapter;
    }
}