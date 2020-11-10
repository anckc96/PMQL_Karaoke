namespace DOAN
{
    partial class FrmReportSoLuongSPBanTrongNgay
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
            this.PROC_SoLuongSPBanTrongNgayBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.PROC_SoLuongSPBanTrongNgayTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_SoLuongSPBanTrongNgayTableAdapter();
            this.dtpNgay = new System.Windows.Forms.DateTimePicker();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.labelNgay = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_SoLuongSPBanTrongNgayBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_SoLuongSPBanTrongNgayBindingSource
            // 
            this.PROC_SoLuongSPBanTrongNgayBindingSource.DataMember = "PROC_SoLuongSPBanTrongNgay";
            this.PROC_SoLuongSPBanTrongNgayBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DataSetReportSLSPBanTrongNgay";
            reportDataSource1.Value = this.PROC_SoLuongSPBanTrongNgayBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportSLSPBanTrongNgay.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(959, 213);
            this.reportViewer1.TabIndex = 0;
            // 
            // PROC_SoLuongSPBanTrongNgayTableAdapter
            // 
            this.PROC_SoLuongSPBanTrongNgayTableAdapter.ClearBeforeFill = true;
            // 
            // dtpNgay
            // 
            this.dtpNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpNgay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpNgay.Location = new System.Drawing.Point(809, 80);
            this.dtpNgay.Name = "dtpNgay";
            this.dtpNgay.Size = new System.Drawing.Size(106, 20);
            this.dtpNgay.TabIndex = 1;
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(809, 124);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(106, 35);
            this.btnLoadData.TabIndex = 2;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.White;
            this.label1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(515, 80);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(288, 19);
            this.label1.TabIndex = 3;
            this.label1.Text = "Chọn thời gian cần xem thống kê :";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.White;
            this.label2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(569, 40);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(234, 19);
            this.label2.TabIndex = 4;
            this.label2.Text = "Thời gian thống kê dữ liệu :";
            // 
            // labelNgay
            // 
            this.labelNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelNgay.AutoSize = true;
            this.labelNgay.BackColor = System.Drawing.Color.White;
            this.labelNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNgay.Location = new System.Drawing.Point(823, 40);
            this.labelNgay.Name = "labelNgay";
            this.labelNgay.Size = new System.Drawing.Size(45, 19);
            this.labelNgay.TabIndex = 5;
            this.labelNgay.Text = "????";
            // 
            // FrmReportSoLuongSPBanTrongNgay
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(959, 213);
            this.Controls.Add(this.labelNgay);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.dtpNgay);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportSoLuongSPBanTrongNgay";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmReportSoLuongSPBanTrongNgay";
            this.Load += new System.EventHandler(this.FrmReportSoLuongSPBanTrongNgay_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_SoLuongSPBanTrongNgayBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource PROC_SoLuongSPBanTrongNgayBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.PROC_SoLuongSPBanTrongNgayTableAdapter PROC_SoLuongSPBanTrongNgayTableAdapter;
        private System.Windows.Forms.DateTimePicker dtpNgay;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label labelNgay;
    }
}