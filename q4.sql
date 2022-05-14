SELECT u.prénom
FROM pilote
         INNER JOIN utilisateur u ON u.id = pilote.id
WHERE NOT EXISTS(
        SELECT *
        FROM vol
                 LEFT JOIN aviondeligne adl ON adl.id = vol.avionid
        WHERE vol.piloteid = u.id
          AND adl.id IS NULL
    )
  AND EXISTS(SELECT * FROM vol WHERE vol.piloteid = u.id);
