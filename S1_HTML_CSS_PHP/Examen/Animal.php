<?php
abstract class Animal {

    public string $nombre;
    public int $edad;
    public float $peso;

    public function __construct(string $nombre, int $edad, float $peso){
        $this->nombre = $nombre;
        $this->edad = $edad;
        $this->peso = $peso;
    }

    abstract public function hacerRuido();

}
?>