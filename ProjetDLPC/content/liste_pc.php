

<div class="container mt-5">
    <?php
    $pcDAO = new PCDAO($cnx);
    $liste_pcs = $pcDAO->getPC();

    if ($liste_pcs != null && count($liste_pcs) > 0) {
        echo "<h3 class='mb-4'>Liste des PC</h3>";
        echo "<ul class='list-group'>";
        foreach ($liste_pcs as $pc) {
            echo "<li class='list-group-item'>" . $pc['id_pc'] . " ➜ " . htmlspecialchars($pc['nom_pc']) . "</li>";
        }
        echo "</ul>";
    } else {
        echo "<div class='alert alert-warning'>Aucun PC pour l'instant.</div>";
    }
    ?>
</div>
