using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanlyKARAOKE_DAO
{
    public class DataProvider
    {
        private static string strKetNoi = @"Data Source=.;Initial Catalog=QLPM_Karaoke;Integrated Security=True";

        public static SqlConnection TaoKetNoi()
        {
            SqlConnection conn = new SqlConnection(strKetNoi);
            conn.Open();
            return conn;
        }

        public static SqlDataReader TruyVanDuLieu(string strTruyVan, SqlConnection con)
        {
            SqlCommand com = new SqlCommand(strTruyVan, con);
            return com.ExecuteReader();
        }
       
        public static bool ThucThiCauLenh(string strCauLenh, SqlParameter[] arrayPara, SqlConnection connect)
        {
            SqlCommand cmd = new SqlCommand(strCauLenh, connect);
            cmd.Parameters.AddRange(arrayPara);
            int iKQ = cmd.ExecuteNonQuery();
            return iKQ > 0;
        }
        public static bool ThucThiCauLenh(string strCauLenh, SqlConnection connect)
        {
            SqlCommand cmd = new SqlCommand(strCauLenh, connect);
            int iKQ = cmd.ExecuteNonQuery();
            return iKQ > 0;
        }
    }
}
