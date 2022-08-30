<?php

header("Content-type: text/html; charset=utf-8");
header("Access-Control-Allow-Origin: *");

error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';
require_once "Mobile_Detect.php";
$detect = new Mobile_Detect;

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $dbname);
mysqli_set_charset($link,"utf8");



if(isset($_POST["productName"])) {

    $stmt = mysqli_stmt_init($link);

     add_product();

     $addedProduct = get_product();

     $addedProduct[0]["id"] = strval($addedProduct[0]["id"]);

    print(json_encode($addedProduct[0], JSON_UNESCAPED_SLASHES));

    return $addedProduct[0];

    }

mysqli_close($link);

