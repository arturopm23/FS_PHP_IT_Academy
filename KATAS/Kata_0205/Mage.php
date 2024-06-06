<?php 
class Mage extends Player {
    
    public function __construct(string $nickname) {
        parent::__construct($nickname);
        $this->spells = [];
    }

    public function addSpell(string $spell): void {
        if(!in_array($spell,$this->spells)) {
            $this->spells[] = $spell;
        }
    }

    public function useSpell(string $spell): void {
        if(in_array($spell,$this->spells)) {
            echo $this->nickname." used ".$spell."!".PHP_EOL;
        }
        else {
            echo $this->nickname." doesn't know ".$spell."!".PHP_EOL;
        }
    }
}

?>