-- Ville de départ/arrivée ? :( + plusieurs vols sont TOP vol

SELECT id, heurearrivée, heurearrivée, depart.etatcode, arrive.etatcode, aéroportarrivéecode, aéroportdépartcode
FROM (SELECT *
      FROM vol
      WHERE id = (
          SELECT volid
          FROM réservation
          GROUP BY volid
          ORDER BY COUNT(*) DESC FETCH FIRST ROW ONLY
      )
     ) AS "v*"
         INNER JOIN aéroport depart ON depart.code = "v*".aéroportdépartcode
         INNER JOIN aéroport arrive ON arrive.code = "v*".aéroportarrivéecode

