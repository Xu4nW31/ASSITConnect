using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SITConnect
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        public int attempt;
        string password;
        string password1;
        string password2;
        DateTime passwordCreated;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        protected void Page_Load(object sender, EventArgs e)
        {

       
        }

        private bool changePassword(string pwd)
        {
            var email = Session["LoggedIn"].ToString();
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select Password, Password1, Password2, PasswordCreated FROM Account WHERE Email=@Email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@Email", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["Password"] != DBNull.Value)
                        {
                            password = reader["Password"].ToString();
                        }
                        if (reader["Password1"] != DBNull.Value)
                        {
                            password1 = reader["Password1"].ToString();
                        }
                        if (reader["Password2"] != DBNull.Value)
                        {
                            password2 = reader["Password2"].ToString();
                        }
                        if (reader["PasswordCreated"] != DBNull.Value)
                        {
                            passwordCreated = (DateTime)reader["PasswordCreated"];
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                connection.Close();
                
            }
            if (pwd == password || pwd == password1 || pwd == password2)
            {
                lbl_error.Text = "Password used before";
                return false;
            }
            else
            {
                TimeSpan MinTime = TimeSpan.FromTicks(DateTime.Now.Ticks) - TimeSpan.FromTicks(passwordCreated.Ticks);
                if (MinTime.Minutes > 1)
                {
                        try
                        {
                            using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                            {
                                using (SqlCommand cmd = new SqlCommand("Update Account SET PasswordCreated=@PasswordCreated, Password=@Password, Password1=@Password1, Password2=@Password2 Where Email=@Email"))
                                {
                                    using (SqlDataAdapter sda = new SqlDataAdapter())
                                    {
                                        cmd.CommandType = CommandType.Text;
                                        cmd.Parameters.AddWithValue("@Email", email);
                                        cmd.Parameters.AddWithValue("@PasswordCreated", DateTime.Now);
                                        cmd.Parameters.AddWithValue("@Password", pwd);
                                        cmd.Parameters.AddWithValue("@Password1", password);
                                        cmd.Parameters.AddWithValue("@Password2", password1);
                                        cmd.Connection = con;
                                        con.Open();
                                        cmd.ExecuteNonQuery();
                                        con.Close();
                                    }
                                }

                            }
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(ex.ToString());
                        }
                }
       
                return true;
            }
        }

        protected string getDBHash()
        {
            var email = Session["LoggedIn"].ToString();
            string h = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select Password FROM Account WHERE Email=@Email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@Email", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["Password"] != null)
                        {
                            if (reader["Password"] != DBNull.Value)
                            {
                                h = reader["Password"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }

        protected string getDBSalt()
        {
            var email = Session["LoggedIn"].ToString();
            string s = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select PASSWORDSALT FROM ACCOUNT WHERE Email=@Email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@Email", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PASSWORDSALT"] != null)
                        {
                            if (reader["PASSWORDSALT"] != DBNull.Value)
                            {
                                s = reader["PASSWORDSALT"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return s;
        }

        public bool ValidatePassword(string pwd, string cfmpwd)
        {
            SHA512Managed hashing = new SHA512Managed();
            string dbHash = getDBHash();
            string dbSalt = getDBSalt();
            try
            {
                if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                {
                    string pwdWithSalt = pwd + dbSalt;
                    string cfmpwdWithSalt = cfmpwd + dbSalt;
                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                    byte[] hashWithSaltcfmpwd = hashing.ComputeHash(Encoding.UTF8.GetBytes(cfmpwdWithSalt));
                    string userHash = Convert.ToBase64String(hashWithSalt);
                    string userHashcfmpwd = Convert.ToBase64String(hashWithSaltcfmpwd);
                    if (userHash.Equals(userHashcfmpwd))
                    {
                        if (changePassword(userHash))
                        {
                            Response.Redirect("HomePage.aspx", false);
                        }
                        else
                        {
                            lbl_error.Text = "Old Password cannot be used";
                        }

                    }
                    else
                    {
                        lbl_error.Text = "Password does not match";
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            return false;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            HttpUtility.HtmlEncode(tb_pwd.Text);
            HttpUtility.HtmlEncode(tb_cfmpwd.Text);

            string pwd = tb_pwd.Text.ToString().Trim();
            string cfmpwd = tb_cfmpwd.Text.ToString().Trim();
            ValidatePassword(pwd, cfmpwd);
        }
    }
}