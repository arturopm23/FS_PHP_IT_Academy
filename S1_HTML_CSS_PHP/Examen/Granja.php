<?php
class Granja {

    public string $nombre;
    public $animales;

    public function __construct(string $nombre){
        $this->nombre = $nombre;
    }

    public function addAnimal(Animal $animal){
        $this->animales[] = clone $animal;
    }

    public function calcularPesoMedio() : float {
        $suma = 0;
        foreach($this->animales as $animal){
            $suma += $animal->peso;
        }
        return ($suma / sizeof($this->animales));
    }
}
?>