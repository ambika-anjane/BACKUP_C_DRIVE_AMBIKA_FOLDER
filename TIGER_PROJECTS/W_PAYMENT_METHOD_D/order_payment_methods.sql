with
    fnd_lookup as (select * from {{ ref("stg_oracle__fnd_lookups") }}),

    lkp_fnd_lookup as (
        select
            fnd_lookup.lookup_code payment_method_code,
            coalesce(fnd_lookup.enabled_flag, 'Y') active_flag,
           -- to_char(fnd_lookup.created_by) created_by_id,
           -- to_char(fnd_lookup.last_updated_by) changed_by_id,
          --  fnd_lookup.creation_date created_on_date,
          --  fnd_lookup.last_update_date changed_on_date,
            'N' delete_flag,
            fnd_lookup.lookup_code lookup_code,
            fnd_lookup._source_id source_id,
            fnd_lookup.meaning meaning,
            fnd_lookup.description description,
          --  fnd_lookup.language,
            fnd_lookup._batch_update_date _batch_update_date
        from fnd_lookup
        where
            (1 = 1)
            and (fnd_lookup.lookup_type = 'PAYMENT TYPE')
          --  and (fnd_lookup.view_application_id = 660)
          --  and (fnd_lookup.security_group_id = 0)
           -- and (fnd_lookup.language = 'US')

    )
select *
from lkp_fnd_lookup
