using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Kutuphane
{
    public partial class KisiEkle : Form
    {
        public KisiEkle()
        {
            InitializeComponent();
        }

        private void EklemeButonu_Click(object sender, EventArgs e)
        {
            PostgresSql ekle = new PostgresSql();
            
        }
    }
}
