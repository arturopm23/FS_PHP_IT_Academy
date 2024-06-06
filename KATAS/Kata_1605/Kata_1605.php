<?php
$matriz= [3,7,6,9,5,1,4,3,8];

$fila1 = array_slice($matriz,0,3);
$resultado1 = array_reduce($fila1, 'sumar', 0);
$fila2 = array_slice($matriz,3,3);
$resultado2 = array_reduce($fila2, 'sumar',0);
$fila3 = array_slice($matriz,6,3);
$resultado3 = array_reduce($fila3, 'sumar',0);

$col1= [$matriz[0], $matriz[3], $matriz[6]];
$resultadoCol1 = array_reduce($col1, 'sumar',0);
$col2 = [$matriz[1], $matriz[4], $matriz[7]];
$resultadoCol2 = array_reduce($col2, 'sumar',0);
$col3 = [$matriz[2], $matriz[5], $matriz[8]];
$resultadoCol3 = array_reduce($col3,'sumar',0);

$dia1= [$matriz[0], $matriz[4], $matriz[8]];
$resultadoDia1 = array_reduce($col1, 'sumar',0);
$dia2 = [$matriz[2], $matriz[4], $matriz[6]];
$resultadoDia2 = array_reduce($col2, 'sumar',0);

function sumar ($prev, $next){
    return $prev + $next;
}

if ($resultado1 == $resultado2 && $resultado2 == $resultado3 && $resultado3 == $resultadoCol1 &&
 $resultadoCol1 == $resultadoCol2 && $resultadoCol2 == $resultadoCol3 && $resultadoCol3 == $resultadoDia1 
 && $resultadoDia1 == $resultadoDia2){
    echo "Es una matriz mágica";
}
else {
    echo "No es una matriz mágica";
}

?>
