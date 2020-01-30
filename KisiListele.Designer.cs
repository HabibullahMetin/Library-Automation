namespace Kutuphane
{
    partial class KisiListele
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
            this.Getir = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.Getir)).BeginInit();
            this.SuspendLayout();
            // 
            // Getir
            // 
            this.Getir.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.Getir.Location = new System.Drawing.Point(2, 0);
            this.Getir.Name = "Getir";
            this.Getir.Size = new System.Drawing.Size(807, 452);
            this.Getir.TabIndex = 0;
            // 
            // KisiListele
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.Getir);
            this.Name = "KisiListele";
            this.Text = "KisiListele";
            this.Load += new System.EventHandler(this.KisiListele_Load);
            ((System.ComponentModel.ISupportInitialize)(this.Getir)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView Getir;
    }
}