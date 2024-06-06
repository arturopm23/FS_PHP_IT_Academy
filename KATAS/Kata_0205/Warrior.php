<?php 
class Warrior extends Player {
    private string $sword;

    public function __construct(string $nickname, string $sword) {
        parent::__construct($nickname);
        $this->sword = $sword;
    }

    public function attack(): void {
        echo $this->nickname." attacked with ".$this->sword.PHP_EOL;
    }

    public function run(MoveDirection $direction): void {
        $this->move($direction,2);
    }
}

?>