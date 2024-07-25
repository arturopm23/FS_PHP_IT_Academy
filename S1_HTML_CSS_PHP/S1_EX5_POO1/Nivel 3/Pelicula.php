<?php
class Pelicula {

    public string $nombrePeli;
    public int $duracion;
    public string $director;

    public function __construct(string $nombrePeli, int $duracion, string $director){
        $this->nombrePeli = $nombrePeli;
        $this->duracion = $duracion;
        $this->director = $director;
    }

    public function buscarPeliculaDirector(string $director) : string {
        for ($i = 0; $i < sizeof($this->cartelera); $i++){
            if ($this->cartelera[$i]->director == $director){
                
            }    
        }
    }  
}   

?>