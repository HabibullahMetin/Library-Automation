using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
namespace Kutuphane
{
    public partial class Kutuphane : Form
    {
        List<string> dataItems = new List<string>();

        public Kutuphane()
        {
            InitializeComponent();
        }

        private void KisiGetir_Click(object sender, EventArgs e)
        {
            KisiListele liste = new KisiListele();
            liste.ShowDialog();
        }

        private void KisiEkle_Click(object sender, EventArgs e)
        {
            KisiEkle ekle = new KisiEkle();
            ekle.ShowDialog();
        }
    }
}
