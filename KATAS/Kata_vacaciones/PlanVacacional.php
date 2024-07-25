<?php

class PlanVacacional {

    public string $nombre;
    public bool $tipo;

    public function __construct(string $nombre, bool $tipo)
    {
        $this->nombre = $nombre;
        $this->tipo = $tipo;
    }
}
?>