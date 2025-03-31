select
    line_item.order_item_key,
    line_item.part_key,
    line_item.line_number,
    line_item.extended_price,
    orders.orderkey,
    orders.customer_key,
    orders.order_date,
    {{ discounted_amount('line_item.extended_price', 'line_item.discount_percentage') }} as item_discount_amount
from
    {{ ref('stg_tpch_orders') }} as orders 
join 
    {{ ref('stg_tpch_line_item') }} as line_item
        on orders.orderkey = line_item.order_key
-- where
--     orders.o_orderdate >= '1993-01-01'
--     and orders.o_orderdate < '1994-01-01'
--     and line_item.l_returnflag = 'R'
order by 
    orders.order_date

