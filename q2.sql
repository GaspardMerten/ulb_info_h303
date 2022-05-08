SELECT pilote.id
FROM pilote
         INNER JOIN voyageur v ON v.id = pilote.id