namespace DOAN
{
    partial class FrmReportThongKeDoanhThu
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
            this.PROC_DoanhThuTuNgayToiNgayBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.PROC_DoanhThuTuNgayToiNgayTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_DoanhThuTuNgayToiNgayTableAdapter();
            this.dtpFromDay = new System.Windows.Forms.DateTimePicker();
            this.dtpToDay = new System.Windows.Forms.DateTimePicker();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.labelDenNgay = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.labelTuNgay = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.labeltoday = new System.Windows.Forms.Label();
            this.labelfromday = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_DoanhThuTuNgayToiNgayBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_DoanhThuTuNgayToiNgayBindingSource
            // 
            this.PROC_DoanhThuTuNgayToiNgayBindingSource.DataMember = "PROC_DoanhThuTuNgayToiNgay";
            this.PROC_DoanhThuTuNgayToiNgayBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DataSetReportThongKeDoanhThu";
            reportDataSource1.Value = this.PROC_DoanhThuTuNgayToiNgayBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportThongKeDoanhThu.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(786, 333);
            this.reportViewer1.TabIndex = 0;
            // 
            // PROC_DoanhThuTuNgayToiNgayTableAdapter
            // 
            this.PROC_DoanhThuTuNgayToiNgayTableAdapter.ClearBeforeFill = true;
            // 
            // dtpFromDay
            // 
            this.dtpFromDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpFromDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFromDay.Location = new System.Drawing.Point(676, 168);
            this.dtpFromDay.Name = "dtpFromDay";
            this.dtpFromDay.Size = new System.Drawing.Size(98, 20);
            this.dtpFromDay.TabIndex = 1;
            // 
            // dtpToDay
            // 
            this.dtpToDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpToDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpToDay.Location = new System.Drawing.Point(676, 229);
            this.dtpToDay.Name = "dtpToDay";
            this.dtpToDay.Size = new System.Drawing.Size(98, 20);
            this.dtpToDay.TabIndex = 2;
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(676, 284);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(98, 37);
            this.btnLoadData.TabIndex = 3;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // labelDenNgay
            // 
            this.labelDenNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelDenNgay.AutoSize = true;
            this.labelDenNgay.BackColor = System.Drawing.Color.White;
            this.labelDenNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDenNgay.Location = new System.Drawing.Point(684, 83);
            this.labelDenNgay.Name = "labelDenNgay";
            this.labelDenNgay.Size = new System.Drawing.Size(45, 19);
            this.labelDenNgay.TabIndex = 22;
            this.labelDenNgay.Text = "????";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.White;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(574, 83);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(94, 19);
            this.label3.TabIndex = 21;
            this.label3.Text = "đến ngày :";
            // 
            // labelTuNgay
            // 
            this.labelTuNgay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelTuNgay.AutoSize = true;
            this.labelTuNgay.BackColor = System.Drawing.Color.White;
            this.labelTuNgay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTuNgay.Location = new System.Drawing.Point(684, 52);
            this.labelTuNgay.Name = "labelTuNgay";
            this.labelTuNgay.Size = new System.Drawing.Size(45, 19);
            this.labelTuNgay.TabIndex = 20;
            this.labelTuNgay.Text = "????";
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.Color.White;
            this.label4.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(367, 52);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(301, 19);
            this.label4.TabIndex = 19;
            this.label4.Text = "Thời gian thống kê dữ liệu từ ngày :";
            // 
            // label5
            // 
            this.label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label5.AutoSize = true;
            this.label5.BackColor = System.Drawing.Color.White;
            this.label5.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(492, 127);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(282, 19);
            this.label5.TabIndex = 18;
            this.label5.Text = "Chọn thời gian cần xem thống kê ";
            // 
            // labeltoday
            // 
            this.labeltoday.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labeltoday.AutoSize = true;
            this.labeltoday.BackColor = System.Drawing.Color.White;
            this.labeltoday.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labeltoday.Location = new System.Drawing.Point(672, 207);
            this.labeltoday.Name = "labeltoday";
            this.labeltoday.Size = new System.Drawing.Size(46, 19);
            this.labeltoday.TabIndex = 17;
            this.labeltoday.Text = "Đến :";
            // 
            // labelfromday
            // 
            this.labelfromday.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelfromday.AutoSize = true;
            this.labelfromday.BackColor = System.Drawing.Color.White;
            this.labelfromday.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelfromday.Location = new System.Drawing.Point(672, 146);
            this.labelfromday.Name = "labelfromday";
            this.labelfromday.Size = new System.Drawing.Size(38, 19);
            this.labelfromday.TabIndex = 16;
            this.labelfromday.Text = "Từ :";
            // 
            // FrmReportThongKeDoanhThu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(786, 333);
            this.Controls.Add(this.labelDenNgay);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.labelTuNgay);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.labeltoday);
            this.Controls.Add(this.labelfromday);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.dtpToDay);
            this.Controls.Add(this.dtpFromDay);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportThongKeDoanhThu";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmReportThongKeDoanhThu";
            this.Load += new System.EventHandler(this.FrmReportThongKeDoanhThu_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_DoanhThuTuNgayToiNgayBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource PROC_DoanhThuTuNgayToiNgayBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.PROC_DoanhThuTuNgayToiNgayTableAdapter PROC_DoanhThuTuNgayToiNgayTableAdapter;
        private System.Windows.Forms.DateTimePicker dtpFromDay;
        private System.Windows.Forms.DateTimePicker dtpToDay;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.Label labelDenNgay;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label labelTuNgay;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label labeltoday;
        private System.Windows.Forms.Label labelfromday;
    }
}