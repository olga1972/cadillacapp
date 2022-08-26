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
// print('delete_news.php');
// print($_POST["newsId"]);

if(isset($_POST["photoId"])) {

    $stmt = mysqli_stmt_init($link);

    delete_photo();

    $photos_list = get_all_photos_json();
    echo $photos_list;

    return;
    
  

}