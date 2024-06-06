<?php
//Clase Shape
abstract class Shape {
    
    //Variables publicas
    public float $ancho;
    public float $altura;
    
    //Metodo constructor
    public function __construct(float $ancho, float $altura) {
        $this->ancho = $ancho;
        $this->altura = $altura;
    }

    abstract protected function calcularArea();
}