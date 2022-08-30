<?php

header("Content-type: text/html; charset=utf-8");
error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);
$stmt = mysqli_stmt_init($link);
global $productId;


//var_dump($_POST);
extract($_POST);


$currentProduct = get_current_product($productId); //array
$currentProduct["id"] = strval($currentProduct["id"]);
