<?php
include "Tigger.php";
include "Persona.php";
include "Cartera.php";
include "Llaves.php";
include "Tmobilitat.php";
include "Movil.php";

//Singleton
$tigger = Tigger::getInstance();
$tigger->roar(5);
$tigger->getNumberOfRoars();

//Dependency injection
$myCartera = new Cartera();
$myLlaves = new Llaves();
$myTmobilitat = new Tmobilitat();
$myMovil = new Movil();

$yo = new Persona($myCartera, $myLlaves, $myTmobilitat, $myMovil);
echo "<br>" . $yo->salir();
?>