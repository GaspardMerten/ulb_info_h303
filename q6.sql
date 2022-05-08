SELECT volallee.id, volretour.id
FROM vol volallee
         INNER JOIN aviondeligne a ON a.id = volallee.avionid
         INNER JOIN vol volretour ON volretour.aéroportarrivéecode = volallee.aéroportdépartcode AND
                                     volretour.aéroportdépartcode = volallee.aéroportarrivéecode
WHERE EXTRACT(HOUR FROM volallee.heuredépart) >= 7
  AND EXTRACT(HOUR FROM (volallee.heurearrivée - volretour.heuredépart)) >= 7
  AND volretour.heuredépart::DATE = volallee.heurearrivée::DATE;

