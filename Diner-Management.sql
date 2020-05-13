/*DROP TABLE OrderDeliveryItem
DROP TABLE OrderItem
DROP TABLE OrderToken
DROP TABLE TableSitting
DROP TABLE TableInfo
DROP TABLE MenuItem
DROP TABLE TableSection
DROP TABLE TableStatus
DROP TABLE OrderChannel
DROP TABLE OrderTokenStatus
DROP TABLE MenuItemCategory
DROP TABLE OrderDeliveryStatus
*/


CREATE TABLE OrderDeliveryStatus
(
orderdeliveryid INTEGER PRIMARY KEY,
orderdeliverystatus CHAR(20) NOT NULL 
);

CREATE TABLE MenuItemCategory
(
categoryid INTEGER PRIMARY KEY,
categoryname CHAR(15) NOT NULL,
categorydescription CHAR(30) NOT NULL
);

CREATE TABLE OrderTokenStatus
(
statusid INTEGER PRIMARY KEY,
statusdescription CHAR(15) NOT NULL
);

CREATE TABLE OrderChannel
(
orderchannelid INTEGER PRIMARY KEY,
orderchanneltype CHAR(10) NOT NULL
);

CREATE TABLE TableStatus
(
tablestatusid INTEGER PRIMARY KEY,
tablestatusdescription CHAR(10) NOT NULL
);


CREATE TABLE TableSection
(
tablesectionid INTEGER PRIMARY KEY,
area_description CHAR(20) NOT NULL,
smoking_allowed INTEGER NOT NULL,
drinking_allowed INTEGER NOT NULL
);

CREATE TABLE MenuItem
(
menuitemid INTEGER PRIMARY KEY,
itemname CHAR(15) NOT NULL,
categoryid INTEGER NOT NULL,
itemdescription CHAR(30) NOT NULL,
itemcost DECIMAL(6,2) NOT NULL,

constraint MenuItem_FK FOREIGN KEY (categoryid) REFERENCES MenuItemCategory(categoryid)
);

CREATE TABLE TableInfo
(
tableid INTEGER PRIMARY KEY,
tablecapacity INTEGER NOT NULL,
waiterid INTEGER NOT NULL,
tablestatusid INTEGER NOT NULL,
tablesectionid INTEGER NOT NULL,
busboyid INTEGER NOT NULL,

constraint TableInfo_FK_tablestatusid FOREIGN KEY (tablestatusid) REFERENCES TableStatus(tablestatusid),
constraint TableInfo_FK_tablesectionid FOREIGN KEY (tablesectionid) REFERENCES TableSection(tablesectionid)
);

CREATE TABLE TableSitting
(
tablesittingid INTEGER PRIMARY KEY,
tableid INTEGER NOT NULL,
table_intime TIME(0) NOT NULL,
table_outtime TIME(0) NOT NULL,
numberofpeople INTEGER NOT NULL,

constraint TableSitting_FK FOREIGN KEY (tableid) REFERENCES TableInfo(tableid)
);


CREATE TABLE OrderToken
(
ordertokenid INTEGER PRIMARY KEY,
orderchannelid INTEGER NOT NULL,
staff_id INTEGER NOT NULL,
tablesittingid INTEGER,
orderdate DATE NOT NULL,
order_intime TIME(0) NOT NULL,
order_outtime TIME(0) NOT NULL,
statusid INTEGER NOT NULL,
orderamount DECIMAL(6,2),

constraint OrderToken_FK_orderchannelid FOREIGN KEY (orderchannelid) REFERENCES OrderChannel(orderchannelid),
constraint OrderToken_FK_tablesittingid FOREIGN KEY (tablesittingid) REFERENCES TableSitting(tablesittingid),
constraint OrderToken_FK_statusid FOREIGN KEY (statusid) REFERENCES OrderTokenStatus(statusid)
);

CREATE TABLE OrderItem
(
orderitemid INTEGER PRIMARY KEY,
ordertokenid INTEGER NOT NULL,
menuitemid INTEGER NOT NULL,
quantity INTEGER NOT NULL,

constraint OrderItem_FK_ordertokenid FOREIGN KEY (ordertokenid) REFERENCES OrderToken(ordertokenid),
constraint OrderItem_FK_menuitemid FOREIGN KEY (menuitemid) REFERENCES MenuItem(menuitemid) 
);

