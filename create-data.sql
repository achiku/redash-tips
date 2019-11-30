
insert into dummy_time (tm) 
select 
generate_series(
  '2019-09-01 00:00:00 JST'::timestamptz,
  '2019-12-01 00:00:00 JST'::timestamptz,
  '10 second'
);

insert into coolec_user (registered_at, gender, birthday)
select
  t at time zone 'jst'
  , ('{1,2,1,2,1,2,1,2,1,2,1,2,0}'::integer[])[ceil(random()*13)] -- 6:6:1=male:female:unknown
  , date_trunc('day', '2007-01-01 00:00:00'::timestamp - '1 year'::interval * round(random() * 40) - '1 day'::interval * round(random() * 365))
from (
  -- very small
  select
    tm at time zone 'jst' t
  from dummy_time
  tablesample bernoulli(5)
  where (
    extract(hour from tm at time zone 'jst') >= 3 and extract(hour from tm at time zone 'jst') < 6
  )
  union
  -- small
  select
    tm at time zone 'jst' t
  from dummy_time
  tablesample bernoulli(20)
  where (
    extract(hour from tm at time zone 'jst') >= 2 and extract(hour from tm at time zone 'jst') < 3
  ) or (
    extract(hour from tm at time zone 'jst') >= 6 and extract(hour from tm at time zone 'jst') < 8
  )
  union
  -- normal
  select
    tm at time zone 'jst' t
  from dummy_time
  tablesample bernoulli(25)
  where (
    extract(hour from tm at time zone 'jst') >= 0 and extract(hour from tm at time zone 'jst') < 2
  ) or (
    extract(hour from tm at time zone 'jst') >= 8 and extract(hour from tm at time zone 'jst') < 12
  ) or (
    extract(hour from tm at time zone 'jst') >= 14 and extract(hour from tm at time zone 'jst') < 22
  )
  union
  -- large
  select
    tm at time zone 'jst' t
  from dummy_time
  tablesample bernoulli(40)
  where (
    extract(hour from tm at time zone 'jst') >= 12 and extract(hour from tm at time zone 'jst') < 14
  ) or (
    extract(hour from tm at time zone 'jst') >= 22 and extract(hour from tm at time zone 'jst') <= 24
  )
) d  
order by d.t
;
