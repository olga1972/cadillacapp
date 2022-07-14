<?php

// header("Content-type: text/html; charset=utf-8");
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

error_reporting(-1);
require_once 'connect.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);

if(isset($_POST["userId"])) {
    //clear();
    extract($_POST);
    global $link;
    global $stmt;
    $stmt = mysqli_stmt_init($link);
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE userId = ?");
    mysqli_stmt_bind_param($stmt,'s', $userId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
    

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result);

        if($rowsCount != null) {
            //print('id find');
            $res = [ 'isAuth' => 'true'];
           
        } else {
            //print('id not find');
            $res = [ 'isAuth' => 'false'];
        }

        print(json_encode($res));
    }

}