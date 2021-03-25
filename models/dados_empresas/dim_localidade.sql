{{ config(materialized='table') }}

with stg_empresas as (

    select
        *
    from public.stg_empresas

),

dim_localidade as (
    select distinct
        sk_localidade,
        nm_municipio,
        sg_uf
    from
    stg_empresas
    where sk_localidade is not null
)

select 
    *
from dim_localidade