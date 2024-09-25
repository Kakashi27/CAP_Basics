using learning.Anil as db from '../db/schema';

service AdminService @(path: '/admin') {
   entity Authors as projection on db.Authors;
   entity Books as projection on db.Books;
}