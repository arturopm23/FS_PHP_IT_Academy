<?php
//EJERCICIO 1
function calcularCoste(int $minutos) : float {
    $coste;
    if ($minutos <= 3){
        $coste = 0.1;
    }
    else {
        $coste = 0.1 + (($minutos - 3) * 0.05);
    }
    return $coste;
}

$minutos = 10;
echo "Tu llamada de " . $minutos . " minutos tiene un coste de " . calcularCoste($minutos) . " euros";

//EJERCICIO 2 
function calcularPrecioChoco(int $chocolateCompra) : float {
    return $chocolateCompra;
}
function calcularPrecioChicle(int $chicleCompra) : float {
    return ($chicleCompra * 0.5);
}
function calcularPrecioCaramelo(int $carameloCompra) : float {
    return ($carameloCompra * 1.5);
}

function calcularPrecioTotal(int $chocolateCompra, int $chicleCompra, int $carameloCompra) : float {
    $precioChocolates = calcularPrecioChoco($chocolateCompra);
    $precioChicles = calcularPrecioChicle($chicleCompra);
    $precioCaramelos = calcularPrecioCaramelo($carameloCompra);
    return ($precioChocolates + $precioChicles + $precioCaramelos);
}

$chocolates = 1;
$chicles = 2;
$caramelos = 50;

echo "<br>" . "<br>" . "Tu compra de:" . "<br>" . $chocolates . " chocolates" . "<br>" . $chicles . " chicles"
. "<br>" . $caramelos . " caramelos" . "<br>" . "Tiene un coste de " .
calcularPrecioTotal($chocolates, $chicles, $caramelos) . " euros";
?>