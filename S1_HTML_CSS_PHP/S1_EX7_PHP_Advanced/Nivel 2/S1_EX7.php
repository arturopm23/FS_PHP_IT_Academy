<?php
include "Recurso.php";
include "Coche.php";

//Ejercicio 1
$myRecurso = new Recurso("POO", "www.soyunaweb.com", Tema::PHP, Tipo::Video);
var_dump($myRecurso);

//Ejercicio 2
$myCar = new Coche("Ford", "12345E", "hidrogeno", 200);
var_dump($myCar);
echo "<br>" . $myCar->acelera();
?>