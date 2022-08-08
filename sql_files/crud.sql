--CUSTOMER FUNCTIONS
select count(customerID) from Customers;
--CUSTOMER CRUD
-- create new customer (CREATE)
INSERT INTO  Customers (customerFName, customerLName, customerEmail, customerAddress, customerPlanet) 
    VALUES (:FNameInput, :LNameInput, :EmailInput, :AddressInput, :PlanetInput);
-- get all customers (READ)
SELECT * from Customers;
-- select certain customer 
SELECT customerID, customerFName, customerLName, customerEmail, customerAddress, customerPlanet
    FROM Customers
    WHERE customerID = :Select_Certain_Customer_ID;
-- Update Customer (UPDATE)

UPDATE Customers 
    SET customerFName = :FName_Input, customerLName = :LName_Input, customerEmail = :Email_Input, customerAddress = :Address_Input, customerPlanet = :Planet_Input
    WHERE customerID = :Update_Character_ID
-- Delete Customer (Delete)
DELETE FROM Customers WHERE customerID = :Delete_Customer_ID



--DONUT FUNCTIONS
--get all names
SELECT DonutName FROM Donuts;
--number of donuts
select count(DonutID) from Donuts;
--DONUT CRUD
-- create new donut
INSERT INTO Donuts (donutName, donutDescription, donutPrice)
    VALUES (:donutNameInput,:donutDescriptionInput, :donutPriceInput)
-- get all donuts
SELECT * FROM Donuts
-- select certain donut
SELECT donutID, donutName, donutDescription, donutPrice
    FROM Donuts 
    WHERE donutID = :Selected_Donut_Edit_ID
-- update certain donut
UPDATE Donuts
    SET donutName = :Donut_Name_Input, donutDescription = :Donut_Description_Input, donutPrice = :Donut_Price_Input
    WHERE donutID = :Update_Donut_ID
-- delete donut
DELETE FROM Donuts WHERE donutID = :Delete_Donut_ID



--ORDER FUNCTIONS
--get total money from certain order
select Donuts.donutPrice*Orders.totalPurchased as total FROM Orders INNER JOIN Donuts ON Orders.donutID = Donuts.donutID WHERE OrderID = :Get_Total_Order_Money;
--get total money for all orders
select Sum(Donuts.donutPrice*Orders.totalPurchased) as total FROM Orders INNER JOIN Donuts ON Orders.donutID = Donuts.donutID;
--ORDER CRUD
-- delete order
DELETE FROM Orders WHERE orderID = :Delete_Order_ID;
-- new order
INSERT INTO Orders (customerID,donutID,storeID,totalPurchased)
    VALUES (:Order_CustomerID_Input,:Order_DonutID_Input,:Order_StoreID_Input,:Order_TotalPurchased_Input);
-- get orders and display donut and store names
SELECT Orders.* , Customers.customerFName, Donuts.donutName, Stores.storeName From Orders JOIN Customers ON Orders.customerID = Customers.customerID LEFT JOIN Donuts ON Orders.donutID = Donuts.donutID JOIN Stores ON Orders.storeID = Stores.storeID;




--STORE FUNCTION
--get what suppliers supply to this store
SELECT Suppliers.supplierName FROM Suppliers
    Join SupplierStoreInter ON Suppliers.supplierID = SupplierStoreInter.supplierID 
    where SupplierStoreInter.storeID = :Get_Suppliers;
--STORE CRUD
INSERT INTO Stores (storeName, storeAddress, storePlanet)
    VALUES (:StoreName_Input,:StoreAddress_Input,:StorePlanet_Input);
--get all stores
SELECT * from Stores;
--get specific store
SELECT storeID, storeName, storeAddress, storePlanet
    FROM Stores
    WHERE storeID = :Select_Certain_Store_ID;
--update store (NEEDS FIX FOR SUPPLIERID CHANGE)
UPDATE Stores
    UPDATE SupplierStoreInter SET supplierID = updateSupplier, storeID = updateStore}
     WHERE supplierID = updateOriginalSuppplier AND storeID = updateOriginalStore;
--delete store
DELETE FROM Stores WHERE storeID = :Delete_Store_ID



--SUPPLIER FUNCTIONS
--get what stores supplier supplies to
SELECT Stores.storeName FROM Stores
    Join SupplierStoreInter ON Stores.storeID = SupplierStoreInter.storeID 
    where SupplierStoreInter.supplierID = :Get_Supplied_Stores;
--SUPPLIER CRUD
--new suppluer
INSERT INTO Suppliers (supplierName)
    VALUES (:SupplierName_Input);
--get all suppliers
SELECT * from Suppliers;
--get specific supplier
Select supplierID, supplierName 
    FROM Suppliers
    WHERE SupplierID = :Select_Certain_Supplier_ID;
--update supplier
UPDATE Suppliers 
    SET supplierName = :SupplierName_Change
    WHERE SupplierID = :Update_SupplierID;
--delete supplier
DELETE FROM Suppliers Where supplierID = :Delete_Supplier_ID;



--SupplierStoreInter FUNCTIONS
--see all suppliers and stores ID
select * from SupplierStoreInter Order by supplierID ASC;
--see all suppliers and store names
SELECT Suppliers.supplierName, Stores.storeName from SupplierStoreInter Join Suppliers ON SupplierStoreInter.supplierID = Suppliers.supplierID JOIN Stores ON SupplierStoreInter.storeID = Stores.storeID Order by Suppliers.supplierID ASC;

-- add a store-supplier connection
INSERT into SupplierStoreInter (supplierID,storeID) VALUES (:SupplierStoreInter_SupplierID,:SupplierStoreInter_StoreID);


--update a supplier to store
UPDATE SupplierStoreInter SET supplierID = :Selected_Supplier, storeID = :New_StoreID WHERE supplierID = :Selected_Supplier;
--update a store to a supplier
UPDATE SupplierStoreInter SET storeID = :Selected_Store, supplierID = :New_SupplierID WHERE  storeID = :Selected_Store;


--delete a connection

DELETE FROM SupplierStoreInter Where supplierID = :Selected_SupplierID AND storeID = :Selected_StoreID;

