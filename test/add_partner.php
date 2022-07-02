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



if(isset($_POST["partnerName"])) {

    $stmt = mysqli_stmt_init($link);

     add_partner();

     $addedPartner = get_partner();
     var_dump($addedPartner);

     $addedPartner["id"] = strval($addedPartner["id"]);
//        var_dump($existUser);
    print(json_encode($addedPartner[0]));

    return $addedPartner[0];
    
  

    }





mysqli_close($link);

//INSERT INTO users (userId, phone, email) VALUES(uuid(), '111', '111')
