<?php
$fecha1 = "11/11/2010";
$fecha2 = "11/10/2011";

function validarFecha(string $fecha) {
    $regex = '/^(\d{2})\/(\d{2})\/(\d{4})$/';

    if (preg_match($regex, $fecha, $matches)) {
        $day = (int)$matches[1];
        $month = (int)$matches[2];
        $year = (int)$matches[3];
        return checkdate($month, $day, $year);
    }

    return false;
}

function corregirFormato(string $fecha) {
    return str_replace('/', '-', $fecha);
}

function pasarASegundos(string $fecha) {
    $date = DateTime::createFromFormat('d-m-Y', $fecha);
    if ($date === false) {
        return false;
    }
    return $date->getTimestamp();
}

function calcularResultado(string $fecha1, string $fecha2) {
    $respuesta = "Ha habido un error";

    if (!validarFecha($fecha1) || !validarFecha($fecha2)) {
        return $respuesta;
    }

    $fecha1_corregida = corregirFormato($fecha1);
    $fecha2_corregida = corregirFormato($fecha2);

    $segundos1 = pasarASegundos($fecha1_corregida);
    $segundos2 = pasarASegundos($fecha2_corregida);

    if ($segundos1 === false || $segundos2 === false) {
        return $respuesta;
    }

    return abs(($segundos1 - $segundos2)/86400);
}

echo "Diferencia en días entre las fechas: " . calcularResultado($fecha1, $fecha2) . "\n";
?>
