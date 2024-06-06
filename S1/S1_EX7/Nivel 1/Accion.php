<?php
If (isset($_POST['user_name']) && isset($_POST['user_age']) && isset($_POST['user_password'])) {
    $user_name = $_POST['user_name'];
    $user_age = $_POST['user_age'];
    $_SESSION['user_name'] = $user_name;
    $_SESSION['user_age'] = $user_age;
}
    echo "Hola " .  $_SESSION['user_name'] . " tienes " . $_SESSION['user_age'];
?>
