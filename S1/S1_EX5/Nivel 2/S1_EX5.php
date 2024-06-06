<?php
include "PokerDice.php";
$numeroDeDados = 5;
$tiradas = 5;

for ($i = 0; $i < $numeroDeDados; $i++){
    $dados[] = new PokerDice();
}

foreach ($dados as $dado){
    $dado->tirar();
    echo $dado->nombrarFigura() . "<br>";
}

echo "Numero total de tiradas: " . PokerDice::$historial;
?>