using { levelup as db } from '../db/schema';

service orderService @(path: 'orders') {
    @readonly entity Customers as projection on db.Customers;
    @readonly entity Games     as projection on db.Games;
    entity Orders              as projection on db.Orders;
    entity OrderItems          as projection on db.OrderItems;
}
