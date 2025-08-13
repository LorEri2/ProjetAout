<?php

if (isset($_POST['submit_pc'])) {
    $nom = $_POST['nom_pc'];
    $prix = $_POST['prix_pc'];
    $type = $_POST['type_pc'];
    $pcDAO = new PCDAO($cnx);
    $result = $pcDAO->ajouterPC($nom, $prix, $type);

    echo '<div class="container mt-3">';
    if ($result) {
        echo '<div class="alert alert-success" role="alert">✅ Ajout réussi</div>';
    } else {
        echo "<div class='alert alert-danger' role='alert'>❌ Échec de l'ajout</div>";
    }
    echo '</div>';
}
?>




<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="card-title mb-4">Ajouter un PC</h3>
            <form method="post" action="">
                <div class="mb-3">
                    <label for="nom_pc" class="form-label">Nom du PC :</label>
                    <input type="text" class="form-control" name="nom_pc" id="nom_pc" required>
                </div>
                <div class="mb-3">
                    <label for="prix_pc" class="form-label">Prix du PC :</label>
                    <input type="text" class="form-control" name="prix_pc" id="prix_pc" required>
                </div>
                <div class="mb-3">
                    <label for="type_pc" class="form-label">Type du PC :</label>
                    <select class="form-control" name="type_pc" id="type_pc" required>
                        <option value="">Choississez votre type</option>
                        <option value="PC Gamer Portable">PC Gamer Portable</option>
                        <option value="PC Gamer Tour">PC Gamer Tour</option>
                        <option value="Accessoires">Accessoires</option>

                    </select>
                </div>

                <button type="submit" name="submit_pc" class="btn btn-success">Ajouter le PC</button>

            </form>
        </div>
    </div>

    <div class="mt-5">
        <?php
        $pcDAO = new PCDAO($cnx);
        $liste_pcs = $pcDAO->getPC();

        if ($liste_pcs != null && count($liste_pcs) > 0) {
            echo "<h4 class='mt-4 mb-3 text-primary'>🖥️ Liste des PC</h4>";
            echo "<ul class='list-group'>";

            foreach ($liste_pcs as $pc) {
                echo "<li class='list-group-item d-flex justify-content-between align-items-center'>";
                echo "<div>";
                echo "<strong>ID:</strong> " . htmlspecialchars($pc['id_pc']) . " | ";
                echo "<strong>Nom:</strong> " . htmlspecialchars($pc['nom_pc']) . "<br>";
                echo "<strong>💰 Prix:</strong> " . htmlspecialchars($pc['prix_pc']) . " €<br>";
                echo "<strong>🧩 Type:</strong> " . htmlspecialchars($pc['type_pc']);
                echo "</div>";
                echo "</li>";
            }

            echo "</ul>";
        } else {
            echo "<div class='alert alert-info mt-3'>Aucun PC trouvé pour l’instant.</div>";
        }
        ?>
    </div>

</div>
