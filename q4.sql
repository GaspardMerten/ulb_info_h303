SELECT distinct u.prénom, u.nom
FROM pilote
         INNER JOIN utilisateur u ON u.id = pilote.id
         inner join vol v on v.piloteid=u.id
WHERE NOT EXISTS(
        SELECT *
        FROM vol
                 LEFT JOIN aviondeligne adl ON adl.id = vol.avionid
        WHERE vol.piloteid = u.id
          AND adl.id IS NULL);
