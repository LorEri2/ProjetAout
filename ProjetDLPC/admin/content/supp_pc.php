<?php
if (isset($_POST['submit_pc'])) {
    $id = $_POST['id_pc'];
    $pcDAO = new PCDAO($cnx);
    $result = $pcDAO->delete_pc($id);
}
?>



<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="card-title mb-4">Supprimer un PC</h3>
            <form method="post" action="">
                <div class="mb-3">
                    <label for="id_pc" class="form-label">ID du PC à supprimer:</label>
                    <input type="text" class="form-control" name="id_pc" id="id_pc" placeholder="Entrez l'ID ici" required>
                </div>
                <button type="submit" name="submit_pc" class="btn btn-danger">Supprimer le PC</button>
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
            echo "<div class='alert alert-info mt-3'>Aucun PC trouvé pour l’instant</div>";
        }
        ?>
    </div>
</div>
