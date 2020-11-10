namespace DOAN
{
    partial class frmThongKeSoLuongTonSP
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.PROC_SoLuongSPBanTheoNgayBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.QLPM_KaraokeDataSet = new DOAN.QLPM_KaraokeDataSet();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.btnLoadData = new DevExpress.XtraEditors.SimpleButton();
            this.labelSLTSP = new System.Windows.Forms.Label();
            this.txtSoLuongTonSP = new System.Windows.Forms.TextBox();
            this.dgvThongKeSLTSP = new System.Windows.Forms.DataGridView();
            this.colMaDV = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colTenDV = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colDVT = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colGiaNhap = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colGiaBan = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colSL = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colMoTa = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colLoaiDVThongKe = new System.Windows.Forms.DataGridViewComboBoxColumn();
            this.lbtitle = new System.Windows.Forms.Label();
            this.PROC_SoLuongSPBanTheoNgayTableAdapter = new DOAN.QLPM_KaraokeDataSetTableAdapters.PROC_SoLuongSPBanTheoNgayTableAdapter();
            ((System.ComponentModel.ISupportInitialize)(this.PROC_SoLuongSPBanTheoNgayBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvThongKeSLTSP)).BeginInit();
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
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.ProcessingMode = Microsoft.Reporting.WinForms.ProcessingMode.Remote;
            this.reportViewer1.ServerReport.ReportServerUrl = new System.Uri("", System.UriKind.Relative);
            this.reportViewer1.Size = new System.Drawing.Size(974, 353);
            this.reportViewer1.TabIndex = 11;
            // 
            // btnLoadData
            // 
            this.btnLoadData.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnLoadData.Location = new System.Drawing.Point(820, 301);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(142, 40);
            this.btnLoadData.TabIndex = 15;
            this.btnLoadData.Text = "Tải dữ liệu";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // labelSLTSP
            // 
            this.labelSLTSP.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.labelSLTSP.AutoSize = true;
            this.labelSLTSP.BackColor = System.Drawing.Color.White;
            this.labelSLTSP.Location = new System.Drawing.Point(817, 276);
            this.labelSLTSP.Name = "labelSLTSP";
            this.labelSLTSP.Size = new System.Drawing.Size(107, 13);
            this.labelSLTSP.TabIndex = 14;
            this.labelSLTSP.Text = "Số lượng tồn SP dưới";
            // 
            // txtSoLuongTonSP
            // 
            this.txtSoLuongTonSP.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.txtSoLuongTonSP.Location = new System.Drawing.Point(935, 273);
            this.txtSoLuongTonSP.Name = "txtSoLuongTonSP";
            this.txtSoLuongTonSP.Size = new System.Drawing.Size(27, 20);
            this.txtSoLuongTonSP.TabIndex = 13;
            // 
            // dgvThongKeSLTSP
            // 
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.Red;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.Yellow;
            this.dgvThongKeSLTSP.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvThongKeSLTSP.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvThongKeSLTSP.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvThongKeSLTSP.BackgroundColor = System.Drawing.Color.White;
            this.dgvThongKeSLTSP.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvThongKeSLTSP.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.colMaDV,
            this.colTenDV,
            this.colDVT,
            this.colGiaNhap,
            this.colGiaBan,
            this.colSL,
            this.colMoTa,
            this.colLoaiDVThongKe});
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 8.25F);
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(31)))), ((int)(((byte)(53)))));
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.Red;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.Yellow;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvThongKeSLTSP.DefaultCellStyle = dataGridViewCellStyle2;
            this.dgvThongKeSLTSP.Location = new System.Drawing.Point(12, 80);
            this.dgvThongKeSLTSP.Name = "dgvThongKeSLTSP";
            this.dgvThongKeSLTSP.ReadOnly = true;
            this.dgvThongKeSLTSP.RowHeadersVisible = false;
            this.dgvThongKeSLTSP.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvThongKeSLTSP.Size = new System.Drawing.Size(799, 261);
            this.dgvThongKeSLTSP.TabIndex = 12;
            // 
            // colMaDV
            // 
            this.colMaDV.DataPropertyName = "MaDV";
            this.colMaDV.FillWeight = 30F;
            this.colMaDV.HeaderText = "Mã Sản Phẩm";
            this.colMaDV.Name = "colMaDV";
            this.colMaDV.ReadOnly = true;
            // 
            // colTenDV
            // 
            this.colTenDV.DataPropertyName = "TenDV";
            this.colTenDV.FillWeight = 30F;
            this.colTenDV.HeaderText = "Tên Sản Phẩm";
            this.colTenDV.Name = "colTenDV";
            this.colTenDV.ReadOnly = true;
            // 
            // colDVT
            // 
            this.colDVT.DataPropertyName = "DonViTinh";
            this.colDVT.FillWeight = 30F;
            this.colDVT.HeaderText = "Đơn Vị Tính";
            this.colDVT.Name = "colDVT";
            this.colDVT.ReadOnly = true;
            // 
            // colGiaNhap
            // 
            this.colGiaNhap.DataPropertyName = "DonGiaNhap";
            this.colGiaNhap.FillWeight = 30F;
            this.colGiaNhap.HeaderText = "Giá Nhập";
            this.colGiaNhap.Name = "colGiaNhap";
            this.colGiaNhap.ReadOnly = true;
            // 
            // colGiaBan
            // 
            this.colGiaBan.DataPropertyName = "DonGiaBan";
            this.colGiaBan.FillWeight = 30F;
            this.colGiaBan.HeaderText = "Giá Bán";
            this.colGiaBan.Name = "colGiaBan";
            this.colGiaBan.ReadOnly = true;
            // 
            // colSL
            // 
            this.colSL.DataPropertyName = "SoLuong";
            this.colSL.FillWeight = 30F;
            this.colSL.HeaderText = "Số Lượng";
            this.colSL.Name = "colSL";
            this.colSL.ReadOnly = true;
            // 
            // colMoTa
            // 
            this.colMoTa.DataPropertyName = "MoTa";
            this.colMoTa.FillWeight = 30F;
            this.colMoTa.HeaderText = "Mô Tả";
            this.colMoTa.Name = "colMoTa";
            this.colMoTa.ReadOnly = true;
            // 
            // colLoaiDVThongKe
            // 
            this.colLoaiDVThongKe.DataPropertyName = "MaLoaiDV";
            this.colLoaiDVThongKe.DisplayStyle = System.Windows.Forms.DataGridViewComboBoxDisplayStyle.Nothing;
            this.colLoaiDVThongKe.FillWeight = 30F;
            this.colLoaiDVThongKe.HeaderText = "Loại Sản Phẩm";
            this.colLoaiDVThongKe.Name = "colLoaiDVThongKe";
            this.colLoaiDVThongKe.ReadOnly = true;
            this.colLoaiDVThongKe.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.colLoaiDVThongKe.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            // 
            // lbtitle
            // 
            this.lbtitle.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lbtitle.AutoSize = true;
            this.lbtitle.BackColor = System.Drawing.Color.White;
            this.lbtitle.Font = new System.Drawing.Font("Tahoma", 20.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbtitle.Location = new System.Drawing.Point(166, 41);
            this.lbtitle.Name = "lbtitle";
            this.lbtitle.Size = new System.Drawing.Size(533, 33);
            this.lbtitle.TabIndex = 16;
            this.lbtitle.Text = "THỐNG KÊ SỐ LƯỢNG TỒN SẢN PHẨM";
            // 
            // PROC_SoLuongSPBanTheoNgayTableAdapter
            // 
            this.PROC_SoLuongSPBanTheoNgayTableAdapter.ClearBeforeFill = true;
            // 
            // frmThongKeSoLuongTonSP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(974, 353);
            this.Controls.Add(this.lbtitle);
            this.Controls.Add(this.btnLoadData);
            this.Controls.Add(this.labelSLTSP);
            this.Controls.Add(this.txtSoLuongTonSP);
            this.Controls.Add(this.dgvThongKeSLTSP);
            this.Controls.Add(this.reportViewer1);
            this.Name = "frmThongKeSoLuongTonSP";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Thống kê số lượng tồn";
            this.Load += new System.EventHandler(this.frmThongKeSoLuongTonSP_Load);
            ((System.ComponentModel.ISupportInitialize)(this.PROC_SoLuongSPBanTheoNgayBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.QLPM_KaraokeDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvThongKeSLTSP)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private DevExpress.XtraEditors.SimpleButton btnLoadData;
        private System.Windows.Forms.Label labelSLTSP;
        private System.Windows.Forms.TextBox txtSoLuongTonSP;
        private System.Windows.Forms.DataGridView dgvThongKeSLTSP;
        private System.Windows.Forms.Label lbtitle;
        private QLPM_KaraokeDataSet QLPM_KaraokeDataSet;
        private System.Windows.Forms.BindingSource PROC_SoLuongSPBanTheoNgayBindingSource;
        private QLPM_KaraokeDataSetTableAdapters.PROC_SoLuongSPBanTheoNgayTableAdapter PROC_SoLuongSPBanTheoNgayTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn colMaDV;
        private System.Windows.Forms.DataGridViewTextBoxColumn colTenDV;
        private System.Windows.Forms.DataGridViewTextBoxColumn colDVT;
        private System.Windows.Forms.DataGridViewTextBoxColumn colGiaNhap;
        private System.Windows.Forms.DataGridViewTextBoxColumn colGiaBan;
        private System.Windows.Forms.DataGridViewTextBoxColumn colSL;
        private System.Windows.Forms.DataGridViewTextBoxColumn colMoTa;
        private System.Windows.Forms.DataGridViewComboBoxColumn colLoaiDVThongKe;
    

    }
}