<?php
//Ejercicio 1
$enteros = [9, 8, 7, 6, 5, 4, 3, 2, 1];
echo "Array de enteros: ";
foreach ($enteros as $numero){
    echo $numero . " . ";
}

function calcularCubo(int $numero) : int {
    return ($numero ** 3);
}

$enterosAlCubo = array_map('calcularCubo', $enteros);

echo "<br>" . "Array de enteros al cubo: ";
foreach ($enterosAlCubo as $resultado){
    echo $resultado . " . ";
}

//Ejercicio 2
function comprobarPar(int $numero) : bool {
    return ($numero % 2 == 0);
}

echo "<br>" . "Los numeros pares dentro del Array son: ";

$pares = array_filter($enteros, 'comprobarPar');
foreach ($pares as $resultado){
    echo $resultado . " . ";
}

//Ejercicio 3
function comprobarPrimo(int $numero): bool {
    if ($numero <= 1) {
        return false;
    }
    for ($i = 2; $i <= sqrt($numero); $i++) {
        if ($numero % $i == 0) {
            return false;
        }
    }
    return true;
}

echo "<br>". "La suma de primos del array es: ";
 $total = array_reduce(
    $enteros,
    function ($prev, $next) {
        if (comprobarPrimo($next)){
            echo $next . " + ";
            return $prev + $next;
        }
        else {
            return $prev;
        }
    },
    0   
);
//El 0 no es primo pero queria usar el array reduce para ir imprimiendo la suma
echo " 0 = " . $total;
?>