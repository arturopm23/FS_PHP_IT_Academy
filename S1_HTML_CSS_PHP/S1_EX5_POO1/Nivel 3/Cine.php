<?php
class Cine {

    public string $nombreCine;
    public string $poblacion;
    public $cartelera;

    public function __construct(string $nombreCine, string $poblacion){
        $this->nombreCine = $nombreCine;
        $this->poblacion = $poblacion;
    }

    public function agregarPelicula(Pelicula $pelicula){
        $this->cartelera[] = clone $pelicula;
    }

    public function mostrarDatosPeliculas() : void {
        foreach ($this->cartelera as $pelicula){
             echo "Pelicula: " . $pelicula->nombrePeli . " Duracion: " . $pelicula->duracion . " min. Director: " . $pelicula->director . "<br>";
        }
    }

    public function mostrarPeliculaMasLarga() : string {
        $indicePeli = 0;
        $peliculaMasLarga = 0;
        for ($i = 0; $i < sizeof($this->cartelera); $i++){
            if ($this->cartelera[$i]->duracion > $peliculaMasLarga){
                $peliculaMasLarga = $this->cartelera[$i]->duracion;
                $indicePeli = $i;
            }
    }
    return "La pelicula mas larga es " . $this->cartelera[$indicePeli]->nombrePeli . " con una duracion de " . $this->cartelera[$indicePeli]->duracion . " minutos.";
    }  
}
?>