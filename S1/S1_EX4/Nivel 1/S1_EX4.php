<?php
//EJERCICIO 1
//Crear Array
$numeros = ['10', '20', '30', '40', '50'];

//Mostrar por pantalla
echo "Primer Array: " . "<br>";
foreach ($numeros as $numero) {
echo $numero . "<br>";
}

//EJERCICIO 2
$x = array(10, 20, 30, 40, 50, 60);

//Mostrar por pantalla nuevo array
echo "<br>" . "Nuevo array:" . "<br>";
for ($i = 0; $i < sizeof($x); $i++) {
    echo $x[$i] . "<br>";
    }

echo "<br>" . "Longitud del array: " . sizeof($x) . "<br>";

//Elimina un elemento del array
unset($x[2]);

//Declaro una nueva array
$xSinTreinta = [];

//Asigno cada elemento de x a la nueva array
foreach ($x as $posicion => $numero) {
    $xSinTreinta[] = $numero;
}

echo "<br>" . "Array sin el numero eliminado:" . "<br>";
foreach($xSinTreinta as $numero) {
    echo $numero . "<br>";
} 

echo "<br>" . "Longitud del array: " . sizeof($xSinTreinta) . "<br>";

//EJERCICIO 3
$palabras = array('hola', 'php', 'html');
$caracter = 'h';

echo "<br>" . "Lista de palabras:" . "<br>";
foreach ($palabras as $palabra){
echo $palabra . "<br>";
}
echo "<br>" . "Caracter : " . $caracter . "<br>";
/* Esta funcion va revisando las letras de cada palabra para comprobar que el caracter este en ellas,
En el caso de encontrar el caracter en una palabra marca el boolean encontradoEnEstaPalabra como true y
añade el string a una nueva lista llamada palabrasQueTienenLaLetra. Así, si una palabra contiene 2 o +
veces el mismo caracter no la volvera añadir a la lista. Por último si la array palabras y la array 
palabrasQueTienenLaLetra son iguales devuelve true, sino false. */ 
function comprobarCaracter(array $palabras, string $caracter) : bool {
    $palabrasQueTienenLaLetra = [];
    foreach ($palabras as $palabra) {
        $encontradoEnEstaPalabra = false;
        for ($i = 0; $i < strlen($palabra); $i++) {
            if ($caracter == strtolower($palabra[$i]) &&  !$encontradoEnEstaPalabra) {
            $palabrasQueTienenLaLetra[] = $palabra;
            $encontradoEnEstaPalabra = true;
            }
    }
    }
    return $palabrasQueTienenLaLetra == $palabras;
}
 
echo (comprobarCaracter($palabras, $caracter) == true) ? 'Todas las palabras comparten el caracter' : 
'No todas las palabras comparten el caracter' ;

//EJERCICIO 4
$yo = [
    'nombre' => 'Arturo',
    'edad' => 21,
    'email' => 'arturopermeg23@gmail.com',
    'comida favorita' => 'Sushi'
];

echo "<br>" . "<br>" . $yo['nombre'] . "<br>" . $yo['edad'] . "<br>" . $yo['email'] . "<br>" . $yo['comida favorita']
?>


