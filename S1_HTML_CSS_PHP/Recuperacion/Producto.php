<?php

class Producto {
    public string $nombre;
    public string $animal;
    public float $precio;
    public string $cantidad;

    public function __construct(string $nombre, string $animal, float $precio, string $cantidad){
        $this->nombre = $nombre;
        $this->animal = $animal;
        $this->precio = $precio;
        $this->cantidad = $cantidad;
    }
}
?>