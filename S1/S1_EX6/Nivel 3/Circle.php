<?php
class Circle implements Shape {

    public float $radio;

public function __construct(float $radio) {
    $this->radio = $radio;
}

public function calcularArea() : float {
    return ((pi()* ($this->radio ** 2)));
}

}
?>
