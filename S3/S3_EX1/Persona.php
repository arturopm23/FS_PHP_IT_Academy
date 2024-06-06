<?php

class Persona {
    public $cartera;
    public $llaves;
    public $tmobilitat;
    public $movil;

    public function __construct(Cartera $cartera, Llaves $llaves, Tmobilitat $tmobilitat, Movil $movil){
        $this->cartera = $cartera;
        $this->llaves = $llaves;
        $this->tmobilitat = $tmobilitat;
        $this->movil = $movil;
    }

    public function salir() : string {
        $respuesta = "";
        if ($this->cartera && $this->llaves && $this->tmobilitat && $this->movil){
            $respuesta = "Puedo salir";
        }
        else {
            $respuesta = "Creo que me falta algo";
        }
        return $respuesta;
    }
}
?>