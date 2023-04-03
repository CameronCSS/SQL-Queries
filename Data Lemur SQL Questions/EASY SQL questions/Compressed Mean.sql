-- You are trying to find the mean number of items bought per order on Alibaba, rounded to 1 decimal place.

-- However, instead of doing analytics on all Alibaba orders, you have access to a summary table, 
    -- which describes how many items were in an order (item_count), and the number of orders that had that many items (order_occurrences).
    
-- items_per_order Example Table: --
 | item_count | order_occurrences |
 |:----------:|:-----------------:|
 |      1     |        500        |
 |      2     |        1000       |
 |      3     |        800        |
 |      4     |        1000       |
 
 
 -- Solution: --
 WITH items AS (
SELECT SUM(item_count * order_occurrences):: numeric AS Total_items, SUM(order_occurrences):: numeric AS Total_orders
FROM items_per_order
)

SELECT ROUND((Total_items / Total_orders),1) AS mean FROM items


-- Output --
 | mean |
 |:----:|
 |  3.9 |
