-- Verify ocolis:initialize on pg

BEGIN;

-- Ici on va mettre des requêtes SQL qui permettent de vérifier que le deploy a ce statde, c'est bien déroulé comme prévu.
-- C'est un endroit on l'on peut, et on va, utiliser du DML (Dans la majorité cas ce sera de la lecture SELECT)

-- Ici ce que l'on veut vérifier à travers une requête de lecture, c'est la structure et pas les données. Donc pour simplifier les données on s'en tape !
-- Ce que l'on veut vérifier c'est que la table existe, qu'elle contien une certaines colonnes et puis c'est tout
SELECT
-- donc on liste les champs censé être présents
    id,
    reference,
    name,
    address,
    additional,
    postal_code,
    city
FROM place
-- Et on filtre les données pour qu'aucune ne remontent, au cas ou il y en des millions ou même milliards !
WHERE false
;
-- le but ici c'est que la requeête ne fasse pas d'erreurs, si elle en fait une sqitch nous diras que cela ne s'est pas bien passé


SELECT
    id,
    serial_number,
    content_description,
    weight,
    volume,
    worth,
    sender_id,
    recipient_id
FROM package
WHERE false;


-- D'ailleurs on voit bien ici que le résultat ce que l'on fait dans ce script n'est pas pas important on vérifie juste le bon déroulement et on fait comme si on avait jamais exécuter ces requêtes
-- Que cela se passe bien ou pas, il fera dans tous les cas un rollback.
ROLLBACK;
