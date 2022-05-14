/*
    This query just select the maximum from the r column from the previous table. It will return the maximum index
    of a consecutive group of actions on different days for a user.
 */
SELECT piloteid, MAX(r) AS maxconsecutivedays
FROM (
         /*
          Using the power of ROW_NUMBER, assigns an index to each element of a consecutive group.
          For instance, if the pilot realized fight flights on days such as :
                - 1/1/2001
                - 2/1/2001
                - 4/1/2001
                - 5/1/2001
                - 6/1/2001
          Then the row_number based on the specified partitioning will add the following index:
                - 1
                - 2
                - 1
                - 2
                - 3
          */
         SELECT piloteid, ROW_NUMBER() OVER (PARTITION BY value_partition, piloteid) AS r
         FROM (
                  /*
                     Based on the x value defined in the table, using the sum function, assign the same value to each
                     day part of a consecutive group.
                   */
                  SELECT *,
                         SUM(CASE WHEN x IS NULL THEN 0 ELSE 1 END)
                         OVER (PARTITION BY piloteid ORDER BY heure) AS value_partition
                  FROM (
                           /*
                             An other intermediary table with an extra x column which represents whether the row
                             represents a day with an action for a pilot where he also had an action on the previous day.
                            */
                           SELECT id, heure, piloteid, delta, CASE WHEN delta > 1 THEN 1 END x
                           FROM (
                                    /*
                                        Replace the previousHeure by the difference between that same field and
                                        the heure field. This delta is expressed as an integer represeting the number
                                        of days between each action taken by the pilot.
                                     */
                                    SELECT id,
                                           piloteid,
                                           EXTRACT(DAYS FROM heure - previousHeure::DATE) AS delta,
                                           heure
                                    FROM (
                                             /*
                                                Intermediary table containing the previous time the pilot was busy
                                                arriving/departing from some place. Thus each row of the table contains
                                                the time of the current and past actions.
                                              */
                                             SELECT id,
                                                    heure,
                                                    piloteid,
                                                    LAG(heure::DATE)
                                                    OVER (PARTITION BY piloteid ORDER BY heure) AS previousHeure
                                             FROM (
                                                      /* It does not make any difference to consider the departure
                                                      and arrival time as being different, the decoupling of both allows
                                                      for a simpler comparison later on. */
                                                      SELECT id, heuredépart AS heure, piloteid
                                                      FROM vol
                                                      UNION
                                                      SELECT id, heurearrivée AS heure, piloteid
                                                      FROM vol
                                                  ) AS union_heuredepart_heurearrivee
                                         ) AS pd
                                ) AS p
                               /* Excluding rows with a delta equals to zero prevent the query from counting a day with
                                two actions as two consecutive days of work */
                           WHERE delta > 0
                              OR delta IS NULL
                       ) AS p2
              ) AS "*vp"
     ) AS "*2r"
GROUP BY piloteid;
