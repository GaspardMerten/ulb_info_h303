SELECT pilote.id, licence
FROM pilote, voyageur
WHERE pilote.id = voyageur.id