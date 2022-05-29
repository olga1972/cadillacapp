<?php
ini_set('display_errors', 1);

$db = "users"; //database name
$dbuser = "root"; //database username
$dbpassword = "root"; //database password
$dbhost = "localhost"; //database host

$sql3 = "SELECT * FROM users WHERE userId = 1";
//$res = '';
//$sql = '';
//$userId = '';

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

if(isset($_POST["phone"]) && isset($_POST["email"])) {
    $stmt = mysqli_stmt_init($link);

    $phone = mysqli_real_escape_string($link, $_POST["phone"]);
    $email = mysqli_real_escape_string($link, $_POST["email"]);

    // Выборка по полю работает
//    mysqli_stmt_prepare($stmt,"SELECT phone FROM users WHERE email = ?");
//    mysqli_stmt_bind_param($stmt,'s', $email);
//    mysqli_stmt_execute($stmt);
//    $mysqli_result = mysqli_stmt_get_result($stmt);
//
//    foreach($mysqli_result as $row) {
//        print($row);
//    }

    mysqli_stmt_prepare($stmt, "INSERT INTO users (userId, phone, email) VALUES(uuid(), ?, ?)");
    mysqli_stmt_bind_param($stmt, 'ss',  $phone, $email);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

mysqli_close($link);

//INSERT INTO users (userId, phone, email) VALUES(uuid(), '111', '111')
