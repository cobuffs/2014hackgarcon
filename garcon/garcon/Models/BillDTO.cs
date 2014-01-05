using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace garcon.Models
{
    public class BillDTO
    {
        public int id { get; set; }
        public int tableid { get; set; }
        public bool paid { get; set; }
        public System.DateTime checkedin { get; set; }
        public Nullable<System.DateTime> checkedout { get; set; }

        public List<BillItemDTO> items { get; set; }
        public decimal total { get; set; }
    }
}