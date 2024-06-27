<?php
$fecha1 = "10/11/2011";
$fecha2 = "11/10/2010";

$array1 = explode("/", $fecha1);
$array2 = explode("/", $fecha2);

/*var_dump($array1);
var_dump($array2);*/

function comprobarFechaMayor(array $array1, array $array2){
    $fechaMayor = [];

    if ($array1[2] < $array2[2]) {
        $fechaMayor = $array2;
    } elseif ($array1[2] > $array2[2]) {
        $fechaMayor = $array1;
    } elseif ($array1[1] < $array2[1]) {
        $fechaMayor = $array2;
    } elseif ($array1[1] > $array2[1]) {
        $fechaMayor = $array1;
    } elseif ($array1[0] < $array2[0]) {
        $fechaMayor = $array2;
    } elseif ($array1[0] > $array2[0]) {
        $fechaMayor = $array1;
    } else {
        $fechaMayor = [0, 0, 0];
    }
    
    return $fechaMayor;
}


function restaFechas(array $array1, array $array2){
$fechaMayor = comprobarFechaMayor($array1, $array2);
if ($fechaMayor == $array1){
    $fechaMenor = $array2;
}
else{
    $fechaMenor = $array1;
}

$mesesDiferencia = $fechaMayor[1] - $fechaMenor[1];
$anysDiferencia = $fechaMayor[2] - $fechaMenor[2];
$diasDiferencia = $fechaMayor[0] - $fechaMenor[0];

$diasDeAnys = $anysDiferencia * 365;
$diasDeMes = $mesesDiferencia * 30;

return $diasDeAnys + $diasDeMes + $diasDiferencia;
}

echo restaFechas($array1, $array2);

?>