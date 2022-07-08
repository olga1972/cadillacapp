<?php
header("Content-type: text/html; charset=utf-8");
error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);

$is_auth = true;

$stmt = mysqli_stmt_init($link);
//var_dump($_POST);

// send all users from db
$users = get_all_users(); //array
//print('post');
//var_dump($_POST);
if(isset($_POST["login"])) {


    clear();
    extract($_POST);
    

    foreach ($users as $user) {
        $current_user_email = array_values($user)[3];
        if ($current_user_email != $login) {
            continue;
        } else {
// если email = login, находим пользователя по логину обновляем данные
            $currentUser = get_user_by_login();   //нет вывода данных
//            print('$currentUser');
//            print($currentUser);
//var_dump($currentUser);
// print($currentUser["userId"]);
// $userId = $currentUser["userId"];

// получаем все информацию о пользователе (объект json)
            $editUser = get_user_all();
            
            //var_dump($editUser);
            //$editUser = getUser($userId);
            //setcookie('uuid', $editUser["userId"], time() + (3600 * 24 * 30), '/');

          echo(json_encode($editUser, JSON_UNESCAPED_SLASHES));


          //header("Refresh:0");

          return $editUser;
        }


    }



}

//mysqli_close($link);

//INSERT INTO users (userId, phone, email) VALUES(uuid(), '111', '111')
