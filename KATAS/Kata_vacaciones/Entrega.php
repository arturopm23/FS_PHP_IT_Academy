<?php

class Entrega {

    public string $nombre;
    public int $sprint;
    public bool $tipo;
    public string $limite;
    public string $link;
    public string $comentarios;

    public function __construct(string $nombre, string $sprint, bool $tipo, string $limite, string $link, string $comentarios)
    {
        $this->nombre = $nombre;
        $this->sprint = $sprint;
        $this->tipo = $tipo;
        $this->limite = $limite;
        $this->link = $link;
        $this->comentarios = $comentarios;
    }
}
?>