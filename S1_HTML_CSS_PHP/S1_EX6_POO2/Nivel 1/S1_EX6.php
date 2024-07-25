<?php
include "Animal.php";
include "Cat.php";
include "Dog.php";

$myCat = new Cat ('Garfield');
echo $myCat->name . ": " . $myCat->makeSound();
$myDog = new Dog ('Firulais');
echo "<br>" . $myDog->name . ": " . $myDog->makeSound();
?>