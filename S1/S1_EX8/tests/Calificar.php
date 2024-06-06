<?php
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
    return  $resultado;
}
echo calificar($nota);
?>