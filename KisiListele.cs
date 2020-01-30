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
    public partial class KisiListele : Form
    {
        List<string> dataItems = new List<string>();
        DataTable tablo = new DataTable();
        
        public KisiListele()
        {
            InitializeComponent();
        }

        private void KisiListele_Load(object sender, EventArgs e)
        {
            PostgresSql listele = new PostgresSql();
            DataTable dt = new DataTable();
            dt = listele.KisiGetir();

            Getir.DataSource = dt;

        }
    }
}
