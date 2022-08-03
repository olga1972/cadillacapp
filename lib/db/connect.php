<?php

$dbname = "u1226706_default"; //database name
$dbuser = "u1226706_default"; //database username
$dbpassword = "h1Uj6_nL"; //database password
$dbhost = "localhost"; //database host

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $dbname) or die('Ошибка соединения с БД');
mysqli_set_charset($link, "utf8") or die('Не установлена кодировка');