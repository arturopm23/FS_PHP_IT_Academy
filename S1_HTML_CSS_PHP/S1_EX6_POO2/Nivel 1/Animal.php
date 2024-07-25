<?php
abstract class Animal {
//Public variables    
 public string $name;

//Constructor
public function __construct(string $name){
    $this->name = $name;
}
}

?>