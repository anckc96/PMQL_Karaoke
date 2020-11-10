namespace DOAN
{
    partial class FrmReportLichSuThaoTac
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
            this.PROC_FilterLichSuThaoTacBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.dtpFromDay = new System.Windows.Forms.DateTimePicker();
            this.dtpToDay = new System.Windows.Forms.DateTimePicker();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.VIEW_LichSuThaoTacBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.VIEW_LichSuThaoTacTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.VIEW_LichSuThaoTacTableAdapter();
            this.PROC_FilterLichSuThaoTacTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_FilterLichSuThaoTacTableAdapter();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_FilterLichSuThaoTacBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.VIEW_LichSuThaoTacBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // PROC_FilterLichSuThaoTacBindingSource
            // 
            this.PROC_FilterLichSuThaoTacBindingSource.DataMember = "PROC_FilterLichSuThaoTac";
            this.PROC_FilterLichSuThaoTacBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // QLPM_KaraokeDataSet
            // 
            this.QLPM_KaraokeDataSet.DataSetName = "QLPM_KaraokeDataSet";
            this.QLPM_KaraokeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DataSetFilterLichSuThaoTac";
            reportDataSource1.Value = this.PROC_FilterLichSuThaoTacBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "DOAN.DataSetReportFilterLichSuThaoTac.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(986, 327);
            this.reportViewer1.TabIndex = 0;
            // 
            // dtpFromDay
            // 
            this.dtpFromDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpFromDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFromDay.Location = new System.Drawing.Point(872, 100);
            this.dtpFromDay.Name = "dtpFromDay";
            this.dtpFromDay.Size = new System.Drawing.Size(94, 20);
            this.dtpFromDay.TabIndex = 1;
            // 
            // dtpToDay
            // 
            this.dtpToDay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpToDay.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpToDay.Location = new System.Drawing.Point(872, 170);
            this.dtpToDay.Name = "dtpToDay";
            this.dtpToDay.Size = new System.Drawing.Size(94, 20);
            this.dtpToDay.TabIndex = 2;
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(872, 217);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(94, 44);
            this.btnLoadData.TabIndex = 3;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // VIEW_LichSuThaoTacBindingSource
            // 
            this.VIEW_LichSuThaoTacBindingSource.DataMember = "VIEW_LichSuThaoTac";
            this.VIEW_LichSuThaoTacBindingSource.DataSource = this.QLPM_KaraokeDataSet;
            // 
            // VIEW_LichSuThaoTacTableAdapter
            // 
            this.VIEW_LichSuThaoTacTableAdapter.ClearBeforeFill = true;
            // 
            // PROC_FilterLichSuThaoTacTableAdapter
            // 
            this.PROC_FilterLichSuThaoTacTableAdapter.ClearBeforeFill = true;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.White;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(868, 148);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(46, 19);
            this.label1.TabIndex = 12;
            this.label1.Text = "Đến :";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.White;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(868, 78);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(38, 19);
            this.label2.TabIndex = 11;
            this.label2.Text = "Từ :";
            // 
            // FrmReportLichSuThaoTac
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(986, 327);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.dtpToDay);
            this.Controls.Add(this.dtpFromDay);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReportLichSuThaoTac";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Xem Lịch Sử Thao Tác";
            this.Load += new System.EventHandler(this.FrmReportLichSuThaoTac_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_FilterLichSuThaoTacBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.VIEW_LichSuThaoTacBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource VIEW_LichSuThaoTacBindingSource;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private QLPM_KaraokeDataSetTableAdapters.VIEW_LichSuThaoTacTableAdapter VIEW_LichSuThaoTacTableAdapter;
        private System.Windows.Forms.DateTimePicker dtpFromDay;
        private System.Windows.Forms.DateTimePicker dtpToDay;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.BindingSource PROC_FilterLichSuThaoTacBindingSource;
        private QLPM_KaraokeDataSetTableAdapters.PROC_FilterLichSuThaoTacTableAdapter PROC_FilterLichSuThaoTacTableAdapter;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}