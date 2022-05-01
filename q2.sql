SELECT pilote.id, licence
FROM pilote INNER JOIN voyageur v on v.id = pilote.id
