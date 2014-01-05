using garcon.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace garcon.Models
{
    public class BillItemDTO
    {
        public int id { get; set; }
        public int billid { get; set; }
        public ItemDTO item { get; set; }
        public int seatnum { get; set; }

        public BillItemDTO(billitem item)
        {
            this.id = item.id;
            this.billid = item.itemid;
            this.seatnum = item.seatnum;
        }
    }
}