use('restaurants');

/*1*/ //db.getCollection('restaurants').find({});
/*2*/ //db.getCollection('restaurants').find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*3*/ //db.getCollection('restaurants').find({}, {_id: 0,restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*4*/ //db.getCollection('restaurants').find({}, {restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0});
/*5*/ //db.getCollection('restaurants').find({borough : "Bronx"});
/*6*/ //db.getCollection('restaurants').find({borough : "Bronx"}).limit(5);
/*7*/ //db.getCollection('restaurants').find({borough : "Bronx"}).skip(5).limit(5);
/*10*/ //db.getCollection('restaurants').find({ "address.coord" : {$lt : -95.754168}});
/*14*/ //db.getCollection('restaurants').find({name : {$regex : /^Wil/}}, {_id: 0,restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*15*/ //db.getCollection('restaurants').find({name : {$regex : /ces$/}}, {_id: 0,restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*16*/ //db.getCollection('restaurants').find({name : {$regex : /Reg/ }}, {_id: 0,restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*19*/ db.getCollection('restaurants').find({borough : {$nin : ["Staten Island" , "Queens" , "Bronx" , "Brooklyn"]}} , {_id: 0,restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*25*/ //db.getCollection('restaurants').find({}).sort({name : 1});
/*26*/ //db.getCollection('restaurants').find({}).sort({name : -1});
/*27*/ //db.getCollection('restaurants').find({}).sort({cuisine : 1, borough : -1});
/*31*/ //db.getCollection('restaurants').find({name : {$regex : /mon/ }}, {_id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1,});
/*32*/ //db.getCollection('restaurants').find({name : {$regex : /^Mad/ }}, {_id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1,});

/*Consultas corregidas*/
/*8*/
/*9*/
/*10*/
/*11*/
/*12*/
/*13*/
/*17*/
/*18*/
/*20*/
/*21*/
/*22*/
/*23*/
/*24*/
/*28*/
/*29*/
/*30*/