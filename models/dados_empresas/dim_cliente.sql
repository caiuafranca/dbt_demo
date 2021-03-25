{{ config(materialized='table') }}

with stg_empresas as (

    select
        *
    from public.stg_empresas

),

dim_cliente as (
    select distinct
        sk_cliente,
        nm_razao_social
    from
    stg_empresas
    where sk_cliente is not null
)

select 
    *
from dim_cliente