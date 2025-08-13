<!--Fichier non-utilisé??   -->

<?php
    /*<require_once __DIR__ . '/../src/php/classes/Connection.class.php';
    require_once __DIR__ . '/../src/php/classes/Pc.class.php';
    require_once __DIR__ . '/../src/php/classes/PCDAO.class.php';
    require_once __DIR__ . '/../src/php/db/db_pg_connect.php';*/




$pcDAO = new PCDAO($cnx);
$liste_pcs = $pcDAO->getPC();
?>


<div class="container mt-4">
    <h2 class="text-center mb-4">💻 Modifier les informations des PC</h2>

    <table class="table table-bordered table-hover text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prix</th>
            <th>Type</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($liste_pcs as $pc): ?>
            <tr>
                <td><?= htmlspecialchars($pc['id_pc']) ?></td>
                <td id="<?= $pc['id_pc'] ?>" data-champ="nom_pc" contenteditable="true"><?= htmlspecialchars($pc['nom_pc']) ?></td>

                <td id="<?= $pc['id_pc'] ?>" data-champ="prix_pc" contenteditable="true"><?= htmlspecialchars($pc['prix_pc']) ?></td>

                <td id="<?= $pc['id_pc'] ?>" data-champ="type_pc" contenteditable="true"><?= htmlspecialchars($pc['type_pc']) ?></td>


            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>

    <div id="msg" class="text-center mt-3"></div>
</div>




