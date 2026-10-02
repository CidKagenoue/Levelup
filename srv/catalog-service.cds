using { levelup as db } from '../db/schema';

service catalogService @(path: 'catalog') {
    entity Games as projection on db.Games;
}

