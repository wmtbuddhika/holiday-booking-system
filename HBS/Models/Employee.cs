using System;
using MySql.Data.MySqlClient;

namespace HBS.Models
{
    public class Employee
    {
        static MySqlConnection connection;

        public int empId { set; get; }
        public string empName { set; get; }

        public Employee()
        {
        }

        public static Employee GetEmployee(int empId)
        {
            OpenDatabaseConnection();
            MySqlCommand command = new MySqlCommand();
            MySqlDataReader dataReader;
            Employee employee = new Employee();

            command.Connection = connection;
            command.CommandText = "SELECT e.Name empName FROM Employee e WHERE e.EmployeeId = @empId";
            command.Parameters.AddWithValue("@empId", empId);

            dataReader = command.ExecuteReader();

            if (dataReader.Read())
            {
                employee.empId = empId;
                employee.empName = dataReader.GetString("empName");

            }
            dataReader.Close();
            connection.Close();

            return employee;
        }

        private static void OpenDatabaseConnection()
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
