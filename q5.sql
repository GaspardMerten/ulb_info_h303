SELECT ROUND(AVG(vol.distance)::NUMERIC, 2), c.nom, heuredépart::DATE
FROM vol
         INNER JOIN avion a ON a.id = vol.avionid
         INNER JOIN company c ON c.id = a.compagnieid
WHERE c.nom IN ('ABX Air Inc', 'ADVANCED AIR, LLC')
GROUP BY heuredépart::DATE, c.nom;