CREATE TABLE OrderDeliveryItem
(
orderdeliveryitemid INTEGER PRIMARY KEY,
orderitemid INTEGER NOT NULL,
chef_id INTEGER NOT NULL,
orderdeliveryid INTEGER NOT NULL,

constraint OrderDeliveryItem_FK_orderitemid FOREIGN KEY (orderitemid) REFERENCES OrderItem(orderitemid),
constraint OrderDeliveryItem_FK_orderdeliveryid FOREIGN KEY (orderdeliveryid) REFERENCES OrderDeliveryStatus(orderdeliveryid)
);


INSERT INTO OrderDeliveryStatus Values (1,'Order just received')
INSERT INTO OrderDeliveryStatus Values (2,'Prepping')
INSERT INTO OrderDeliveryStatus Values (3,'Cooking')
INSERT INTO OrderDeliveryStatus Values (4,'Plating')
INSERT INTO OrderDeliveryStatus Values (5,'Ready')

SELECT * FROM OrderDeliveryStatus

INSERT INTO MenuItemCategory Values (1,'Italian','Pizza and Pasta')
INSERT INTO MenuItemCategory Values (2,'American','Burgers and Mac&Cheese')
INSERT INTO MenuItemCategory Values (3,'Mexican','Burritos,Tacos & Quessadilas')
INSERT INTO MenuItemCategory Values (4,'Indian','Breads and Curries')

SELECT * FROM MenuItemCategory

INSERT INTO OrderTokenStatus Values (1,'Order Received')
INSERT INTO OrderTokenStatus Values (2,'Preparing Order')
INSERT INTO OrderTokenStatus Values (3,'Finishing')
INSERT INTO OrderTokenStatus Values (4,'Order Ready')

SELECT * FROM OrderTokenStatus

INSERT INTO OrderChannel Values (1,'online')
INSERT INTO OrderChannel Values (2,'takeaway')
INSERT INTO OrderChannel Values (3,'dine-in')

SELECT * FROM OrderChannel


INSERT INTO TableStatus Values(1,'Occupied')
INSERT INTO TableStatus Values(2,'Free&Clean')
INSERT INTO TableStatus Values(3,'Unclean')

SELECT * FROM TableStatus

INSERT INTO TableSection Values (1,'Indoor',0,0)
INSERT INTO TableSection Values (2,'Outdoor',1,1)
INSERT INTO TableSection Values (3,'Lounge',0,1)

SELECT * FROM TableSection

INSERT INTO MenuItem Values(1,'Cheese Pizza', 1, 'Mozzarella Cheese', 14.00)
INSERT INTO MenuItem Values(2,'Mac&Cheese', 2, 'Macaron with cheese sauce', 8.00)
INSERT INTO MenuItem Values(3,'Bean Burrito', 3, 'Veggies,Rice and Beans', 9.00)
INSERT INTO MenuItem Values(4,'Chole Bhature', 4, 'Chickpea gravy with bread', 7.50)
 
SELECT * FROM MenuItem

INSERT INTO TableInfo Values (1,4,1,1,1,1)
INSERT INTO TableInfo Values (2,6,2,3,2,2)
INSERT INTO TableInfo Values (3,8,3,2,3,3)
INSERT INTO TableInfo Values (4,4,4,1,2,2)

SELECT * FROM TableInfo

INSERT INTO TableSitting Values (1,1,'12:43:21','13:21:21',3)
INSERT INTO TableSitting Values (2,2,'12:52:24','13:42:56',6)
INSERT INTO TableSitting Values (3,3,'13:41:12','14:30:43',6)
INSERT INTO TableSitting Values (4,4,'14:53:21','15:11:41',2)

SELECT * FROM TableSitting
DELETE FROM OrderDeliveryItem
DELETE FROM OrderItem
DELETE FROM OrderToken
INSERT INTO OrderToken Values (1,1,1,1,'2019-11-11','12:43:21','13:21:21',1,0)
INSERT INTO OrderToken Values (2,2,2,2,'2019-11-11','13:33:42','13:45:24',1,0)
INSERT INTO OrderToken Values (3,1,3,3,'2019-11-11','14:24:11','14:51:23',1,0)
INSERT INTO OrderToken Values (4,3,3,3,'2019-11-11','14:24:11','14:51:23',1,0)
INSERT INTO OrderToken Values (5,1,1,1,'2019-11-12','12:43:21','13:21:21',1,0)
INSERT INTO OrderToken Values (6,2,2,2,'2019-11-12','13:33:42','13:45:24',1,0)
INSERT INTO OrderToken Values (7,1,3,3,'2019-11-13','14:24:11','14:51:23',1,0)
INSERT INTO OrderToken Values (8,3,3,3,'2019-11-13','14:24:11','14:51:23',1,0)
SELECT * FROM OrderToken

