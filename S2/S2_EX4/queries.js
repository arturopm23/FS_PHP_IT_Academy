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
/*19*/ //db.getCollection('restaurants').find({borough : {$nin : ["Staten Island" , "Queens" , "Bronx" , "Brooklyn"]}} , {_id: 0,restaurant_id: 1, name: 1, borough: 1, cuisine: 1});
/*25*/ //db.getCollection('restaurants').find({}).sort({name : 1});
/*26*/ //db.getCollection('restaurants').find({}).sort({name : -1});
/*27*/ //db.getCollection('restaurants').find({}).sort({cuisine : 1, borough : -1});
/*31*/ //db.getCollection('restaurants').find({name : {$regex : /mon/ }}, {_id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1,});
/*32*/ //db.getCollection('restaurants').find({name : {$regex : /^Mad/ }}, {_id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1,});

/*Consultas corregidas*/
/*8*/ //db.getCollection('restaurants').find({"grades.score": {$gt: 90}});
/*9*/ //db.getCollection('restaurants').find({"grades.score": {$gt: 80, $lt: 100}});
/*10*/ //db.getCollection('restaurants').find({"address.coord.0": {$lt: -95.754168}});
/*11*/ //db.getCollection('restaurants').find({ cuisine: { $ne: "American " }, "grades.score": { $gt: 70 }, "address.coord.1": { $lt: -65.754168 } });
/*12*/ //db.getCollection('restaurants').find({ cuisine: { $ne: "American " }, "grades.score": { $gt: 70 }, "address.coord.1": { $lt: -65.754168 } });
/*13*/ //db.getCollection('restaurants').find({ cuisine: { $ne: "American " }, "grades.grade": "A", borough: { $ne: "Brooklyn" } }).sort({ cuisine: -1 });
/*17*/ //db.getCollection('restaurants').find({ borough: "Bronx", cuisine: { $in: ["American ", "Chinese"] } });
/*18*/ //db.getCollection('restaurants').find({ borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });
/*20*/ //db.getCollection('restaurants').find({ "grades.score": { $lt: 10 } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });
/*21*/ //db.getCollection('restaurants').find({ cuisine: "Seafood", cuisine: { $nin: ["American ", "Chinese"] }, name: { $not: /^Wil/ } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });
/*22*/ //db.getCollection('restaurants').find({ "grades": { $elemMatch: { "grade": "A", "score": 11, "date": ISODate("2014-08-11T00:00:00Z") } } }, { restaurant_id: 1, name: 1, grades: 1, _id: 0 });
/*23*/ //db.getCollection('restaurants').find({ "grades.1.grade": "A", "grades.1.score": 9, "grades.1.date": ISODate("2014-08-11T00:00:00Z") }, { restaurant_id: 1, name: 1, grades: { $slice: [1, 1] }, _id: 0 });
/*24*/ //db.getCollection('restaurants').find({ "address.coord.1": { $gt: 42, $lt: 52 } }, { restaurant_id: 1, name: 1, "address.street": 1, "address.coord": 1, _id: 0 });
/*28*/ //db.getCollection('restaurants').find({ "address.street": { $exists: true, $ne: "" } });
/*29*/ //db.getCollection('restaurants').find({ "address.coord": { $type: "double" } });
/*30*/ //db.getCollection('restaurants').find({"grades.score": {$mod: [7, 0]}}, {restaurant_id: 1, name: 1, "grades": 1, _id: 0})
