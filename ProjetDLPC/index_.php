<?php
session_start();
include('./admin/src/php/utils/header.php');
include('./admin/src/php/utils/all_includes.php');
?>

<!doctype html>
<html>
<head>
    <title><?php print $title; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="admin/assets/js/JqueryPC.js"></script>
</head>

<body class="bg-light">
<div class="container-fluid px-0">

    <header class="bg-primary text-white text-center py-4 mb-4 shadow">
        <h1 class="display-5 fw-bold">Dupont Entreprise</h1>
    </header>


    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
        <div class="container">
            <?php if(file_exists('admin/src/php/utils/public_menu.php')){
                include('admin/src/php/utils/public_menu.php');
            } ?>
        </div>
    </nav>


    <main class="container mb-5">
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">
                <?php
                if(file_exists('./content/'.$_SESSION['page'])){
                    $path = './content/'.$_SESSION['page'];
                    include($path);
                }
                ?>
            </div>
        </div>
    </main>


    <footer class="bg-dark text-white py-3 mt-auto">
        <div class="container text-center">
            <span class="text-muted">© 2025 Dupont Entreprise - Tous droits réservés</span>
        </div>
    </footer>
</div>
</body>
</html>