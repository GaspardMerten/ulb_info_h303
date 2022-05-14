/*
    Lists the number of pilots that did travel at least one as passenger.
 */
SELECT pilote.id
FROM pilote
         INNER JOIN voyageur v ON v.id = pilote.id