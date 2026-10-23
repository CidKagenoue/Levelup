using { levelup as db } from '../db/schema';

service catalogService @(path: 'catalog') {
    entity Games as projection on db.Games;
    entity Genres as projection on db.Genres;
    entity Platforms as projection on db.Platforms;
    entity Reviews as projection on db.Reviews;
    entity Customers as projection on db.Customers;
     entity GameTags as projection on db.GameTags;
    entity Tags as projection on db.tags;

type TopGame {
    ID        : UUID;
    title     : String;
    avgRating : Decimal(3, 2);
    reviews   : Integer;
}

function topGames(limit : Integer) returns array of TopGame;
}