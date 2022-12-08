<?php

header("Content-type: text/html; charset=utf-8");
error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);
$stmt = mysqli_stmt_init($link);
global $email;

header("Refresh:0");
print('POST');

extract($_POST);
print($email);
// send all users from db
$users = get_all_users();  //возвращается массив

foreach ($users as $user) {
//        print('user='); //[0] id, [1] userId, [2] phone, [3] email
        $current_user_email = array_values($user)[3];
    
//        var_dump($user);
//        var_dump(array_values($user)[3]);
        if ($current_user_email !== $email) {
            continue;
        } else {
            $findedUser = get_user_by_email();
            
            var_dump($findedUser);
            echo($findedUser);
        }
    }