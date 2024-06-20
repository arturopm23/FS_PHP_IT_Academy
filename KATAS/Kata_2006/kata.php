<?php
$expresion1 = "()()(3 + 4)) * 2";
$expresion2 = "(5 + 3) * (3 - 1)";
$expresion3 = "(5 + 3 * (3 - 1)";

 function comprobarParentesis(string $expresion) : bool {
    $respuesta = true;
    $abiertos = 0;
    $cerrados = 0;
    $partes = str_split($expresion);
    for($i=0; $i < sizeof($partes); $i++){
    if ($partes[$i] == "("){
        $abiertos++;
    }
    else if($partes[$i] == ")"){
        $cerrados++;
        }
    if ($cerrados > $abiertos){
        $respuesta = false;
    }     
    }
    if ($abiertos != $cerrados){
        $respuesta = false;
    }
return $respuesta;
}
echo (comprobarParentesis($expresion1) ? "correcto" : "incorrecto") . "<br>" ;
echo (comprobarParentesis($expresion2) ? "correcto" : "incorrecto") . "<br>" ;
echo (comprobarParentesis($expresion3) ? "correcto" : "incorrecto") . "<br>" ;
?>