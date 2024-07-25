<?php
include "Shape.php";
include "Employee.php";
include "Triangle.php";
include "Rectangle.php";

//EJERCICIO 1
$myEmployee = new Employee('Meryem', 6000);
echo "Emplead@: " . $myEmployee->nombre . "<br>" . "Sueldo: " . $myEmployee->sueldo . "<br>" . $myEmployee->imprimir();

//EJERCICIO 2
$myRectangle = new Rectangle(5,6);
echo "<br>" ."<br>" . "Alto del rectangulo: " . $myRectangle->altura . "<br>" . "Ancho del rectangulo: " . $myRectangle->ancho
. "<br>" . "Area del rectangulo: ". $myRectangle->calcularArea();

$myTriangle = new Triangle(5,6);
echo "<br>" ."<br>" . "Alto del triangulo: " . $myTriangle->altura . "<br>" . "Ancho del triangulo: " . $myTriangle->ancho
. "<br>" . "Area del triangulo: ". $myTriangle->calcularArea();
?>

