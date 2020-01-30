using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;

namespace Kutuphane
{
    class PostgresSql
    {
        List<string> dataItems = new List<string>();

        public DataTable KisiGetir()
        {

            string baglantiYazisi = "Server = 127.0.0.1; Port = 5432; User Id = postgres; Password = habibullah; Database = Kutuphane";
            NpgsqlConnection baglanti = new NpgsqlConnection(baglantiYazisi);
            baglanti.Open();
            
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("SELECT * FROM KisiGetir()", baglanti);
            DataTable dt = new DataTable();

            da.Fill(dt);
            
            baglanti.Close();
            return dt;

        }

        public void KisiEkle()
        {
            string baglantiYazisi = "Server = 127.0.0.1; Port = 5432; User Id = postgres; Password = habibullah; Database = Kutuphane";
            NpgsqlConnection baglanti = new NpgsqlConnection(baglantiYazisi);
            baglanti.Open();

            NpgsqlDataAdapter da = new NpgsqlDataAdapter("SELECT * FROM KisiEkle()", baglanti);
            baglanti.Close();
        }
        
    }
}
