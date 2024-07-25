<?php
include "PlanVacacional.php";
include "Entrega.php";

class Dia {

    public string $dia;
    public PlanVacacional $plan;
    public Entrega $entrega;

    public function __construct($dia)
    {
        $this->dia = $dia;
    }

    public function addPlan (PlanVacacional $plan){
        $this->plan = $plan;
    }

    public function addEntrega (Entrega $entrega){
        $this->entrega = $entrega;
    }

    public function removePlan (){
        $this->plan = null;
    }

    public function removeEntrega (){
        $this->entrega = null;
    }

}
?>