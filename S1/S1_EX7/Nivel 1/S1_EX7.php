<?php
//Inicia la sesion
session_start();
?>
<!DOCTYPE html>
<html>
    <body>
        <form action="Accion.php" method="POST">
            <ul>
                <li>
                    <label for="name">Nombre:</label>
                    <input type="text" id="name" name="user_name" />
                </li>
                <li>
                    <label for="age">Edad:</label>
                    <input type="number" id="age" name="user_age" />
                </li>
                <li>
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="user_password" />
                </li>
                <li class="button">
                    <button type="submit">Confirmar registro</button>
                </li>    
            </ul>
        </form>
    
        <?php
        include "ClasePrueba.php";
        //EJERCICIO 2  
        echo "<br>" . "Esta es la linea " . __LINE__ . " del codigo";
        echo "<br>" . "El directorio del archivo es: " . __DIR__ . "<br>" ;

        //EJERCICIO 3
        $ejemplo = new ClasePrueba;
        echo $ejemplo;
        ?>
        </body>
        </html>