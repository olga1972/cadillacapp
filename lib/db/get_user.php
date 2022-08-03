<?php

header("Content-type: text/html; charset=utf-8");
error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);
$stmt = mysqli_stmt_init($link);
global $userId;
//print('get_use post');
header("Refresh:0");
//sleep(5);

//var_dump($_POST);
extract($_POST);
//$userId = $_COOKIE['TestCookie'];
//$_POST['userId'] = $userId;
$is_auth = false;

// send all users from db
$users = get_all_users();  //возвращается массив
foreach ($users as $user) {
    //        print('user='); //[0] id, [1] userId, [2] phone, [3] email
            $current_user_id = array_values($user)[1];
    
    //        var_dump($user);
    //        var_dump(array_values($user)[3]);
            if ($current_user_id !== $userId) {
    //            print("такого ящика нет");
    
                continue;
            } else {
    //            print("ящик найден в базе");
                $is_auth = true;
                break;
            }
        }

        if( $is_auth == true) {
setcookie('uuid', $userId, time() + (3600 * 24 * 30), '/');


$newUser = get_user($userId); //array
$newUser["id"] = strval($newUser["id"]);

    //$userId = $newUser["userId"];
    //print($userId);



// get_user($userId);

        }



