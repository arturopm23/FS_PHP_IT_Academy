<?php
$expresion1 = "(()()(3 + 4)) * 2";
$expresion2 = "(5 + 3) * (3 - 1)";
$expresion3 = "(5 + 3 * (3 - 1)";

function comprobarParentesis(string $expresion) : bool {
    $abiertos = 0;

    foreach (str_split($expresion) as $caracter) {
        if ($caracter === "(") {
            $abiertos++;
        } else if ($caracter === ")") {
            $abiertos--;
            if ($abiertos < 0) {
                return false; 
            }
        }
    }
    return $abiertos === 0;
}

echo (comprobarParentesis($expresion1) ? "correcto" : "incorrecto") . "<br>";
echo (comprobarParentesis($expresion2) ? "correcto" : "incorrecto") . "<br>";
echo (comprobarParentesis($expresion3) ? "correcto" : "incorrecto") . "<br>";
?>
