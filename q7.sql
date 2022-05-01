select distinct c.nom, sol.average_passenger

from  ( select distinct  avion.compagnieid,
                to_char(
                    AVG(passengers),'99999999999999999D99'
                    )AS average_passenger
        from   (SELECT distinct volid, count('*') as passengers
                from réservation
                group by volid
                having count('*')<20) as vp, vol
        INNER JOIN avion ON avion.id = vol.avionid
        where vp.volid = vol.id
        group by
            avion.compagnieid
        order by
            compagnieid) as  sol, company c
where c.id=sol.compagnieid
order by sol.average_passenger
;
select distinct nom
from company