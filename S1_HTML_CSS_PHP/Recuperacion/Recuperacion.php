<?php

include "Producto.php";
include "Tienda.php";

$myTienda = new Tienda("T");
$leche = new Producto("P", "", 15, "1 L");
$a = new Producto("Ps", "", 15, "1 L");
$b = new Producto("Pg", "", 15, "1 L");
$c = new Producto("Pf", "", 30, "1 L");

$myTienda->addProducto($leche);
$myTienda->addProducto($a);
$myTienda->addProducto($b);
$myTienda->addProducto($c);

echo $myTienda->searchNombre("P");
echo $myTienda->searchPrecio();
?>