<?php
class Employee {
    //Variables publicas
    public string $nombre;
    public int $sueldo;
    //Metodo constructor
    public function __construct(string $nombre, int $sueldo) {
        $this->nombre = $nombre;
        $this->sueldo = $sueldo;
    }

    //Metodo propio
    public function comprobarSueldo() : bool {
        ($this->sueldo > 6000) ? $respuesta = true : $respuesta = false;
        return $respuesta;
    }

    public function imprimir() : string {
       $respuesta = $this->comprobarSueldo(); 
       if ($respuesta){
        $solucion = "Tienes que pagar impuestos";
       } 
       else {
        $solucion = "No tienes que pagar impuestos";
        } 
        return $solucion;
    }
}
?>