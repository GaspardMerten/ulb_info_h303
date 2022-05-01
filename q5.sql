select distinct v.distance, v.heurearrivée :: date, c.nom
from vol v, company c,
     (select   avion.compagnieid, avion.id,
                to_char(
                    AVG(distance),'99999999999999999D99'
                    )AS average_amount
                from   vol
                INNER JOIN avion ON avion.id = vol.avionid
                group by
                        avion.id, vol.heurearrivée::date
                order by
                        id) as a

where a.compagnieid=c.id and a.id= v.avionid and
      (c.nom = 'ADVANCED AIR, LLC' or c.nom = 'ABX Air Inc');










