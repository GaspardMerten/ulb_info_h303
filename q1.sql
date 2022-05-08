SELECT COUNT(*)
FROM aviondefret a
         INNER JOIN vol v ON v.avionid = a.id
