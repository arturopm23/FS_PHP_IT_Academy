<?php
//Ejercico 1
$primerArray = [3, 8, 6, 5, 4];
$segundoArray = [1, 2, 3, 4, 5];

echo "Primer Array: ";
foreach ($primerArray as $numero){
    echo $numero . " . ";
}
echo "<br>" . "Segundo Array: ";
foreach ($primerArray as $numero){
    echo $numero . " . ";
}
//Interseccion
$interseccion = array_intersect($primerArray, $segundoArray);
echo "<br>" . "Interseccion de los dos arrays: " ;
foreach ($interseccion as $numero) {
    echo $numero . " . ";
}

//Mezcla de los array
$mezcla = array_merge($primerArray, $segundoArray);
echo "<br>" . "Mezcla de los dos arrays: ";
foreach ($mezcla as $numero){
    echo $numero . " . ";
}

//Ejercicio 2
$alumnos = [
    "Arturo" => [5, 7, 9, 3, 0],
    "Arnau" => [3, 5, 7, 9, 10],
    "Diego" => [2, 4, 6, 8, 10],
    "Jose" => [10, 9, 9, 9, 10],
    "Joel" => [7, 6, 0, 8, 10],
];

foreach($alumnos as $nombre => $notas) {
    echo "<br>" . "<br>" . "Notas de " . $nombre . ": ";
    foreach($notas as $nota) {
    echo $nota . " . ";
}
}

function calcularMediaAlumno (array $notas) : float {
    $suma = 0;
    foreach ($notas as $nota){
        $suma += $nota;
    }
    return ($suma / sizeof($notas));
}

foreach($alumnos as $nombre => $notas ) {
    echo "<br>" . "<br>" . "Media de " . $nombre .": " . calcularMediaAlumno($notas);
}

function calcularMediaTotal(array $alumnos) : float {
    $suma = 0;
    foreach ($alumnos as $alumno){
        $suma += calcularMediaAlumno($alumno);
    }
    return ($suma / sizeof($alumnos));
}

echo "<br>" . "<br>" . "Media total: " . calcularMediaTotal($alumnos);
?>