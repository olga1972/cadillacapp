<?php

$db_name = "mysql";
$db_server = "127.0.0.1";
//$db_server = '192.168.31.213';
//$db_server = 'localhost';

$db_user = "root";
$db_pass = "root";

$link = @mysqli_connect($db_server, $db_user, $db_pass, $db_name) or die('ошибка соединения с базой данных');
mysqli_query($link, "set names utf8") or die("не установлена кодировка");
echo $mysqli->error;
//$data = array();



//<?php
//$db = "mysql"; //database name
//$dbuser = "root"; //database username
//$dbpassword = "admin"; //database password
//$dbhost = "localhost"; //database host
//
// $return["error"] = false;
// $return["message"] = "";
// $return["success"] = false;
// //
// //$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
// //
// if(isset($_POST["email"]) && isset($_POST["phone"])){
//    //checking if there is POST data
//
//    $email = $_POST["email"];
//    $phone = $_POST["phone"];
//
//    $username = mysqli_real_escape_string($link, $email);
//    //escape inverted comma query conflict from string
//
// //    $sql = "SELECT * FROM users_list WHERE username = '$username'";
//    $sql = "SELECT * FROM users_list WHERE username = '$username'";
//    //building SQL query
//    $res = mysqli_query($link, $sql);
//
//    var_dump($res);
//    $numrows = mysqli_num_rows($res);
//    //check if there is any row
//    if($numrows > 0){
//        //is there is any data with that username
//        $obj = mysqli_fetch_object($res);
//        //get row as object
//        if($email == $obj->email){
//            $return["success"] = true;
//            $return["uid"] = $obj->userId;
// //            $return["fullname"] = $obj->fullname;
// //            $return["address"] = $obj->address;
//        }else{
//            $return["error"] = true;
//            $return["message"] = "Your Email is Incorrect.";
//        }
//    }else{
//        $return["error"] = true;
//        $return["message"] = 'No phone found.';
//    }
// }else{
//    $return["error"] = true;
//    $return["message"] = 'Send all parameters.';
// }
//
// mysqli_close($link);
//
// header('Content-Type: application/json');
// // tell browser that its a json data
// echo json_encode($return);
// //converting array to JSON string
?>