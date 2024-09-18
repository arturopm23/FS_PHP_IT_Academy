<?php

abstract class Plan {
    public $name;
    public $date;

    public function __construct($name, $date) {
        $this->name = $name;
        $this->date = $date;
    }

    abstract public function perform();
    abstract public function cancel();
}
