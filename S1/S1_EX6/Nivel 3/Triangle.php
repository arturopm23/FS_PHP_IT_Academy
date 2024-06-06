<?php
//Clase Triangle hereda de shape
class Triangle implements Shape {

    public float $ancho;
    public float $altura;
    
    public function __construct(float $ancho, float $altura) {
        $this->ancho = $ancho;
        $this->altura = $altura;
    }

    //Metodo propio
    public function calcularArea() : float{
        return ((($this->ancho) * ($this->altura)) / 2);
    }
}
?>