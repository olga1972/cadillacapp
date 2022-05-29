require 'db/connect.php';

<?php
include "../flutter_api/db.php";
header('Content-Type: application/json');
include "../db/connect.php";

// global $db_name;
// global $db_server;
// global $db_user;
// global $db_pass;
//
global $link;
// global $result;

//
// $item = "";
// $data = "";
$sql_query = "SELECT * FROM `users_list`";
$r = mysqli_query($link, $sql_query);

$data = array();

echo (json_encode(array("users" => $data),JSON_UNESCAPED_UNICODE));

// $result = mysqli_query($link, "SELECT * FROM users_list");
// $data = mysqli_fetch_all($result);
//
// var_dump($data);