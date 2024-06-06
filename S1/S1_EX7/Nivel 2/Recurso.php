<?php
include "Tema.php";
include "Tipo.php";

class Recurso {
    public string $nombre;
    public string $url;

    public function __construct(string $nombre, string $url, public Tema $tema, public Tipo $tipo){
        $this->nombre = $nombre;
        $this->url = $url;
    }
}
?>