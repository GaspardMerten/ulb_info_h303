select piloteid, max(r) as maxConsecutiveDays
from (
         select piloteid, row_number() over (partition by value_partition, piloteid) as r
         from (
                  select *,
                         sum(case when x is null then 0 else 1 end)
                         over (partition by piloteid order by heuredépart) as value_partition
                  from (
                           select id, heuredépart, piloteid, delta, case WHEN delta > 1 then id end x
                           from (
                                    select id,
                                           piloteid,
                                           extract(days from heuredépart - previousDate::date) as delta,
                                           heuredépart
                                    from (
                                             select id,
                                                    heuredépart,
                                                    piloteid,
                                                    lag(heuredépart::date)
                                                    over (partition by piloteid ORDER BY heuredépart) as previousDate
                                             from vol
                                         ) as pd
                                ) as p
                           where delta > 0 or delta IS NULL
                       ) as p2
              ) as "*vp"
     ) as "*2r"


group by piloteid;