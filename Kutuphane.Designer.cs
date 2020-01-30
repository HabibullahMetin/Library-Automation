namespace Kutuphane
{
    partial class Kutuphane
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
            this.KisiGetir = new System.Windows.Forms.Button();
            this.KisiEkle = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // KisiGetir
            // 
            this.KisiGetir.Location = new System.Drawing.Point(230, 57);
            this.KisiGetir.Name = "KisiGetir";
            this.KisiGetir.Size = new System.Drawing.Size(245, 92);
            this.KisiGetir.TabIndex = 0;
            this.KisiGetir.Text = "KişiGetir";
            this.KisiGetir.UseVisualStyleBackColor = true;
            this.KisiGetir.Click += new System.EventHandler(this.KisiGetir_Click);
            // 
            // KisiEkle
            // 
            this.KisiEkle.Location = new System.Drawing.Point(230, 199);
            this.KisiEkle.Name = "KisiEkle";
            this.KisiEkle.Size = new System.Drawing.Size(245, 97);
            this.KisiEkle.TabIndex = 1;
            this.KisiEkle.Text = "KişiEkle";
            this.KisiEkle.UseVisualStyleBackColor = true;
            this.KisiEkle.Click += new System.EventHandler(this.KisiEkle_Click);
            // 
            // Kutuphane
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.KisiEkle);
            this.Controls.Add(this.KisiGetir);
            this.Name = "Kutuphane";
            this.Text = "Kütüphane";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button KisiGetir;
        private System.Windows.Forms.Button KisiEkle;
    }
}

