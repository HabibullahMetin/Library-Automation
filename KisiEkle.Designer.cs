namespace Kutuphane
{
    partial class KisiEkle
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
            this.Ekle = new System.Windows.Forms.DataGridView();
            this.Ad = new System.Windows.Forms.Label();
            this.Soyad = new System.Windows.Forms.Label();
            this.Adres = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.EklemeButonu = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.Ekle)).BeginInit();
            this.SuspendLayout();
            // 
            // Ekle
            // 
            this.Ekle.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.Ekle.Location = new System.Drawing.Point(-2, -2);
            this.Ekle.Name = "Ekle";
            this.Ekle.Size = new System.Drawing.Size(802, 460);
            this.Ekle.TabIndex = 0;
            // 
            // Ad
            // 
            this.Ad.AutoSize = true;
            this.Ad.Font = new System.Drawing.Font("Microsoft Sans Serif", 50F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.Ad.Location = new System.Drawing.Point(77, 37);
            this.Ad.Name = "Ad";
            this.Ad.Size = new System.Drawing.Size(115, 76);
            this.Ad.TabIndex = 1;
            this.Ad.Text = "Ad";
            // 
            // Soyad
            // 
            this.Soyad.AutoSize = true;
            this.Soyad.Font = new System.Drawing.Font("Microsoft Sans Serif", 50F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.Soyad.Location = new System.Drawing.Point(77, 143);
            this.Soyad.Name = "Soyad";
            this.Soyad.Size = new System.Drawing.Size(223, 76);
            this.Soyad.TabIndex = 2;
            this.Soyad.Text = "Soyad";
            // 
            // Adres
            // 
            this.Adres.AutoSize = true;
            this.Adres.Font = new System.Drawing.Font("Microsoft Sans Serif", 50F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.Adres.Location = new System.Drawing.Point(77, 257);
            this.Adres.Name = "Adres";
            this.Adres.Size = new System.Drawing.Size(208, 76);
            this.Adres.TabIndex = 3;
            this.Adres.Text = "Adres";
            // 
            // textBox1
            // 
            this.textBox1.BackColor = System.Drawing.Color.White;
            this.textBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 50F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.textBox1.Location = new System.Drawing.Point(331, 30);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(224, 83);
            this.textBox1.TabIndex = 4;
            // 
            // textBox2
            // 
            this.textBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 50F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.textBox2.Location = new System.Drawing.Point(331, 143);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(224, 83);
            this.textBox2.TabIndex = 5;
            // 
            // textBox3
            // 
            this.textBox3.Font = new System.Drawing.Font("Microsoft Sans Serif", 100F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.textBox3.Location = new System.Drawing.Point(331, 257);
            this.textBox3.Multiline = true;
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(224, 76);
            this.textBox3.TabIndex = 6;
            // 
            // EklemeButonu
            // 
            this.EklemeButonu.Location = new System.Drawing.Point(331, 363);
            this.EklemeButonu.Name = "EklemeButonu";
            this.EklemeButonu.Size = new System.Drawing.Size(224, 75);
            this.EklemeButonu.TabIndex = 7;
            this.EklemeButonu.Text = "Ekle";
            this.EklemeButonu.UseVisualStyleBackColor = true;
            this.EklemeButonu.Click += new System.EventHandler(this.EklemeButonu_Click);
            // 
            // KisiEkle
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.EklemeButonu);
            this.Controls.Add(this.textBox3);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.Adres);
            this.Controls.Add(this.Soyad);
            this.Controls.Add(this.Ad);
            this.Controls.Add(this.Ekle);
            this.Name = "KisiEkle";
            this.Text = "KisiEkle";
            ((System.ComponentModel.ISupportInitialize)(this.Ekle)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView Ekle;
        private System.Windows.Forms.Label Ad;
        private System.Windows.Forms.Label Soyad;
        private System.Windows.Forms.Label Adres;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Button EklemeButonu;
    }
}