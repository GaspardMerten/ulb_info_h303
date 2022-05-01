select id
from pilote
where not EXISTS(
        select pilote.id
        from vol,
             aviondefret
        where vol.piloteid = pilote.id
          and vol.avionid = aviondefret.id
    );


select avionid
from avion, vol,
     pilote
where avion.id = vol.avionid and vol.piloteid = pilote.id
