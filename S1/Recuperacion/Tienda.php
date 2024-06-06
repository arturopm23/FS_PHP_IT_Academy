<?php
class Tienda {
    public string $nombre;
    public $productos;

    public function __construct(string $nombre){
        $this->nombre = $nombre;
    }

    public function addProducto(Producto $producto){
        $this->productos[] = clone $producto;
    }

    public function searchNombre(string $nombre) : string {
        $respuesta = "No he encontrado nada";
        foreach ($this->productos as $producto){
           if ($producto->nombre == $nombre){
            $respuesta = "He encontrado el producto " . $producto->nombre . " del animal " . $producto->animal;
           }
        }
        return $respuesta;
    }

    public function searchPrecio() : string {
        $precioMax = 0;
        $respuesta;
        foreach ($this->productos as $producto){
            if ($producto->precio > $precioMax){
                $precioMax = $producto->precio;
                $respuesta = $producto->nombre;
            }
        }
        return "El producto mas caro es " . $respuesta . "con un precio de " . $precioMax;
    }
}
?>