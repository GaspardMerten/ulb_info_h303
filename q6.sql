select distinct e1.nom, e2.nom
from aéroport a1,aéroport a2, etat e1, etat e2, (
    SELECT volallee.aéroportarrivéecode, volallee.aéroportdépartcode
    FROM vol volallee
             INNER JOIN aviondeligne a ON a.id = volallee.avionid
             INNER JOIN vol volretour ON volretour.aéroportarrivéecode = volallee.aéroportdépartcode AND
                                         volretour.aéroportdépartcode = volallee.aéroportarrivéecode
    WHERE EXTRACT(HOUR FROM volallee.heuredépart) >= 7
      AND EXTRACT(HOUR FROM (volretour.heuredépart - volallee.heurearrivée )) >= 7
      AND volretour.heuredépart::DATE = volallee.heuredépart::DATE) as volok
where a1.etatcode=e1.code and volok.aéroportarrivéecode=a1.code and
      a2.etatcode=e2.code and volok.aéroportdépartcode=a2.code
;
