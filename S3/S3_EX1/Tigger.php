<?php
class Tigger {
private static $instance;
private static $numberOfRoars = 0;

private function __construct() {
        echo "Building character..." . PHP_EOL;
}

//Los singletons no deben ser clonados
protected function __clone(){}

//Crea la instancia solo
public static function getInstance(): Tigger {
        if (!isset(self::$instance)){
                self::$instance = new static();
        }
        return self::$instance;
}

public function roar(int $roars) : void {
        for ($i = 0; $i < $roars; $i++){
        self::$numberOfRoars++;
        echo "Grrr!" . PHP_EOL;
        }
}

public function getNumberOfRoars() : void {
        echo self::$numberOfRoars;
}
}
?>