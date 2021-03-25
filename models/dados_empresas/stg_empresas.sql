
{{ config(materialized='table') }}

with empresas as (

    select
        *
    from public.empresas_csv

),
empresas_calc as (

    select
        *
    from public.empresas_calc_csv

),

stg_empresas as (
    select 
        empresas.cd_cnpj as cd_cnpj,
        {{dbt_utils.surrogate_key('empresas.cd_cnpj', 'empresas.nm_razao_social')}} as sk_cliente,
        empresas.nm_razao_social as nm_razao_social,
        {{dbt_utils.surrogate_key('empresas.nm_municipio', 'empresas.sg_uf')}} as sk_localidade,
        empresas.nm_municipio as nm_municipio,
        empresas.sg_uf as sg_uf,
        {{dbt_utils.surrogate_key('empresas_calc.de_saude_tributaria', 'empresas_calc.de_nivel_atividade')}} as sk_natureza,
        empresas_calc.de_saude_tributaria as de_saude_tributaria,
        empresas_calc.de_nivel_atividade as de_nivel_atividade,
        empresas_calc.vl_total_veiculos_leves as vl_total_veiculos_leves,
        empresas_calc.vl_total_veiculos_pesados as vl_total_veiculos_pesados
    from
    empresas
    join empresas_calc using (cd_cnpj)
)

select distinct
    sk_cliente,
    sk_localidade,
    sk_natureza,
    cd_cnpj,
    nm_razao_social,
    nm_municipio,
    sg_uf,
    de_saude_tributaria,
    de_nivel_atividade,
    vl_total_veiculos_leves,
    vl_total_veiculos_pesados
from stg_empresas