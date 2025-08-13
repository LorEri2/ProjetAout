<?php
session_start();
include('./src/php/utils/header.php');
include('./src/php/utils/all_includes.php');
?>

<!doctype html>
<html>
<head>
    <title><?php print $title; ?></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.min.js"></script>

    <script src="./assets/js/JqueryPC.js" defer></script>
</head>

<body class="bg-light">
<div class="container-fluid px-0 min-vh-100 d-flex flex-column">

    <header class="bg-primary text-white py-4 shadow">
        <div class="container text-center">
            <h1 class="display-5 fw-bold mb-0">Dupont Entreprise</h1>
        </div>
    </header>


    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">
                <?php if(file_exists('src/php/utils/admin_menu.php')) {
                    include('src/php/utils/admin_menu.php');
                } ?>
            </div>
        </div>
    </nav>


    <main class="container my-4 flex-grow-1">
        <div class="card shadow">
            <div class="card-body p-4">
                <?php include('./content/'.$_SESSION['page']); ?>
            </div>
        </div>
    </main>


    <footer class="bg-dark text-white py-3 mt-auto">
        <div class="container text-center">
            <span class="text-light">Dupont Entreprise Utilisateur</span>
        </div>
    </footer>
</div>



</body>
</html>