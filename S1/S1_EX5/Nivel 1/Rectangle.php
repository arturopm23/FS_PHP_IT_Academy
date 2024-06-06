<?php
//Clase Rectangulo hereda de Shape
class Rectangle extends Shape{
    //Metodo propio
    public function calcularArea() : float{
        return (($this->ancho) * ($this->altura));
    }
}

?>