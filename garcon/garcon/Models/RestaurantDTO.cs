using garcon.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace garcon.Models
{
    public class RestaurantDTO
    {
        public int id { get; set; }
        public string name { get; set; }
        public System.Data.Spatial.DbGeography loc { get; set; }
        public string img { get; set; }

        public RestaurantDTO()
        {
            this.id = 0;
            this.name = "";
            this.loc = null;
            this.img = "";
        }

        public RestaurantDTO(restaurant res)
        {
            this.id = res.id;
            this.img = res.img;
            this.loc = res.loc;
            this.name = res.name;
        }
    }
}