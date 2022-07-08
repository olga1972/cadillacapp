<?php
$db = "users"; //database name
$dbuser = "root"; //database username
$dbpassword = "root"; //database password
$dbhost = "localhost"; //database host

//  $return["error"] = false;
//  $return["message"] = "";
//  $return["success"] = false;

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
mysqli_set_charset($link,"utf8");

if(isset($_POST["phone"]) && isset($_POST["email"])){
    $phone = mysqli_real_escape_string($link, $_POST["phone"]);
    $email = mysqli_real_escape_string($link, $_POST["email"]);

    //$sql3 = "SELECT * FROM users WHERE userId = 1";
    $sql = "SELECT * FROM users";

//      $res = mysqli_query($link, "SELECT * from users WHERE userId = 1");
//      $row_cnt = mysqli_num_rows($res);
//      print($row_cnt);

    $userInfoArray =[];

    if($res = mysqli_query($link, $sql)){
        $rowsCount = mysqli_num_rows($res); // количество полученных строк
//          echo "<p>Получено объектов: $rowsCount</p>";

        foreach($res as $row){
            $userInfoArray[] = $row;
//              echo "<td>" . $userid = $row["userId"];
        }
        echo json_encode($userInfoArray, JSON_UNESCAPED_SLASHES);

        mysqli_free_result($res);
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }

    return json_encode($userInfoArray, JSON_UNESCAPED_SLASHES);

//     $return["message"] = 'Send all parameters.';
}

mysqli_close($link);