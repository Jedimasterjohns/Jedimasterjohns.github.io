SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLES IF EXISTS Customers, Donuts, SupplierStoreInter, Suppliers, Stores, Orders;

CREATE OR REPLACE TABLE Customers (
    customerID int UNIQUE NOT NULL AUTO_INCREMENT,
    customerFName varchar(50),
    customerLName varchar(50),
    customerEmail varchar(50),
    customerAddress varchar(50),
    customerPlanet varchar(50),
    PRIMARY KEY (customerID)
);

INSERT INTO Customers (customerID, customerFName, customerLName, customerEmail, customerAddress, customerPlanet)
 VALUES (1, 'Bob', 'Jones', 'Example1@gmail.com', '1000 W Ave, Smallville UT 84123', 'Earth'),
  (2, 'Jane', 'Doe', 'Example2@gmail.com', '1000 E Ave, Biggville WA 98074', 'Venus'),
   (3, 'Bob','Jones', 'Example3@gmail.com', '1000 S Ave, Mediumville CA 91123', 'Mars');

CREATE OR REPLACE TABLE SupplierStoreInter (
    supplierID int NOT NULL,
    storeID int NOT NULL,
    FOREIGN KEY (supplierID) REFERENCES Suppliers(supplierID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY (supplierID,storeID)
);

INSERT INTO SupplierStoreInter (supplierID, storeID)
 VALUES (1,1), (2,2), (3,3),(1,2),(2,3);

CREATE OR REPLACE TABLE Suppliers (
    supplierID int UNIQUE NOT NULL AUTO_INCREMENT,
    supplierName varchar(50),
    PRIMARY KEY (supplierID)
);

INSERT INTO Suppliers (supplierID, supplierName)
 VALUES (1, 'Supplier1'), (2, 'Supplier2'), (3, 'Supplier3');

CREATE OR REPLACE TABLE Donuts (
    donutID int UNIQUE  NOT NULL AUTO_INCREMENT,
    donutName varchar(50),
    donutDescription varchar(1000),
    donutPrice int NOT NULL,
    PRIMARY KEY (donutID),
);

INSERT INTO Donuts (donutID, donutName, donutDescription, donutPrice)
 VALUES (1,'Chocolate Maple', 'Delectable chocolate and maple tree juice', 5),
 (2, 'Pinneapple Squid', 'Pinneapple may not belong on pizza but it does belong with squid', 13),
 (3, 'Oreo and Bacon', 'Crunchy oreo bites with the saltiness of even more crunchy bacon', 19);


CREATE OR REPLACE TABLE Stores (
    storeID int UNIQUE NOT NULL AUTO_INCREMENT,
    storeName varchar(50),
    storeAddress varchar(50),
    storePlanet varchar(50),
    PRIMARY KEY (storeID)
);

INSERT INTO Stores (storeID, storeName, storeAddress, storePlanet)
 VALUES (1, 'Store1', 'Store Address 1', 'Earth'),
 (2, 'Store2', 'Store Address 2', 'Earth'),
 (3, 'Store3', 'Store Address 3', 'Mars');

CREATE OR REPLACE TABLE Orders (
    orderID int UNIQUE NOT NULL AUTO_INCREMENT,
    customerID int NOT NULL,
    donutID int NOT NULL,
    storeID int NOT NULL,
    totalPurchased int NOT NULL,
    PRIMARY KEY (orderID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE,
    FOREIGN KEY (donutID) REFERENCES Donuts(donutID) ON DELETE CASCADE,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID) ON DELETE CASCADE
);

INSERT INTO Orders (orderID, customerID, donutID, totalPurchased, storeID)
VALUES (1, 1, 1, 4,1), (2, 2, 2, 1,2), (3, 3, 2, 44,3);



SET FOREIGN_KEY_CHECKS=1;
COMMIT;