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
using garcon.Models;

namespace garcon.Controllers
{
    public class TableController : ApiController
    {
        private garconEntities db = new garconEntities();

        [ResponseType(typeof(TableDTO))]
        public IHttpActionResult GetTableFromBeaconId(string id)
        {
            TableDTO table = db.tables.Where(w => w.beaconid == id).Select(s => new TableDTO() { id = s.id, beaconid = s.beaconid, restaurantid = s.restaurantid }).First<TableDTO>();
            if (table == null) return NotFound();
            return Ok(table);
        }

        public IQueryable GetMenuForRestaurant(int resid)
        {
            return db.items.Where(w => w.restaurantid == resid).Select(s => new ItemDTO() { id = s.id, description = s.description, price = s.price });
        }

        public IQueryable GetTablesForRestaurant(int resid)
        {
            return db.tables.Where(w => w.restaurantid == resid).Select(s => new TableDTO() { id = s.id, beaconid = s.beaconid, restaurantid = s.restaurantid });
        }

        [ResponseType(typeof(BillDTO))]
        public IHttpActionResult CheckIn(int tableid)
        {
            bill bill = new bill();
            bill.checkedin = DateTime.Now;
            bill.paid = false;
            db.bills.Add(bill);
            db.SaveChanges();

            BillDTO ret = new BillDTO() { checkedin = bill.checkedin, id = bill.id, tableid = bill.tableid };
            return Ok(ret);
        }

        [ResponseType(typeof(BillDTO))]
        public IHttpActionResult GetBill(int billid)
        {
            //get the bill
            BillDTO bill = db.bills.Where(w => w.id == billid).Select(s => new BillDTO() { id = s.id, tableid = s.tableid, checkedin = s.checkedin, paid = s.paid, checkedout = s.checkedout }).First();
            bill.items = new List<BillItemDTO>();
            var billitems = db.billitems.Where(w => w.billid == billid).Select(s => s);
            bill.total = 0;
            foreach (billitem item in billitems)
            {
                ItemDTO specItem = new ItemDTO(item.item);
                BillItemDTO newItem = new BillItemDTO(item);
                newItem.item = specItem;
                bill.items.Add(newItem);
                bill.total += specItem.price;
            }
            return Ok(bill);
        }

        [HttpPost]
        public IHttpActionResult AddItemToBill(int billid, int itemid)
        {
            bill bill = db.bills.Find(billid);
            item item = db.items.Find(itemid);
            if (bill == null || item == null) return NotFound();

            billitem newitem = new billitem();
            newitem.bill = bill;
            newitem.item = item;
            db.billitems.Add(newitem);
            db.SaveChanges();

            return Ok();
        }
    }
}