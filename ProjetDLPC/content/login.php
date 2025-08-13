
<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}


$erreur = "";

if (isset($_POST['login_submit'])) {
    extract($_POST, EXTR_OVERWRITE);

    $adm = new AdminDAO($cnx);
    $nom_admin = $adm->getAdmin($login, $password);

    $nom_admin = $adm->getAdmin($login, $password);

    if ($nom_admin) {
        $_SESSION['admin'] = $nom_admin;
        header('Location: admin/index_.php?page=accueil_admin.php');
        exit;
    } else {
        $erreur = "❌ Identifiant ou mot de passe incorrect.";
    }

}
?>





<form action="<?php print $_SERVER['PHP_SELF'];?>" method="post">
    <div class="mb-3">
        <label for="login" class="form-label">Login</label>
        <input type="text" class="form-control" id="login" name="login">
    </div>
    <div class="mb-3">
        <label for="password1" class="form-label">Password</label>
        <input type="password" class="form-control" id="password1" name="password">
    </div>

    <button type="submit" class="btn btn-primary" name="login_submit">Connexion</button>
</form>
<?php if (!empty($erreur)) : ?>
    <div class="alert alert-danger text-center"><?= $erreur ?></div>
<?php endif; ?>

