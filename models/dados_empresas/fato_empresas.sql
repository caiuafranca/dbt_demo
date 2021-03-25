
with empresas as (

    select * from {{ ref('stg_empresas') }}

),

stg_metrics as (

    select
        cd_cnpj,
        sk_cliente,
        sk_localidade,
        sk_natureza,
        sum(vl_total_veiculos_leves) as vl_total_leves,
        sum(vl_total_veiculos_pesados) as vl_total_pesados

    from empresas

    group by cd_cnpj, sk_cliente, sk_localidade, sk_natureza

),

final as (
    select
        empresas.cd_cnpj,
        empresas.sk_cliente,
        empresas.sk_localidade,
        empresas.sk_natureza,
        stg_metrics.vl_total_leves,
        stg_metrics.vl_total_pesados
        from empresas
        inner join stg_metrics using (cd_cnpj)
)

select * from final
