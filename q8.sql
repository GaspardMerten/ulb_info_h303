SELECT piloteid, MAX(r) AS maxconsecutivedays
FROM (
         SELECT piloteid, ROW_NUMBER() OVER (PARTITION BY value_partition, piloteid) AS r
         FROM (
                  SELECT *,
                         SUM(CASE WHEN x IS NULL THEN 0 ELSE 1 END)
                         OVER (PARTITION BY piloteid ORDER BY heuredépart) AS value_partition
                  FROM (
                           SELECT id, heuredépart, piloteid, delta, CASE WHEN delta > 1 THEN id END x
                           FROM (
                                    SELECT id,
                                           piloteid,
                                           EXTRACT(DAYS FROM heuredépart - previousdate::DATE) AS delta,
                                           heuredépart
                                    FROM (
                                             SELECT id,
                                                    heuredépart,
                                                    piloteid,
                                                    LAG(heuredépart::DATE)
                                                    OVER (PARTITION BY piloteid ORDER BY heuredépart) AS previousdate
                                             FROM vol
                                         ) AS pd
                                ) AS p
                           WHERE delta > 0
                              OR delta IS NULL
                       ) AS p2
              ) AS "*vp"
     ) AS "*2r"


GROUP BY piloteid;