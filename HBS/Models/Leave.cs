using System;
namespace HBS.Models
{
    public class Leave
    {
        public int empId { set; get; }
        public DateTime startDate { set; get; }
        public DateTime endDate { set; get; }
        public string reason { set; get; }

        public Leave()
        {
        }
    }
}
