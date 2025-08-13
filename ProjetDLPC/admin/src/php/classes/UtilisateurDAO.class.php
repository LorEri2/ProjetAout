<?php

class UtilisateurDAO
{
    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getUtilisateur($login_utilisateur,$password_utilisateur)
    {
        $query = "select get_utilisateur(:login,:password) as nom";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':login',$login_utilisateur);
            $resultset->bindValue(':password',$password_utilisateur);
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

