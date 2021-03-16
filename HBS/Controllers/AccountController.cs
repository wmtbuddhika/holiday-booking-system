using System;
using Microsoft.AspNetCore.Mvc;
using HBS.Models;
using MySql.Data.MySqlClient;

namespace HBS.Controllers
{
    public class AccountController : Controller
    {
        static MySqlConnection connection;

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        public ActionResult Verify(Account account)
        {
            int id = AuthenticateUser(account);
            if (id == 0)
            {
                return View("Login");
            }
            return RedirectToAction("Index", "Home", new { empId = id });
        }

        private void OpenDatabaseConnection()
        {
            try
            {   
                connection = new MySqlConnection
                {
                    ConnectionString = "server=localhost;port=3306;user=root;database=LeaveManagement"
                };
                connection.Open();
                Console.WriteLine("Connected to Database");
            } catch(Exception e)
            {
                Console.WriteLine("Error : " + e.ToString());
            }
        }

        private int AuthenticateUser(Account account)
        {
            OpenDatabaseConnection();
            MySqlCommand command = new MySqlCommand();
            MySqlDataReader dataReader;
            int empId = 0;

            command.Connection = connection;
            command.CommandText = "SELECT Employee_Id empId FROM Login WHERE UserName = @UserName AND Password = @Password";
            command.Parameters.AddWithValue("@UserName", account.Email);
            command.Parameters.AddWithValue("@Password", account.Password);

            dataReader = command.ExecuteReader();

            if(dataReader.Read())
            {
                empId = dataReader.GetInt16("empId");
                connection.Close();
                return empId;
            }
            return empId;
        }
    }
}
