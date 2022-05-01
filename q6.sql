select volAllee.id, volRetour.id
from vol volAllee
         inner join aviondeligne a on a.id = volAllee.avionid
         inner join vol volRetour on volRetour.aéroportarrivéecode = volAllee.aéroportdépartcode and
                                     volRetour.aéroportdépartcode = volAllee.aéroportarrivéecode
where extract(hour from volAllee.heuredépart) >= 7
  and extract(hour from (volAllee.heurearrivée - volRetour.heuredépart)) >= 7
  and volRetour.heuredépart::date = volAllee.heurearrivée::date;

