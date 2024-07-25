<?php

require "Calificar.php";

use PHPUnit\Framework\TestCase;

final class CalificarTest extends TestCase {

    public function testCalificarSuspendido() {
        $myNota = calificar(20);
        $this->assertSame("El estudiante esta suspendido", $myNota);
    }

    public function testCalificarPrimeraDiv() {
        $myNota = calificar(60);
        $this->assertSame("Primera division", $myNota);
    }

    public function testCalificarSegundaDiv() {
        $myNota = calificar(55);
        $this->assertSame("Segunda division", $myNota);
    }

    public function testCalificarTerceraDiv() {
        $myNota = calificar(40);
        $this->assertSame("Tercera division", $myNota);
    }
}


?>