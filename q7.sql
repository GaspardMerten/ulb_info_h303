
select distinct c.nom, sol.average_passenger
from  ( select distinct  avion.compagnieid,
                to_char(
                    AVG(passengers),'99999999999999999D99'
                    )AS average_passenger
        from   (SELECT distinct r.volid, COUNT('*') AS passengers
                from réservation r
                group by r.volid
                having count('*')<20) as vp,
                company c, vol
        INNER JOIN avion ON avion.id = vol.avionid
        where vol.id = vp.volid
        group by
            avion.compagnieid
        order by
            compagnieid) as  sol, company c
where c.id=sol.compagnieid
order by sol.average_passenger
;
