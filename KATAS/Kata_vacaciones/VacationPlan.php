<?php

class VacationPlan extends Plan {
    public $location;
    public $type;

    public function __construct($name, $location, $date, $type) {
        parent::__construct($name, $date);
        $this->location = $location;
        $this->type = $type;
    }

    public function perform() {
        echo "Activity performed: " . $this->name . "<br>";
    }

    public function cancel() {
        echo "Activity " . $this->name . " canceled.<br>";
    }
}