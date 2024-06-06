<?php
//Clase Triangle hereda de shape
class Triangle extends Shape {
    //Metodo propio
    public function calcularArea() : float{
        return ((($this->ancho) * ($this->altura)) / 2);
    }
}
?>