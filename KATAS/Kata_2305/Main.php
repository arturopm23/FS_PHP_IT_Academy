<?php
$numero = 4;
$filename = "calculs_" . $numero . ".txt";
$filepath = "C:\xampp\htdocs\FSPHP\KATAS\Kata_2305\\" . $filename;

$factorial =  1;
for ($i = 1; $i <= $numero; $i++) {
    $factorial *= $i;
}

$file = fopen($filename, "w");
 fwrite($file,"Número: " . $numero . "Quadrat: " . ($numero ** 2)
. " Cub:" . ($numero ** 3) . "Factorial :" . $factorial
);
fclose($file);
?>