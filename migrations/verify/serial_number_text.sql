-- Verify ocolis:serial_number_text on pg

BEGIN;

-- afin de vérfier qu'un changement de type s'est bien déroulé on peut insérer des données qui seront dans tout les cas supprimer au moment du rollback.
-- Par contre il faut bien être conscient que le fait d'ajouter un nouvel enregistrement va inscrémenter la équence de la colonne d'indentité (id)
-- lors du ROLLBACK la donnée sera bien supprimé mais la séquence restera dans son état apères insertion.
INSERT INTO package (
    serial_number,
    content_description,
    weight,
    volume,
    worth
) VALUES (
    'test',
    '',
    10,
    10,
    10
);

-- 2 possibiltés, on s'en fiche, on laisse comme ça
-- On s'en préoccupe et il faut alors reset la séquence



-- par contre la commande qui ppermet de rest la séquence on ne veut pas qu'elle soit ROLLBACK donc on la founir en dehors de la transaction.

-- On peut essayer de le faire dans la transaction mais ce sera ROLLBACK; Donc on en conclu que c'est impossible de revenir en arrière sur la séquence d'incrémentation de l'id.
-- SELECT setval(pg_get_serial_sequence('package', 'id'), coalesce(MAX(id), 1))
from package;

-- Conclusion : Samuel avait bien raison de s'en fiche.
-- Soit on fait un verify et l'incrémentation d'id n'est pas important, soit on ne vérfie pas.

ROLLBACK;

-- par contre la commande qui ppermet de rest la séquence on ne veut pas qu'elle soit ROLLBACK donc on la founir en dehors de la transaction.

-- Mais en fait c'est dommage on ne peut executer une requête en dehors de la transcation avec sqitch…

-- SELECT setval(pg_get_serial_sequence('package', 'id'), coalesce(MAX(id), 1))
from package;