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
}

entity Genres : CodeList {

    key code : String(20);

}

entity Platforms : CodeList {
    key code : String(20);
}
