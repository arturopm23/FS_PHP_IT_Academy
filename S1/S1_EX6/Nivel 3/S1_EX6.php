<?php
include "Shape.php";
include "Triangle.php";
include "Rectangle.php";
include "Circle.php";

$myRectangle = new Rectangle(5,6);
echo "Alto del rectangulo: " . $myRectangle->altura . "<br>" . "Ancho del rectangulo: " . $myRectangle->ancho
. "<br>" . "Area del rectangulo: ". $myRectangle->calcularArea();

$myTriangle = new Triangle(5,6);
echo "<br>" ."<br>" . "Alto del triangulo: " . $myTriangle->altura . "<br>" . "Ancho del triangulo: " . $myTriangle->ancho
. "<br>" . "Area del triangulo: ". $myTriangle->calcularArea();

$myCircle = new Circle(5);
echo "<br>" ."<br>" . "Radio del circulo: " . $myCircle->radio . "<br>" . "<br>" . "Area del circulo: ". $myCircle->calcularArea();
?>