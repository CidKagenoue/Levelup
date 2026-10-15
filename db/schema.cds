namespace levelup;

using {
    cuid,
    managed,
    sap.common.CodeList,
    Currency,
    Country
} from '@sap/cds/common';

using from '@sap/cds-common-content';


entity Games : cuid, managed {
    title         : String(100) @mandatory;
    description   : String(1000);
    price         : Decimal(6, 2);
    currency      : Currency;
    genre         : Association to Genres;
    platform      : Association to Platforms;
    stock         : Integer default 0;
    releaseDate   : Date;
    studioCountry : Country;
    tags          : Composition of many GameTags
                        on tags.game = $self;
    reviews       : Composition of many Reviews
                        on reviews.game = $self;
}

entity Customers : cuid, managed {
    firstname : String(80)  @mandatory;
    lastname  : String(80)  @mandatory;
    email     : String(120) @mandatory;
    country   : Country;
    reviews   : Association to many Reviews
                    on reviews.customer = $self;
    orders    : Association to many Orders
                    on orders.customer = $self;
}

entity Orders : cuid, managed {
    orderDate : DateTime;
    customer  : Association to Customers @mandatory;
    items     : Composition of many OrderItems
                    on items.order = $self;
}

entity OrderItems : cuid, managed {
    order    : Association to Orders @mandatory;
    game     : Association to Games  @mandatory;
    quantity : Integer               @mandatory;
}

entity Reviews : cuid, managed {
    customer : Association to Customers @mandatory;
    game     : Association to Games     @mandatory;
    rating   : Association to Rating;
}

entity GameTags {
    key game : Association to Games;
    key tag  : Association to tags;


}


entity Genres : CodeList {
    key code : String(20);

}

entity Platforms : CodeList {
    key code : String(20);
}

entity Rating : CodeList {
    key code : Integer

}

entity tags : CodeList {
    key code  : String(20);
        games : Association to many GameTags
                    on games.tag = $self;
}
