using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace SITConnect
{
    public partial class Registration : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private int checkPassword(string password)
        {
            int score = 0;

            if (password.Length < 12)
            {
                return 1;
            }
            else
            {
                score = 1;
            }
            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
            }
            if (Regex.IsMatch(password, "[^a-zA-Z0-9]"))
            {
                score++;
            }

            return score;
        }


        private int checkFields()
        {
            int score = 0;

            if (string.IsNullOrEmpty(tb_firstname.Text.ToString()))
            {
                score += 1;
                tb_firstname.ForeColor = Color.Red;
                lbl_firstnamechecker.Text = "Please enter your First Name";
            }
            if (string.IsNullOrEmpty(tb_lastname.Text.ToString()))
            {
                score += 1;
                lbl_lastnamechecker.ForeColor = Color.Red;
                lbl_lastnamechecker.Text = "Please enter your Last Name";
            }
            if (string.IsNullOrEmpty(tb_creditcard.Text.ToString()))
            {
                score += 1;
                lbl_creditcardchecker.ForeColor = Color.Red;
                lbl_creditcardchecker.Text = "Please enter your Credit Card Number";
            }
            if (string.IsNullOrEmpty(tb_expirydate.Text.ToString()))
            {
                score += 1;
                lbl_cardexpirychecker.ForeColor = Color.Red;
                lbl_cardexpirychecker.Text = "Please enter your Credit Card's Expiry";
            }
            if (string.IsNullOrEmpty(tb_creditcardcvv.Text.ToString()))
            {
                score += 1;
                lbl_cvvchecker.ForeColor = Color.Red;
                lbl_cvvchecker.Text = "Please enter your Credit Card's CVV";
            }
            if (string.IsNullOrEmpty(tb_email.Text.ToString()))
            {
                score += 1;
                lbl_email.ForeColor = Color.Red;
                lbl_email.Text = "Please enter your Email";
            }
            if (Regex.IsMatch(tb_email.Text, @"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"))
            {
                score += 1;
                lbl_email.ForeColor = Color.Red;
                lbl_email.Text = "Please enter a valid email";
            }
            if (string.IsNullOrEmpty(tb_DOB.Text.ToString()))
            {
                score += 1;
                lbl_dobchecker.ForeColor = Color.Red;
                lbl_dobchecker.Text = "Please enter your Date of Birth";
            }
            if (!FileUpload1.HasFile)
            {
                score += 1;
                lbl_photo.ForeColor = Color.Red;
                lbl_photo.Text = "Please insert your photo";
            }

            return score;
        }

        protected void createAccount()
        {
            string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            FileUpload1.SaveAs(Server.MapPath("Photo/" + fileName));
            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@FirstName, @LastName, @CreditCardInfo, @CreditCardDate, @CVV, @Email, @Password, @PasswordSalt, @DOB, @Photo, @IV, @Key, @Password1, @Password2, @PasswordCreated, @Attempt, @LockoutDuration)"))
                    {
                       

                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@FirstName", tb_firstname.Text.Trim());
                            cmd.Parameters.AddWithValue("@LastName", tb_lastname.Text.Trim());
                            cmd.Parameters.AddWithValue("@CreditCardInfo", Convert.ToBase64String(encryptData(tb_creditcard.Text.Trim())));
                            cmd.Parameters.AddWithValue("@CreditCardDate", Convert.ToBase64String(encryptData(tb_expirydate.Text.Trim())));
                            cmd.Parameters.AddWithValue("@CVV", Convert.ToBase64String(encryptData(tb_creditcardcvv.Text.Trim())));
                            cmd.Parameters.AddWithValue("@Email", tb_email.Text.Trim());
                            cmd.Parameters.AddWithValue("@Password", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@DOB", tb_DOB.Text.Trim());
                            cmd.Parameters.AddWithValue("@Photo", fileName);
                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                            cmd.Parameters.AddWithValue("@Password1", DBNull.Value);
                            cmd.Parameters.AddWithValue("@Password2", DBNull.Value);
                            cmd.Parameters.AddWithValue("@PasswordCreated", DateTime.Now);
                            cmd.Parameters.AddWithValue("@Attempt", 0);
                            cmd.Parameters.AddWithValue("@LockoutDuration", DateTime.Now);
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

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            HttpUtility.HtmlEncode(tb_firstname.Text);
            HttpUtility.HtmlEncode(tb_lastname.Text);
            HttpUtility.HtmlEncode(tb_creditcard.Text);
            HttpUtility.HtmlEncode(tb_expirydate.Text);
            HttpUtility.HtmlEncode(tb_creditcardcvv.Text);
            HttpUtility.HtmlEncode(tb_password.Text);
            HttpUtility.HtmlEncode(tb_email.Text);



            string pwd = tb_password.Text.ToString().Trim(); ;
            //Generate random "salt"
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];
            //Fills array of bytes with a cryptographically strong sequence of random values.
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);
            SHA512Managed hashing = new SHA512Managed();
            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
            finalHash = Convert.ToBase64String(hashWithSalt);
            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;
            createAccount();
            Response.Redirect("Login.aspx");


            int scores = checkPassword(tb_password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;
                        
                case 2:
                    status = "Weak";
                    break;

                case 3:
                    status = "Medium";
                    break;      

                case 4:
                    status = "Strong";
                    break;

                case 5:
                    status = "Excellent";
                    break;

                default:
                    break;
            }
            lbl_pwdchecker.Text = "Status : " + status;
            if (scores < 4)
            {
                lbl_pwdchecker.ForeColor = Color.Red;
                return;
            }
            lbl_pwdchecker.ForeColor = Color.Green;
            return;
          
        }
    }
}