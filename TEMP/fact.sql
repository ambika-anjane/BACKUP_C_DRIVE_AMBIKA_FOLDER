select 
    amount,
    payment_method 
    from {{ref('stg_payments')}}
    left join {{ref('stg_order')}}
    using (order_id)
 


-- int_pivoted.sql
{% set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}



select
    order_id,
    {% for payment_method in payment_methods %}
    sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
    {% endfor %}
    sum(amount) as total_amount
from {{ref('stg_payments')}}
group by 1



--- total_revenue (under analysis) folder
with payments as ( 
    select * from {{ref('stg_payments')}}
)

aggregate as (
    select
    sum(amount)as aggregrate
    from payments
    where status = 'success'
)