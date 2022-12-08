<?php
header("Content-type: text/html; charset=utf-8");
error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);

$stmt = mysqli_stmt_init($link);
//var_dump($_POST);

// send all users from db
$users = get_all_users(); //array
//print('post');

if(isset($_POST["email"])) {
    clear();
    extract($_POST);

    foreach ($users as $user) {
        $current_user_email = array_values($user)[3];
        
        if ($current_user_email != $email) {
            continue;
        } else {
// если email = email, находим пользователя по логину обновляем данные
            change_status();   //нет вывода данных
            $changedUser = get_user_by_email();
            var_dump('change');
            var_dump($changedUser);
          return;
        }
    }

}


