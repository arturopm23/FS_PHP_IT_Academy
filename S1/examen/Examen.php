<?php
include "Animal.php";
include "Vaca.php";
include "Cerdo.php";
include "Oveja.php";
include "Caballo.php";
include "Granja.php";

$myVaca = new Vaca("nombreVaca", 10, 100); 
echo $myVaca->hacerRuido();
$myCerdo = new Cerdo("nombre", 10, 200); 
echo $myCerdo->hacerRuido();
$myOveja = new Oveja("nombreOveja", 10, 200); 
echo $myOveja->hacerRuido();
$myCaballo = new Caballo("nombreCaballo", 10, 200); 
echo $myCaballo->hacerRuido();

$myGranja = new Granja("Granja");
$myGranja->addAnimal($myVaca);
$myGranja->addAnimal($myCerdo);
$myGranja->addAnimal($myOveja);
$myGranja->addAnimal($myCaballo);

echo $myGranja->calcularPesoMedio();





?>