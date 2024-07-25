<?php
//EJERCICIO 1
//Declarar variables
$a = 4; //Integer
$b = 7.8; //Double
$c = "Hello"; //String
$d = true; //Boolean

//declarar constante
define("NOMBRE","<h1> arturo perez megias</h1>");

//Imprimir variables
echo  ucwords(NOMBRE) . "<br>";
echo "<br>";
echo "Integer: $a <br>";
echo "Double: $b <br>";
echo "String: $c <br>";
echo "Boolean: $d <br>" . "<br>";

//EJERCICIO 2
$str = "hello world";

echo strtoupper($str) . "<br>";
echo "Longitud del string: " . strlen($str) . "<br>";
echo "String inverso: " . strrev($str) . "<br>";

$aquest = "Aquest es el curs de PHP ";
echo $aquest . $str . "<br>" . "<br>";

//EJERCICIO 3
$x = 10;
$y = 2;
$n = 1.5;
$m = 2.5;

//x e y
echo "El valor de x es: " . $x . "<br> El valor de y es: " . $y . "<br>";
echo "El resultado de la suma es: " . ($x + $y) . "<br>";
echo "El resultado de la multiplicacion es: " . ($x * $y) . "<br>";
echo "El resultado de la division es: " . ($x / $y) . "<br>";
echo "El modulo es: " . ($x % $y) . "<br>" . "<br>";

//n y m
echo "El valor de n es: " . $n . "<br> El valor de m es: " . $m . "<br>";
echo "El resultado de la suma es: " . ($n + $m) . "<br>";
echo "El resultado de la multiplicacion es: " . ($n * $m) . "<br>";
echo "El resultado de la division es: " . ($n / $m) . "<br>";
echo "El modulo es: " . ($n % $m) . "<br>" . "<br>";

//doble de cada variable
echo "El doble de " . $x . " es " . (2 * $x) . "<br>";
echo "El doble de " . $y . " es " . (2 * $y) . "<br>";
echo "El doble de " . $n . " es " . (2 * $n) . "<br>";
echo "El doble de " . $m . " es " . (2 * $m) . "<br>" . "<br>";

//suma y producto de todas las variables
echo "La suma de todas las variables tiene como resultado: " . ($x + $y + $n + $m) . "<br>";
echo "El producto de todas las variables tiene como resultado: " . ($x * $y * $n * $m). "<br>" . "<br>";

$num1 = 100;
$num2 = 20;
$oper = "+";

function calcular(int $num1, int $num2, string $oper) : string {
    $resultado = "";
    switch ($oper) {
        case "+":
            $resultado = "El resultado de la suma es: " . ($num1 + $num2);
            break;
        case "-":
            $resultado = "El resultado de la resta es: " . ($num1 - $num2);
            break;
        case "*":
            $resultado = "El resultado de la multipilicacion es: " . ($num1 * $num2);
             break;
        case "/":
            $resultado = "El resultado de la division es: " . ($num1 / $num2);
            break;                         
    }
    return $resultado . "<br>" . "<br>";
}

echo calcular($num1, $num2, $oper);

//EJERCICIO 4
$objetivo = 10;
$saltos = 2;

//valor por defecto de uno en uno
function contar(int $objetivo, int $saltos = 1) : void {
$numContador = 0;
while ($numContador <= $objetivo) {
    echo $numContador . "<br>";
    $numContador += $saltos;
}
}

echo "Contador: " . "<br>";
contar($objetivo, $saltos);

//EJERCICIO 5
$nota = 60;

function calificar(int $nota) : string {
    $resultado = "";    
    if($nota < 33){
        $resultado = "El estudiante esta suspendido";
    }
    else if($nota <= 44){
        $resultado = "Tercera division";
    }
    else if($nota <= 59){
        $resultado = "Segunda division";
    }
    else if($nota > 59){
        $resultado = "Primera division";
    }
    else{
        $resultado = "Nota invalida";
    }
    return "<br>" . $resultado . "<br>" . "<br>";
}

echo calificar($nota);

//EJERCICIO 6
function isBitten() : void {
    $mordida = rand(0,1);
    echo ($mordida == 0) ? "FALSE, Charlie no te ha mordido" : "TRUE, Charlie te ha mordido";
}
isBitten();
?>

