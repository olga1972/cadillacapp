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


//$userId = $_COOKIE['TestCookie'];
//$_POST['userId'] = $userId;
//print($userId);



if(isset ($_COOKIE['uuid'])) {

$userId = $_COOKIE['uuid'];

} else {
    print('cookie no');
    $newUser = get_user_old(); //array
    $userId = $newUser["userId"];
    print($userId);

}

get_user($userId);





