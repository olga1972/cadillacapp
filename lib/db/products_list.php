<?php

header("Content-type: text/html; charset=utf-8");
header("Content-type: text/json");

error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);

$products_list = get_all_products_json();

echo $products_list;



