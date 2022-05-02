select company.nom, avg(numberOfPassengers) as avgnumberOfPassengers
from (
         select volid, a.compagnieid, count(*) as numberOfPassengers
         from vol
                  inner join avion a on a.id = vol.avionid
                  inner join réservation r on r.volid = vol.id
         group by volid, a.compagnieid
        having count('*') < 20
     ) as vc
inner join company on compagnieid = company.id
group by company.nom order by avgnumberOfPassengers;
