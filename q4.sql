SELECT u.nom
FROM pilote
         INNER JOIN utilisateur u ON u.id = pilote.id
WHERE NOT EXISTS(
        SELECT pilote.id
        FROM vol,
             aviondefret
        WHERE vol.piloteid = pilote.id
          AND vol.avionid = aviondefret.id
    );
