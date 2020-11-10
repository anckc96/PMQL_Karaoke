namespace DOAN
{
    partial class FrmReportSoLuongSPBan
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
            this.PROC_SoLuongSPBanTheoNgayBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.labeltoday = new System.Windows.Forms.Label();
            this.labelfromday = new System.Windows.Forms.Label();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.dtpToDay = new System.Windows.Forms.DateTimePicker();
            this.dtpFromDay = new System.Windows.Forms.DateTimePicker();
            this.PROC_SoLuongSPBanTheoNgayTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_SoLuongSPBanTheoNgayTableAdapter();
            this.labelTuNgay = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.labelDenNgay = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_SoLuongSPBanTheoNgayBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_SoLuongSPBanTheoNgayBindingSource
            // 
            this.PROC_SoLuongSPBanTheoNgayBindingSource.DataMember = "PROC_SoLuongSPBanTheoNgay";
            this.PROC_SoLuongSPBanTheoNgayBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DataSetSoLuongSPBanTheoNgay";
            reportDataSource1.Value = this.PROC_SoLuongSPBanTheoNgayBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportSLSPBanTheoNgay.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(962, 336);
            this.reportViewer1.TabIndex = 0;
            // 
            // labeltoday
            // 
            this.labeltoday.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labeltoday.AutoSize = true;
            this.labeltoday.BackColor = System.Drawing.Color.White;
            this.labeltoday.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labeltoday.Location = new System.Drawing.Point(824, 210);
            this.labeltoday.Name = "labeltoday";
            this.labeltoday.Size = new System.Drawing.Size(46, 19);
            this.labeltoday.TabIndex = 10;
            this.labeltoday.Text = "Đến :";
            // 
            // labelfromday
            // 
            this.labelfromday.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelfromday.AutoSize = true;
            this.labelfromday.BackColor = System.Drawing.Color.White;
            this.labelfromday.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelfromday.Location = new System.Drawing.Point(824, 149);
            this.labelfromday.Name = "labelfromday";
            this.labelfromday.Size = new System.Drawing.Size(38, 19);
            this.labelfromday.TabIndex = 9;
            this.labelfromday.Text = "Từ :";
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(828, 281);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(94, 44);
            this.btnLoadData.TabIndex = 8;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // dtpToDay
            // 
            this.dtpToDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpToDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpToDay.Location = new System.Drawing.Point(828, 232);
            this.dtpToDay.Name = "dtpToDay";
            this.dtpToDay.Size = new System.Drawing.Size(94, 20);
            this.dtpToDay.TabIndex = 7;
            // 
            // dtpFromDay
            // 
            this.dtpFromDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpFromDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFromDay.Location = new System.Drawing.Point(828, 171);
            this.dtpFromDay.Name = "dtpFromDay";
            this.dtpFromDay.Size = new System.Drawing.Size(94, 20);
            this.dtpFromDay.TabIndex = 6;
            // 
            // PROC_SoLuongSPBanTheoNgayTableAdapter
            // 
            this.PROC_SoLuongSPBanTheoNgayTableAdapter.ClearBeforeFill = true;
            // 
            // labelTuNgay
            // 
            this.labelTuNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelTuNgay.AutoSize = true;
            this.labelTuNgay.BackColor = System.Drawing.Color.White;
            this.labelTuNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTuNgay.Location = new System.Drawing.Point(805, 39);
            this.labelTuNgay.Name = "labelTuNgay";
            this.labelTuNgay.Size = new System.Drawing.Size(45, 19);
            this.labelTuNgay.TabIndex = 13;
            this.labelTuNgay.Text = "????";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.White;
            this.label2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(488, 39);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(301, 19);
            this.label2.TabIndex = 12;
            this.label2.Text = "Thời gian thống kê dữ liệu từ ngày :";
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.White;
            this.label1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(647, 118);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(282, 19);
            this.label1.TabIndex = 11;
            this.label1.Text = "Chọn thời gian cần xem thống kê ";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.White;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(695, 70);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(94, 19);
            this.label3.TabIndex = 14;
            this.label3.Text = "đến ngày :";
            // 
            // labelDenNgay
            // 
            this.labelDenNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelDenNgay.AutoSize = true;
            this.labelDenNgay.BackColor = System.Drawing.Color.White;
            this.labelDenNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDenNgay.Location = new System.Drawing.Point(805, 70);
            this.labelDenNgay.Name = "labelDenNgay";
            this.labelDenNgay.Size = new System.Drawing.Size(45, 19);
            this.labelDenNgay.TabIndex = 15;
            this.labelDenNgay.Text = "????";
            // 
            // FrmReportSoLuongSPBan
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(962, 336);
            this.Controls.Add(this.labelDenNgay);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.labelTuNgay);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.labeltoday);
            this.Controls.Add(this.labelfromday);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.dtpToDay);
            this.Controls.Add(this.dtpFromDay);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportSoLuongSPBan";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Thống kê số lượng sản phẩm bán";
            this.Load += new System.EventHandler(this.FrmReportSoLuongSPBan_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_SoLuongSPBanTheoNgayBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.Label labeltoday;
        private System.Windows.Forms.Label labelfromday;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.DateTimePicker dtpToDay;
        private System.Windows.Forms.DateTimePicker dtpFromDay;
        private System.Windows.Forms.BindingSource PROC_SoLuongSPBanTheoNgayBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.PROC_SoLuongSPBanTheoNgayTableAdapter PROC_SoLuongSPBanTheoNgayTableAdapter;
        private System.Windows.Forms.Label labelTuNgay;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label labelDenNgay;
    }
}