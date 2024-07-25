<?php

require "NumberChecker.php";
use PHPUnit\Framework\TestCase;

final class NumberCheckerTest extends TestCase {
    public function testIsEven(){
        $myNumberChecker = new numberChecker(2);
        $this->assertSame(true, $myNumberChecker->isEven());
    }

    public function testIsNotEven(){
        $myNumberChecker = new numberChecker(3);
        $this->assertSame(false, $myNumberChecker->isEven());
    }

    public function testIsPositive(){
        $myNumberChecker = new numberChecker(3);
        $this->assertSame(true, $myNumberChecker->isPositive());
    }

    public function testIsNegative(){
        $myNumberChecker = new numberChecker(-3);
        $this->assertSame(false, $myNumberChecker->isPositive());
    }
}
?>