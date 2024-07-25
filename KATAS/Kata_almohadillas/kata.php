<?php
$string = "1 #####";

function separarString($string){
    return explode(' ', $string);
}

function calcularLargo (array $palabras) : int {
    $caracter = 0;
    foreach ($palabras as $palabra){
        if ($caracter < strlen($palabra)){
            $caracter = strlen($palabra);
        }
    }
    return ($caracter);
}

function imprimir(string $string) : void{
    $palabras = separarString($string);
    $hastag = (calcularLargo($palabras) +2);
    imprimirFila($hastag);
    foreach($palabras as $palabra){
        echo '<br># ' . $palabra;
        $espacios = ($hastag - (strlen($palabra) + 2));
        for ($i = 0; $i <= ($espacios); $i++){
            echo "&nbsp;";
            }
        echo '#';    
    }
    echo "<br>";
    imprimirFila($hastag);
}
function imprimirFila(int $hastag) : void {
    for ($i = 0; $i <= ($hastag); $i++){
        echo "#";
        }
}

imprimir($string);
?>
