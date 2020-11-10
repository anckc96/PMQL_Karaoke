namespace DOAN
{
    partial class FrmSoLuong
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
            this.label1 = new System.Windows.Forms.Label();
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.btnKhachTraLaiDV = new DevExpress.XtraEditors.SimpleButton();
            this.btnKhachGoiThemDV = new DevExpress.XtraEditors.SimpleButton();
            this.btnHuySoLuong = new DevExpress.XtraEditors.SimpleButton();
            this.txtSoLuong1 = new DevExpress.XtraEditors.TextEdit();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtSoLuong1.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(46, 43);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(76, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Nhập số lượng";
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.btnKhachTraLaiDV);
            this.groupControl1.Controls.Add(this.btnKhachGoiThemDV);
            this.groupControl1.Controls.Add(this.btnHuySoLuong);
            this.groupControl1.Controls.Add(this.txtSoLuong1);
            this.groupControl1.Controls.Add(this.label1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(315, 152);
            this.groupControl1.TabIndex = 3;
            this.groupControl1.Text = "Nhập số lượng";
            // 
            // btnKhachTraLaiDV
            // 
            this.btnKhachTraLaiDV.Location = new System.Drawing.Point(148, 82);
            this.btnKhachTraLaiDV.Name = "btnKhachTraLaiDV";
            this.btnKhachTraLaiDV.Size = new System.Drawing.Size(99, 36);
            this.btnKhachTraLaiDV.TabIndex = 5;
            this.btnKhachTraLaiDV.Text = "Trả lại";
            this.btnKhachTraLaiDV.Click += new System.EventHandler(this.btnKhachTraLaiDV_Click);
            // 
            // btnKhachGoiThemDV
            // 
            this.btnKhachGoiThemDV.Location = new System.Drawing.Point(49, 82);
            this.btnKhachGoiThemDV.Name = "btnKhachGoiThemDV";
            this.btnKhachGoiThemDV.Size = new System.Drawing.Size(93, 36);
            this.btnKhachGoiThemDV.TabIndex = 4;
            this.btnKhachGoiThemDV.Text = "Gọi thêm";
            this.btnKhachGoiThemDV.Click += new System.EventHandler(this.btnKhachGoiThemDV_Click);
            // 
            // btnHuySoLuong
            // 
            this.btnHuySoLuong.Location = new System.Drawing.Point(253, 82);
            this.btnHuySoLuong.Name = "btnHuySoLuong";
            this.btnHuySoLuong.Size = new System.Drawing.Size(50, 36);
            this.btnHuySoLuong.TabIndex = 3;
            this.btnHuySoLuong.Text = "Hủy";
            this.btnHuySoLuong.Click += new System.EventHandler(this.btnHuySoLuong_Click);
            // 
            // txtSoLuong1
            // 
            this.txtSoLuong1.Location = new System.Drawing.Point(167, 40);
            this.txtSoLuong1.Name = "txtSoLuong1";
            this.txtSoLuong1.Properties.MaxLength = 5;
            this.txtSoLuong1.Size = new System.Drawing.Size(116, 20);
            this.txtSoLuong1.TabIndex = 1;
            this.txtSoLuong1.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtSoLuong1_KeyPress);
            // 
            // FrmSoLuong
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(315, 152);
            this.Controls.Add(this.groupControl1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FrmSoLuong";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Số lượng";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.FrmSoLuong_KeyDown);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            this.groupControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtSoLuong1.Properties)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private DevExpress.XtraEditors.GroupControl groupControl1;
        private DevExpress.XtraEditors.TextEdit txtSoLuong1;
        private DevExpress.XtraEditors.SimpleButton btnHuySoLuong;
        private DevExpress.XtraEditors.SimpleButton btnKhachTraLaiDV;
        private DevExpress.XtraEditors.SimpleButton btnKhachGoiThemDV;
    }
}