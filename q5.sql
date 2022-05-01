select distinct a.average_dist, (v.heurearrivée :: date) as date, c.nom
from vol v, company c,
     (select  distinct avion.compagnieid, avion.id,
                to_char(
                    AVG(distance),'99999999999999999D99'
                    )AS average_dist
                from   vol
                INNER JOIN avion ON avion.id = vol.avionid
                group by
                        avion.id
                order by
                        id) as a
where a.compagnieid=c.id and a.id= v.avionid and
      (c.nom = 'ADVANCED AIR, LLC' or c.nom = 'ABX Air Inc');










