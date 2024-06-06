<?php

require "Archer.php";
use PHPUnit\Framework\TestCase;

final class ArcherTest extends TestCase {
    public function testConstructor() {
        $archer = new Archer("Aru", "Arco de hierro", 9);
        
        $this->assertSame("Aru", $archer->getNickname());
        $this->assertSame("Arco de hierro", $archer->getBow());
        $this->assertSame(9, $archer->getArrows_qty());
  }
} 
?>