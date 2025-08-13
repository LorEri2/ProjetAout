<?php
class PCDAO {
    private $_bd;

    public function __construct($cnx) {
        $this->_bd = $cnx;
    }

    public function getPC() {
        $query = "SELECT * FROM pc";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            $this->_bd->commit();

            return !empty($data) ? $data : null;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            return null;
        }
    }

    public function ajouterPC($nom, $prix, $type) {
        $query = "Select ajout_pc(:nom_pc, :prix_pc, :type_pc)";
        
        try {
            $this->_bd->beginTransaction();
            $stmt = $this->_bd->prepare($query);
            $stmt->bindValue(':nom_pc', $nom);
            $stmt->bindValue(':prix_pc', $prix);
            $stmt->bindValue(':type_pc', $type);
            $stmt->execute();
            $this->_bd->commit();
            return true;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            return false;
        }
    }

    public function delete_pc($id) {
        $query = "SELECT delete_pc(:id_pc)";
        try {
            $this->_bd->beginTransaction();
            $stmt = $this->_bd->prepare($query);
            $stmt->bindValue(':id_pc', $id);
            $stmt->execute();
            $this->_bd->commit();
        } catch (PDOException $e) {
            $this->_bd->rollBack();
        }
    }

    public function update_ajax_pc($champ, $valeur, $id_pc) {
        try {
            $query = "SELECT update_pc_column(:champ, :valeur, :id_pc)";
            $stmt = $this->_bd->prepare($query);
            $stmt->bindValue(':champ', $champ);
            $stmt->bindValue(':valeur', $valeur);
            $stmt->bindValue(':id_pc', $id_pc);
            $stmt->execute();
            return ['status' => 'success'];
        } catch (Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }
}
