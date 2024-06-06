<?php
class PokerDice {

//Variables globales
public $figuras = ["As", "K", "Q", "J", "7", "8"];
public static $historial = 0;
public $ultima_tirada;

public function tirar() : void {
    $tirada = rand(0,5);
    self::$historial++;
    $this->ultima_tirada = $tirada;
}
public function nombrarFigura() : string {
    return $this->figuras[$this->ultima_tirada];
}    
}
?>