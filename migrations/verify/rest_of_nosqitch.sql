-- Verify ocolis:rest_of_nosqitch on pg

BEGIN;

-- On aurai pu faire ce genre de requête pour tester si la contrainte d'unicité fonctionne ou pas, mais pour valider le fait qu'elle fonctionne il faut générer une erreur, donc faire en sorte que'il ne valide pas la vérification. C'est tout l'inverse du systeme de fonctionnment du verify de sqitch.
-- Donc dans nombreux cas, le verify de sqitch ce n'est pas son meilleur atout, surtout que les scripts de vérifications trop précis deviennent obsolète au fur et a mesure de l'avolution de la BDD
/*
INSERT INTO package (
    serial_number,
    content_description,
    weight,
    height,
    width,
    depth,
    worth
) VALUES (
    'test',
    '',
    10,
    10,
    10,
    10,
    10
),
(
    'test',
    '',
    10,
    10,
    10,
    10,
    10
);
*/

-- Si l'on désire vérifier la bonne existance de colonnes dans une table on na pourra pas au bout d'un moment faire une vérification complète de la migration.
SELECT 
    height, 
    width, 
    depth, 
    request_time,
    expedition_time,
    delivered_time
FROM package 
WHERE false;

ROLLBACK;