INSERT INTO OrderItem Values(1,1,1,3)
INSERT INTO OrderItem Values(2,2,2,4)
INSERT INTO OrderItem Values(3,3,4,2)
INSERT INTO OrderItem Values(4,3,1,4)
INSERT INTO OrderItem Values(5,4,1,4)
INSERT INTO OrderItem Values(6,5,4,2)
INSERT INTO OrderItem Values(7,6,1,3)
INSERT INTO OrderItem Values(8,7,3,4)
INSERT INTO OrderItem Values(9,8,2,4)
SELECT * FROM OrderItem

INSERT INTO OrderDeliveryItem Values (1,1,1,1)
INSERT INTO OrderDeliveryItem Values (2,2,1,1)
INSERT INTO OrderDeliveryItem Values (3,3,1,1)
INSERT INTO OrderDeliveryItem Values (4,4,1,1)
INSERT INTO OrderDeliveryItem Values (5,2,1,1)
INSERT INTO OrderDeliveryItem Values (6,3,4,1)
INSERT INTO OrderDeliveryItem Values (7,1,3,1)
INSERT INTO OrderDeliveryItem Values (8,2,2,1)
INSERT INTO OrderDeliveryItem Values (9,3,2,1)
SELECT * FROM OrderDeliveryItem


SELECT Sum(OrderToken.orderamount) AS SumOforderamount, OrderToken.orderdate
FROM OrderToken
GROUP BY OrderToken.orderdate;

SELECT Sum(OrderItem.quantity) AS SumOfquantity, MenuItem.itemname, OrderToken.orderdate
FROM (MenuItem INNER JOIN OrderItem ON MenuItem.menuitemid = OrderItem.menuitemid) INNER JOIN OrderToken ON OrderItem.ordertokenid = OrderToken.ordertokenid
GROUP BY MenuItem.itemname, OrderToken.orderdate;

SELECT Count(OrderToken.ordertokenid) AS CountOfordertokenid, OrderToken.orderdate, TableSection.area_description
FROM OrderToken, TableSection
GROUP BY OrderToken.orderdate, TableSection.area_description;

SELECT Sum(TableSitting.numberofpeople) AS SumOfnumberofpeople, OrderToken.orderdate
FROM OrderToken INNER JOIN TableSitting ON OrderToken.tablesittingid = TableSitting.tablesittingid
GROUP BY OrderToken.orderdate;

SELECT Count(OrderToken.ordertokenid) AS CountOfordertokenid, OrderToken.orderdate, OrderToken.staff_id
FROM OrderToken
GROUP BY OrderToken.orderdate, OrderToken.staff_id;



UPDATE OrderToken
SET orderamount = a.totalcost
FROM
(SELECT SUM(OrderItem.quantity*MenuItem.itemcost) as totalcost,OrderToken.ordertokenid
FROM OrderItem,MenuItem,OrderToken
WHERE OrderToken.ordertokenid=OrderItem.ordertokenid 
AND Orderitem.menuitemid=Menuitem.menuitemid
GROUP BY OrderToken.ordertokenid 
) as a
where a.ordertokenid = OrderToken.ordertokenid






GO
CREATE TRIGGER UpdateOrderAmount
ON OrderItem
FOR INSERT,UPDATE
AS
IF @@ROWCOUNT >=1
BEGIN
	UPDATE OrderToken
	SET orderamount = a.totalcost
	FROM
	(SELECT SUM(OrderItem.quantity*MenuItem.itemcost) as totalcost,OrderToken.ordertokenid
	FROM OrderItem,MenuItem,OrderToken
	WHERE OrderToken.ordertokenid=OrderItem.ordertokenid 
	AND Orderitem.menuitemid=Menuitem.menuitemid
	GROUP BY OrderToken.ordertokenid 
	) as a
	where a.ordertokenid = OrderToken.ordertokenid
END;
DROP TRIGGER UpdateOrderAmount