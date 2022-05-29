require 'db/connect.php';

<?php
header('Content-Type: application/json');
include "db/connect.php";

global $db_name;
global $db_server;
global $db_user;
global $db_pass;

global $link;
global $result;

$item = "";
$data = "";

$sql_query = "SELECT * FROM `users_list`";

$result = mysqli_query($link, "SELECT * FROM users_list");
$data = mysqli_fetch_all($result);

var_dump($data);