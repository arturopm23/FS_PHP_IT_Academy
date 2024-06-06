<?php
include "Cine.php";
include "Pelicula.php";

$cars = new Pelicula("Cars", 97, "John Lasseter");
$inception = new Pelicula("Inception", 148, "Nolan");
$the_matrix = new Pelicula("The Matrix", 136, "Wachowski");
$forrest_gump = new Pelicula("Forrest Gump", 142, "Zemeckis");
$the_shawshank_redemption = new Pelicula("The Shawshank Redemption", 142, "Darabont");
$the_dark_knight = new Pelicula("The Dark Knight", 152, "Nolan");
$the_godfather = new Pelicula("The Godfather", 175, "Coppola");
$pulp_fiction = new Pelicula("Pulp Fiction", 154, "Tarantino");
$interstellar = new Pelicula("Interstellar", 169, "Nolan");
$fight_club = new Pelicula("Fight Club", 139, "Fincher");

$cinesa = new Cine("Cinesa", "Barcelona");
$yelmo_cines = new Cine("Yelmo Cines", "Madrid");
$cinemark = new Cine("Cinemark", "Mexico City");


$cinesa->agregarPelicula($cars);
$cinesa->agregarPelicula($inception);
$cinesa->agregarPelicula($the_matrix);


echo $cinesa->mostrarDatosPeliculas();
echo $cinesa->mostrarPeliculaMasLarga();

$cines = [$cinesa, $yelmo_cines];
buscarDirector("Nolan", $cines);


function buscarDirector(string $director, array $cines) : void {
    foreach ($cines as $cine){
        if (!empty($cine->cartelera)){
        foreach ($cine->cartelera as $pelicula) {
            if ($pelicula->director == $director){
                echo "<br>" . "Pelicula: " . $pelicula->nombrePeli . " en el cine " . $cine->nombreCine;
        } 
        }
    }
    }
}


?>