<?php
function comprobarPrimo(int $inicio, int $final): void {
    // Paso 1: Lista los números
    $numerosLista = [];
    for ($i = $inicio; $i <= $final; $i++) {
        array_push($numerosLista, $i);
    }

    // Paso 2: Inicializa el primer número
    $primerNumero = $inicio;

    // Paso 3: Elimina los múltiplos del primer número
    do {
        for ($j = 0; $j < count($numerosLista); $j++) {
            if (($numerosLista[$j] % $primerNumero == 0) && ($numerosLista[$j] != $primerNumero)) {
                array_splice($numerosLista, $j, 1);
            }
        }
        // Paso 4: Actualiza el primer número, si el valor es nulo conserva valor actual
        $primerNumero = $numerosLista[array_search($primerNumero, $numerosLista) + 1] ?? $primerNumero;

    } while (($primerNumero * $primerNumero) < $final); 

    var_dump($numerosLista);
}

comprobarPrimo(1, 100);
?>