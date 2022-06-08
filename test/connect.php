<?php

$dbname = "users"; //database name
$dbuser = "root"; //database username
//$dbpassword = "root"; //database password 5.6
$dbpassword = ""; //database password 5.7
$dbhost = "localhost"; //database host

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $dbname) or die('Ошибка соединения с БД');
mysqli_set_charset($link, "utf8") or die('Не установлена кодировка');