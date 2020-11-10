namespace DOAN
{
    partial class FrmReportThongKeDoanhThuTheoThang
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
            this.PROC_DoanhThuTheoThangBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.PROC_DoanhThuTheoThangTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_DoanhThuTheoThangTableAdapter();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.dtpThang = new System.Windows.Forms.DateTimePicker();
            this.labelNgay = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_DoanhThuTheoThangBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_DoanhThuTheoThangBindingSource
            // 
            this.PROC_DoanhThuTheoThangBindingSource.DataMember = "PROC_DoanhThuTheoThang";
            this.PROC_DoanhThuTheoThangBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DataSetReportThongKeDoanhThuTheoThang";
            reportDataSource1.Value = this.PROC_DoanhThuTheoThangBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportThongKeDoanhThuTheoThang.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(826, 326);
            this.reportViewer1.TabIndex = 0;
            // 
            // PROC_DoanhThuTheoThangTableAdapter
            // 
            this.PROC_DoanhThuTheoThangTableAdapter.ClearBeforeFill = true;
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(709, 141);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(85, 35);
            this.btnLoadData.TabIndex = 2;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // dtpThang
            // 
            this.dtpThang.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpThang.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpThang.Location = new System.Drawing.Point(709, 100);
            this.dtpThang.Name = "dtpThang";
            this.dtpThang.Size = new System.Drawing.Size(85, 20);
            this.dtpThang.TabIndex = 1;
            // 
            // labelNgay
            // 
            this.labelNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelNgay.AutoSize = true;
            this.labelNgay.BackColor = System.Drawing.Color.White;
            this.labelNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNgay.Location = new System.Drawing.Point(712, 48);
            this.labelNgay.Name = "labelNgay";
            this.labelNgay.Size = new System.Drawing.Size(45, 19);
            this.labelNgay.TabIndex = 11;
            this.labelNgay.Text = "????";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.White;
            this.label2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(458, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(234, 19);
            this.label2.TabIndex = 10;
            this.label2.Text = "Thời gian thống kê dữ liệu :";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.White;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(404, 100);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(288, 19);
            this.label3.TabIndex = 9;
            this.label3.Text = "Chọn thời gian cần xem thống kê :";
            // 
            // FrmReportThongKeDoanhThuTheoThang
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(826, 326);
            this.Controls.Add(this.labelNgay);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.dtpThang);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportThongKeDoanhThuTheoThang";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmReportThongKeDoanhThuTheoThang";
            this.Load += new System.EventHandler(this.FrmReportThongKeDoanhThuTheoThang_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_DoanhThuTheoThangBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource PROC_DoanhThuTheoThangBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.PROC_DoanhThuTheoThangTableAdapter PROC_DoanhThuTheoThangTableAdapter;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.DateTimePicker dtpThang;
        private System.Windows.Forms.Label labelNgay;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
    }
}