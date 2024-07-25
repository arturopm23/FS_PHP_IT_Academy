<?php
include "Calendario.php";

$myPlan = new PlanVacacional('playa', 0);
$myEntrega = new Entrega('html', 5, 0, '20-01-2003', 'link' , 'comentarios');
$myDia = new Dia('20-08-3004');

$myDia->addEntrega($myEntrega);
$myDia->addPlan($myPlan);

var_dump($myDia);

$myDia->removePlan($myPlan);

var_dump($myDia);


?>