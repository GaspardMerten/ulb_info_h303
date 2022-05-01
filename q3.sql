SELECT id, heurearrivée, heurearrivée, depart.etatcode, arrive.etatcode, aéroportarrivéecode, aéroportdépartcode
from vol
         INNER JOIN aéroport depart ON depart.code = vol.aéroportdépartcode
         INNER JOIN aéroport arrive ON arrive.code = vol.aéroportarrivéecode
where id = (
    SELECT volid
    from réservation
    group by volid
    order by count('*') desc fetch first row only
);
