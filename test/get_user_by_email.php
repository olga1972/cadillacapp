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

extract($_POST);

// $is_auth = false;
// send all users from db
$users = get_all_users();  //возвращается массив
foreach ($users as $user) {
    //        print('user='); //[0] id, [1] userId, [2] phone, [3] email
            $current_user_email = array_values($user)[3];
    
    //        var_dump($user);
    //        var_dump(array_values($user)[3]);
            if ($current_user_email !== $login) {
    //            print("такого ящика нет");
    
                continue;
            } else {
    //            print("ящик найден в базе");
                //$findedUser = get_user_by_login();
                $findedUser = get_user_all();
                
                //var_dump($findedUser);
                //print(gettype($findedUser["password"])); string
                echo(json_encode($findedUser, JSON_UNESCAPED_SLASHES));
                break;
            }
        }

   
//return json_encode($findedUser, JSON_UNESCAPED_SLASHES);


