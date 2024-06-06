<?php
include "Turbo.php";
class Coche {
    public string $marca;
    public string $matricula;
    public string $combustible;
    public int $velocidadMax;

    public function __construct(string $marca, string $matricula, string $combustible, int $velocidadMax) {
        $this->marca = $marca;
        $this->matricula = $matricula;
        $this->combustible = $combustible;
        $this->velocidadMax = $velocidadMax;
    }
    use Turbo;
}
?>