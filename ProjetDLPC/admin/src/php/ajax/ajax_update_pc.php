<?php


header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../classes/Autoloader.class.php';
Autoloader::register();


require_once __DIR__ . '/../db/db_pg_connect.php';


/*
require __DIR__ . '/../db/db_pg_connect.php';
require __DIR__ . '/../classes/Connection.class.php';
require __DIR__ . '/../classes/Pc.class.php';
require __DIR__ . '/../classes/PCDAO.class.php';
*/
try {
    $cnx = Connection::getInstance($dsn, $user, $password);
    $pc = new PCDAO($cnx);

    $tab = $pc->update_ajax_pc($_GET['champ'], $_GET['valeur'], $_GET['id_pc']);

    echo json_encode($tab);
} catch (Exception $e) {
    $error = [
        'status' => 'error',
        'message' => $e->getMessage()
    ];
    echo json_encode($error);
}


