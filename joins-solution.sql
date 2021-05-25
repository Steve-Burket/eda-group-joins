--Tasks
-- 1. Get all customers and their addresses.
SELECT "customers"."first_name", "customers"."last_name", "addresses"."street", "addresses"."city", "addresses"."state", "addresses"."zip"
FROM "customers"
JOIN "addresses" ON "addresses"."customer_id" = "customers"."id";

-- 2. Get all orders and their line items (orders, quantity and product).
SELECT "orders"."id", "line_items"."quantity", "products"."description" 
FROM "orders"
JOIN "line_items" ON "line_items"."order_id" = "orders"."id"
JOIN "products" ON "products"."id" = "line_items"."product_id";

-- 3. Which warehouses have cheetos? - Looks like delta warehouse is the only one to have cheetos
SELECT "products"."description", "warehouse"."warehouse", "warehouse_product"."on_hand"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product"."product_id" = "products"."id"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "products"."description" = 'cheetos';


-- 4. Which warehouses have diet pepsi? - warehouses alpha, delta, and gamma all have diet pepsi.
SELECT "products"."description", "warehouse"."warehouse", "warehouse_product"."on_hand"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product"."product_id" = "products"."id"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "products"."description" = 'diet pepsi';


-- 5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT COUNT("orders"."id"), "customers"."first_name", "customers"."last_name"
FROM "customers" 
JOIN "addresses" ON "addresses"."customer_id" = "customers"."id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
GROUP BY "customers"."first_name", "customers"."last_name";

-- 6. How many customers do we have? = 4
SELECT COUNT(*)
FROM "customers";


-- 7. How many products do we carry? = 7
SELECT COUNT(*)
FROM "products";


-- 8. What is the total available on-hand quantity of diet pepsi? 
-- 92 on hand. I don't think this is right though. 
-- I couldn't get it to give me the total sum of diet in one spot.
SELECT SUM("warehouse_product"."on_hand"), "products"."description"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product"."product_id" = "products"."id"
WHERE "products"."description" = 'diet pepsi'
GROUP BY "warehouse_product"."on_hand", "products"."description";

--Stretch
-- 9. How much was the total cost for each order?
-- 10. How much has each customer spent in total?
-- 11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
