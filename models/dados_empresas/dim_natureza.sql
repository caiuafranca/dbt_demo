{{ config(materialized='table') }}

with stg_empresas as (

    select
        *
    from public.stg_empresas

),

dim_natureza as (
    select distinct
        sk_natureza,
        de_saude_tributaria,
        de_nivel_atividade
    from
    stg_empresas
    where sk_natureza is not null
)

select 
    *
from dim_natureza