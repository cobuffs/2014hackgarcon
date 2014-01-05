using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using garcon.Data;
using System.Data.Spatial;
using garcon.Models;

namespace garcon.Controllers
{
    public class RestaurantController : ApiController
    {
        private garconEntities db = new garconEntities();

        // GET api/Restaurant
        public IQueryable<RestaurantDTO> GetRestaurants()
        {
            return db.restaurants.Select(s => new RestaurantDTO() {id = s.id, name = s.name, loc = s.loc, img = s.img });
        }

        public IQueryable<RestaurantDTO> GetRestaurantsNearAPoint(double lat, double longi)
        {

            var point = string.Format(
	            "POINT({1} {0})", 
	            lat.ToString(), 
	            longi.ToString());

            var location = DbGeography.FromText(point);
            return db.restaurants.Where(w => w.loc.Distance(location) < 1000).Select(s => new RestaurantDTO() { id = s.id, name = s.name, loc = s.loc, img = s.img });
        }

        // GET api/Restaurant/5
        [ResponseType(typeof(restaurant))]
        public IHttpActionResult GetRestaurant(int id)
        {
            RestaurantDTO restaurant = db.restaurants.Where(w=>w.id==id).Select(s => new RestaurantDTO() {id = s.id, name = s.name, loc = s.loc, img = s.img }).First<RestaurantDTO>();
            if (restaurant == null)
            {
                return NotFound();
            }

            return Ok(restaurant);
        }

        // PUT api/Restaurant/5
        public IHttpActionResult PutRestaurant(int id, RestaurantDTO restaurant)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != restaurant.id)
            {
                return BadRequest();
            }

            db.Entry(restaurant).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!restaurantExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool restaurantExists(int id)
        {
            return db.restaurants.Count(e => e.id == id) > 0;
        }
    }
}