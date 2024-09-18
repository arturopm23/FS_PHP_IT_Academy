<?php

class Submission extends Plan {
    public $sprint;
    public $githubLink;
    public $comments;

    public function __construct($name, $sprint, $date, $githubLink, $comments) {
        parent::__construct($name, $date);
        $this->sprint = $sprint;
        $this->githubLink = $githubLink;
        $this->comments = $comments;
    }

    public function perform() {
        echo "Submission " . $this->name . " completed.<br>";
    }

    public function cancel() {
        echo "Submission " . $this->name . " canceled.<br>";
    }

    public function resubmit() {
        echo "Resubmission of " . $this->name . " completed.<br>";
    }
}