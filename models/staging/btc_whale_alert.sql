
{{config(materialized = 'incremental')}}

with cte as (
select * from {{ ref('stg_btc_transactions') }})

select {{volumeadd('cte.VOLUME_USD')}} as volume from cte 
{% if is_incremental() %}
where 
to_date(to_timestamp(replace(cte.event_date, ' UTC', ''))) >= current_date()
{% endif %}