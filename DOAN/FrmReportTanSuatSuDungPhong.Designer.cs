namespace DOAN
{
    partial class FrmReportTanSuatSuDungPhong
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
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource4 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.PROC_ThongKeTanSuatSuDungPhongBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.PROC_ThongKeTanSuatSuDungPhongTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_ThongKeTanSuatSuDungPhongTableAdapter();
            this.labelTuNgay = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.dtpFromDay = new System.Windows.Forms.DateTimePicker();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_ThongKeTanSuatSuDungPhongBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_ThongKeTanSuatSuDungPhongBindingSource
            // 
            this.PROC_ThongKeTanSuatSuDungPhongBindingSource.DataMember = "PROC_ThongKeTanSuatSuDungPhong";
            this.PROC_ThongKeTanSuatSuDungPhongBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource4.Name = "DataSetReportTanSuatSuDungPhong";
            reportDataSource4.Value = this.PROC_ThongKeTanSuatSuDungPhongBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource4);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportTanSuatSuDungPhong.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(796, 385);
            this.reportViewer1.TabIndex = 0;
            // 
            // PROC_ThongKeTanSuatSuDungPhongTableAdapter
            // 
            this.PROC_ThongKeTanSuatSuDungPhongTableAdapter.ClearBeforeFill = true;
            // 
            // labelTuNgay
            // 
            this.labelTuNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelTuNgay.AutoSize = true;
            this.labelTuNgay.BackColor = System.Drawing.Color.White;
            this.labelTuNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTuNgay.Location = new System.Drawing.Point(707, 52);
            this.labelTuNgay.Name = "labelTuNgay";
            this.labelTuNgay.Size = new System.Drawing.Size(45, 19);
            this.labelTuNgay.TabIndex = 26;
            this.labelTuNgay.Text = "????";
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.Color.White;
            this.label4.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(390, 52);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(234, 19);
            this.label4.TabIndex = 25;
            this.label4.Text = "Thời gian thống kê dữ liệu :";
            // 
            // label5
            // 
            this.label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label5.AutoSize = true;
            this.label5.BackColor = System.Drawing.Color.White;
            this.label5.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(481, 111);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(282, 19);
            this.label5.TabIndex = 24;
            this.label5.Text = "Chọn thời gian cần xem thống kê ";
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(654, 214);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(98, 37);
            this.btnLoadData.TabIndex = 22;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // dtpFromDay
            // 
            this.dtpFromDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpFromDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFromDay.Location = new System.Drawing.Point(654, 161);
            this.dtpFromDay.Name = "dtpFromDay";
            this.dtpFromDay.Size = new System.Drawing.Size(98, 20);
            this.dtpFromDay.TabIndex = 21;
            // 
            // FrmReportTanSuatSuDungPhong
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(796, 385);
            this.Controls.Add(this.labelTuNgay);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.dtpFromDay);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportTanSuatSuDungPhong";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmReportTanSuatSuDungPhong";
            this.Load += new System.EventHandler(this.FrmReportTanSuatSuDungPhong_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_ThongKeTanSuatSuDungPhongBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource PROC_ThongKeTanSuatSuDungPhongBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.PROC_ThongKeTanSuatSuDungPhongTableAdapter PROC_ThongKeTanSuatSuDungPhongTableAdapter;
        private System.Windows.Forms.Label labelTuNgay;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.DateTimePicker dtpFromDay;
    }
}