<?php
$pcDAO = new PCDAO($cnx);
$liste_pcs = $pcDAO->getPC();

if ($liste_pcs != null && count($liste_pcs) > 0) {
    echo "<h2 class='text-center mb-4'>Voici nos PC disponibles 💻</h2>";
    echo "<div class='container'><div class='row justify-content-center'>";

    foreach ($liste_pcs as $pc) {
        echo "<div class='col-md-4 col-sm-6 mb-4'>";
        echo "<div class='card shadow-sm p-3' style='border-radius: 10px;'>";

        echo "<h4 class='text-center text-primary'>" . htmlspecialchars($pc['nom_pc']) . "</h4>";

        echo "<div class='text-center mb-3'>";
        echo "<img src='admin/assets/images/materiel/" . htmlspecialchars($pc["photo_pc"]) . "' class='img-fluid rounded'>";
        echo "</div>";

        echo "<p><strong>💰 Prix :</strong> " . htmlspecialchars($pc['prix_pc']) . " €</p>";
        echo "<p><strong>🖥️ Type :</strong> " . htmlspecialchars($pc['type_pc']) . "</p>";

        echo "</div></div>";
    }

    echo "</div></div>";
} else {
    echo "<p class='text-center'>Aucun PC pour l'instant 😔</p>";
}
?>
