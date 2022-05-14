select distinct etat.nom
from aéroport, etat, (
    SELECT volallee.aéroportarrivéecode
    FROM vol volallee
             INNER JOIN aviondeligne a ON a.id = volallee.avionid
             INNER JOIN vol volretour ON volretour.aéroportarrivéecode = volallee.aéroportdépartcode AND
                                         volretour.aéroportdépartcode = volallee.aéroportarrivéecode
    WHERE EXTRACT(HOUR FROM volallee.heuredépart) >= 7
      AND EXTRACT(HOUR FROM (volretour.heuredépart - volallee.heurearrivée )) >= 7
      AND volretour.heuredépart::DATE = volallee.heuredépart::DATE) as volok
where aéroport.etatcode=etat.code and volok.aéroportarrivéecode=aéroport.code
;
