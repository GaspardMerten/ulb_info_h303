/*
    Counts the number of flights where the aircraft is of cargo type
 */
SELECT COUNT(*)
FROM aviondefret a
         INNER JOIN vol v ON v.avionid = a.id
