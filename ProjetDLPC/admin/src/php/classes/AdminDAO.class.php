<?php

class AdminDAO
{
    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getAdmin($login_admin,$password_admin)
    {
        $query = "select get_admin(:login,:password) as nom";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':login',$login_admin);
            $resultset->bindValue(':password',$password_admin);
            $resultset->execute();
            //$data = $resultset->fetchAll();
            $nom = $resultset->fetchColumn(0);
            $this->_bd->commit();
            return $nom;

        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

}
