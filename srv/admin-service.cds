using { levelup as db } from '../db/schema';
service AdminService @(path: 'admin') {
 @odata.draft.enabled
 entity Games as projection on db.Games;

 @readonly
 entity Customers as projection on db.Customers {
     ID,
     firstname as firstName,
     lastname as lastName
 };

 @cds.redirection.target
 entity Reviews as projection on db.Reviews;

 @readonly
 entity GameLeaderboard as projection on db.GameLeaderboard;
}

