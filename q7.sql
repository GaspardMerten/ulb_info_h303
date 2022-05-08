SELECT company.nom, AVG(numberofpassengers) AS avgnumberofpassengers
FROM (
         SELECT volid, a.compagnieid, COUNT(*) AS numberofpassengers
         FROM vol
                  INNER JOIN avion a ON a.id = vol.avionid
                  INNER JOIN réservation r ON r.volid = vol.id
         GROUP BY volid, a.compagnieid
     ) AS vc
         INNER JOIN company ON compagnieid = company.id
WHERE numberofpassengers < 20
GROUP BY company.nom
ORDER BY avgnumberofpassengers;
