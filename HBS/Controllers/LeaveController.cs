using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HBS.Models;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Net.Http;
using Newtonsoft.Json;

namespace HBS.Controllers
{
    public class LeaveController : Controller
    {
        static MySqlConnection connection;

        // GET: /<controller>/
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult NewRequest(int empId)
        {
            ViewData["Message"] = Employee.GetEmployee(empId);
            return View("NewRequest");
        }

        public IActionResult LeaveHistory(int empId)
        {
            ViewData["Message"] = Employee.GetEmployee(empId);
            return View("LeaveHistory");
        }

        public IActionResult SaveNewRequest(Leave leave)
        {
            OpenDatabaseConnection();
            MySqlCommand command = new MySqlCommand();
            MySqlDataAdapter adapter = new MySqlDataAdapter();

            DateTime endDate = leave.endDate.AddHours(23).AddMinutes(59).AddSeconds(59);
            string validationString = validate(leave.empId, leave.startDate.ToString("yyyy-MM-dd"), endDate.ToString("yyyy-MM-dd"));

            int leaveDays = Convert.ToInt32((endDate - leave.startDate).TotalDays);
            int leaveMasterId = getLeaveMasterId(leave.empId);
            int timePeriodId = getTimePeriodId(leave.startDate, endDate);

            command.Connection = connection;
            command.CommandText = "CALL SaveLeaveRequest(@leaveDays, @startDate, @endDate, @status, @timePeriodId, @leaveMasterId, @validations);";

            command.Parameters.AddWithValue("@leaveDays", leaveDays);
            command.Parameters.AddWithValue("@startDate", leave.startDate);
            command.Parameters.AddWithValue("@endDate", endDate);
            command.Parameters.AddWithValue("@reason", leave.reason);
            command.Parameters.AddWithValue("@status", true);
            command.Parameters.AddWithValue("@leaveMasterId", leaveMasterId);
            command.Parameters.AddWithValue("@validations", validationString);

            if (timePeriodId == 0)
            {
                command.Parameters.AddWithValue("@timePeriodId", null);
            } else
            {
                command.Parameters.AddWithValue("@timePeriodId", timePeriodId);
            }
            
            adapter.InsertCommand = command;
            adapter.InsertCommand.ExecuteNonQuery();

            command.Dispose();
            connection.Close();

            return RedirectToAction("Index", "Home", new { empId = leave.empId });
        }

        private string validate(int empId, string startDate, string endDate)
        {
            string URL = "http://localhost:5000/api/validate/";
            string urlParameters = "empId=" + empId + "&startDate=" + startDate + "&endDate=" + endDate;
            KeyValuePair<int, string>[] validations = new KeyValuePair<int, string>[0];
            string validationString = "";

            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri(URL);
          
            HttpResponseMessage response = client.GetAsync(urlParameters).Result;
            if (response.IsSuccessStatusCode)
            {
                
                var responseData = response.Content.ReadAsStringAsync().Result;
                validations = JsonConvert.DeserializeObject<KeyValuePair<int, string>[]>(responseData);
                foreach (KeyValuePair<int, string> validation in validations)
                {
                    validationString += validation.Value + ",";
                }
            }

            client.Dispose();
            return validationString;
        }

        private int getLeaveMasterId(int empId)
        {
            MySqlCommand command = new MySqlCommand();
            MySqlDataReader dataReader;
            int leaveMasterId = 0;

            command.Connection = connection;
            command.CommandText = "SELECT lm.LeaveMasterId leaveMasterId FROM LeaveMaster lm, JobMaster jm " +
                "WHERE lm.JobMaster_Id = jm.JobMasterId AND jm.Employee_Id = @empId AND jm.Status = 1;";
            command.Parameters.AddWithValue("@empId", empId);

            dataReader = command.ExecuteReader();

            if (dataReader.Read())
            {
                leaveMasterId = dataReader.GetInt16("leaveMasterId");
               
            }
            dataReader.Close();
            return leaveMasterId;
        }

        private int getTimePeriodId(DateTime startDate, DateTime endDate)
        {
            MySqlCommand command = new MySqlCommand();
            MySqlDataReader dataReader;
            int timePeriodId = 0;

            command.Connection = connection;
            command.CommandText = "SELECT MAX(tp.TimePeriodId) timePeriodId FROM TimePeriod tp WHERE tp.EndDate >= @startDate;";
            command.Parameters.AddWithValue("@startDate", startDate);
            command.Parameters.AddWithValue("@endDate", endDate);

            dataReader = command.ExecuteReader();

            if (dataReader.Read())
            {
                timePeriodId = dataReader.GetInt16("timePeriodId");

            }
            dataReader.Close();
            return timePeriodId;
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
            }
            catch (Exception e)
            {
                Console.WriteLine("Error : " + e.ToString());
            }
        }
    }
}
