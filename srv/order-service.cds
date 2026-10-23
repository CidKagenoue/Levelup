using {levelup as db} from '../db/schema';

service orderService @(path: 'orders') {
    @readonly
    entity Customers  as projection on db.Customers;

    @readonly
    entity Games      as projection on db.Games;

    entity Orders     as projection on db.Orders actions {action cancel() returns Orders;};
    entity OrderItems as projection on db.OrderItems;

    annotate orderService.Orders with {
        totalAmount @readonly;
        status      @readonly;
    };

    annotate orderService.OrderItems with {
        unitPrice @readonly;
    };

    annotate orderService.Orders with @(Capabilities: {
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    annotate orderService.OrderItems with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });




}
