using garcon.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace garcon.Models
{
    public class ItemDTO
    {
        public int id { get; set; }
        public string description { get; set; }
        public decimal price { get; set; }

        public ItemDTO(item item)
        {
            this.id = item.id;
            this.description = item.description;
            this.price = item.price;
        }

        public ItemDTO()
        {
            this.id = 0;
            this.price = 0;
            this.description = "";
        }
    }

}