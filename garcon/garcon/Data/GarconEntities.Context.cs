﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace garcon.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class garconEntities : DbContext
    {
        public garconEntities()
            : base("name=garconEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<billitem> billitems { get; set; }
        public DbSet<bill> bills { get; set; }
        public DbSet<item> items { get; set; }
        public DbSet<table> tables { get; set; }
        public DbSet<restaurant> restaurants { get; set; }
    }
}
