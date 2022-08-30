<?php
//функция очистки входных данных
function clear(){
    global $link;
	foreach ($_POST as $key => $value) {
		$_POST[$key] = mysqli_real_escape_string($link, $value);
	}
}

//функция втавки userId, phone, email
function add_user() {
    global $stmt;
    clear();
    extract($_POST);
//var_dump($_POST);

    // mysqli_stmt_prepare($stmt, "INSERT INTO users (userId, phone, email) VALUES(uuid(), ?, ?)");
    mysqli_stmt_prepare($stmt, "INSERT INTO users (userId, phone, email, password, dateRegister, dateExpired, fieldOfActivity, numberCar, yearIssue) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
    mysqli_stmt_bind_param($stmt, 'sssssssss',  $userId, $phone, $email, $password, $dateRegister, $dateExpired, $fieldOfActivity, $numberCar, $yearIssue);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));
}

//функция  обновления username и birthday по login ?????
function edit_user() {
    //эта функция ничего не возвращает, обновляет данные в таблицу
    global $stmt;
    clear();
    extract($_POST);

    //mysqli_stmt_prepare($stmt, "INSERT INTO users (username, birthday) VALUES(?, ?)");

    mysqli_stmt_prepare($stmt, "UPDATE users SET username = ?, birthday = ?, path = ?, car1 = ?, car2 = ?, car3 = ?, fieldOfActivity = ?, numberCar = ?, yearIssue = ? WHERE login = ?");
    mysqli_stmt_bind_param($stmt, 'ssssssssss',  $username, $birthday, $path, $car1, $car2, $car3, $login, $fieldOfActivity, $numberCar, $yearIssue);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));
}

//функция обновления username и birthday по login
function get_user_by_login() {
    //эта функция ничего не возвращает

    extract($_POST);

    global $link;
    global $stmt;
    // $path = file_get_contents($path);
    // print($path);

    $stmt = mysqli_stmt_init($link);
    mysqli_stmt_prepare($stmt, "UPDATE users SET username = ?, birthday = ?, carname = ?, path = ?, car1 = ?, car2 = ?, car3 = ?, fieldOfActivity = ?, numberCar = ?, yearIssue = ? WHERE login = ?");
 //    mysqli_stmt_prepare($stmt,"UPDATE users SET username = ?, birthday = ?, login = ?, carname = ?, path = ?, car1 = ?, car2 = ?, car3 = ?,   WHERE email = ?");
    mysqli_stmt_bind_param($stmt,'sssssssssss', $username, $birthday, $carname, $path, $car1, $car2, $car3, $fieldOfActivity, $numberCar, $yearIssue, $login);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);

//    print(mysqli_stmt_errno($stmt));
        // $filename = "../assets/assets/avatar1.png";
        // print('gettype($path)');
        // print(gettype($path));
        // $file = file_get_contents($path);
        // file_put_contents($file, $filename);
    //if($userId) {
        //setcookie('uuid', $userId, time() + (3600 * 24 * 30), '/');
    //}
    
//    echo $_COOKIE["userId"];
}

function get_user_by_email() {

    extract($_POST);
//    var_dump($_POST);

    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt, "SELECT * FROM users WHERE email = ?");
    mysqli_stmt_bind_param($stmt, 's', $email);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    print(mysqli_stmt_errno($stmt));

    $newUser = mysqli_fetch_all($mysqli_result);

//    var_dump($newUser);

    $userInfoArray = [];

    if ($mysqli_result) {
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк


        foreach ($mysqli_result as $row) {
            $userInfoArray[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];

        }
        //echo(json_encode($userInfoArray[0]));
//        unset($userInfoArray[0]['id']);

        return $userInfoArray[0];
//

        } else {
            echo "Ошибка: " . mysqli_error($link);
        }
//    print(mysqli_stmt_errno($stmt));
}

//Выбор всех полей по  email
function get_user_all() {

    extract($_POST); // only login
//var_dump($_POST);

    global $link;
    global $stmt;
    //mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE email = ?");
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE login = ?");
    mysqli_stmt_bind_param($stmt,'s', $login);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//print(mysqli_stmt_errno($stmt));
//    $newUser = mysqli_fetch_all($mysqli_result);

//    var_dump($newUser);

    $userInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $userInfoArray[] = $row;
//          echo $_COOKIE["TestCookie"];
        }


//        unset($userInfoArray[0]['id']);
//        echo(json_encode($userInfoArray[0]));
        $userInfoArray[0]["id"] = strval($userInfoArray[0]["id"]);
        
        //var_dump($userInfoArray[0]);
        return $userInfoArray[0];
//        print('новый пользователь');
//        print($new_user);
//
//        mysqli_free_result($mysqli_result); // освободить память
//
//        if($new_user) {
//            return $new_user;
//        }
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function get_user($userId) {
   
    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE userId = ?");
    mysqli_stmt_bind_param($stmt,'s', $userId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    $newUser = mysqli_fetch_all($mysqli_result);

//    var_dump($newUser);
    //print(mysqli_stmt_errno($stmt)); show code error

    $userInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $userInfoArray[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];

//            setcookie('TestCookie', $row["userId"], time() + 3600, '/');
//            print($userInfoArray["userId"]);
//            echo $_COOKIE["TestCookie"];
        }

        // var_dump($userInfoArray);
        

        $userInfoArray[0]["id"] = strval($userInfoArray[0]["id"]);
        
        
        print(json_encode($userInfoArray[0], JSON_UNESCAPED_SLASHES));
        return $userInfoArray[0];
//        print('новый пользователь');
//        print($new_user);
//
//        mysqli_free_result($mysqli_result); // освободить память
//
//        if($new_user) {
//            return $new_user;
//        }
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function get_user_old() {
    extract($_POST);
    
    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE email = ?");
    mysqli_stmt_bind_param($stmt,'s', $email);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    $newUser = mysqli_fetch_all($mysqli_result);
//    print('user fetch all');
//    var_dump($newUser);

    $userInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $userInfoArray[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];
        }

        $userId = $userInfoArray[0];
//        print($userId);
//setcookie('TestCookie', $userId, time() + 3600, '/');


                return $userInfoArray[0];
//        print('новый пользователь');
//        print($new_user);
//
//        mysqli_free_result($mysqli_result); // освободить память
//
//        if($new_user) {
//            return $new_user;
//        }
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }


}



function save_mess(){
	global $link;
	clear();
	extract($_POST);
	// $name = mysqli_real_escape_string($db, $_POST['name']);
	// $text = mysqli_real_escape_string($db, $_POST['text']);
	$query = "INSERT INTO users (name, text) VALUES ('$name', '$text')";
	mysqli_query($link, $query);
}

// Функция получения всех пользователей из таблицы, возвращает массив
function get_all_users(){

	global $link;
	$query = "SELECT * FROM users";
	$result = mysqli_query($link, $query);
    //$users = mysqli_fetch_all($result);
    $users = array();
//    while($r = mysqli_fetch_array($result)) {
//        $users[] = $r;
//    }
    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $users[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];
        }



//          print($users);
        // $file = "../assets/assets/users.json";
        // $users_obj = '{"users": ' . json_encode($users) . '}';
        // $data_file = file_put_contents($file, $users_obj);


//        var_dump($users);
        return ($users);
        //return ($users_obj);


    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
    //echo json_encode($users);
//    print('users\n');
//    var_dump(json_encode($users));
//    $users = json_encode($users);
//    echo($users);
//    return $users;
	//return json_encode($users);

}

function get_all_users_json(){

	global $link;
	$query = "SELECT * FROM users  WHERE username != 'username'";
	$result = mysqli_query($link, $query);
    //$users = mysqli_fetch_all($result);
    $users = array();
//    while($r = mysqli_fetch_array($result)) {
//        $users[] = $r;
//    }
    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $users[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];
        }



//          print($users);
        // $file = "../assets/assets/users.json";
        $users_obj = '{"users": ' . json_encode($users, JSON_UNESCAPED_SLASHES) . '}';
        // $data_file = file_put_contents($file, $users_obj);


//        var_dump($users);
        //return ($users);
        return ($users_obj);


    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
    //echo json_encode($users);
//    print('users\n');
//    var_dump(json_encode($users));
//    $users = json_encode($users);
//    echo($users);
//    return $users;
	//return json_encode($users);

}

function get_all_news_json(){

	global $link;
	$query = "SELECT * FROM news";
	$result = mysqli_query($link, $query);
    
    $news = array();

    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $news[] = $row;
          
        }

        $news_obj = '{"news": ' . json_encode($news, JSON_UNESCAPED_SLASHES) . '}';
 
        return ($news_obj);

    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function users_to_obj () {
    $users_obj = get_all_users();
    $users_obj = json_encode( $users_obj, JSON_UNESCAPED_SLASHES);
    $users_obj = '{"users" : ' . $users_obj . '}';

    echo($users_obj);
    return $users_obj;
}

function print_arr($arr){
	echo '<pre>' . print_r($arr, true) . '</pre>';
}

function add_news() {
    global $stmt, $link;
    clear();
    extract($_POST);
//var_dump($_POST);

    mysqli_stmt_prepare($stmt, "INSERT INTO news (newsId, newsName, newsDate, newsLocation, newsDescr, path) VALUES(uuid(), ?, ?, ?, ?, ?)");
    mysqli_stmt_bind_param($stmt, 'sssss',  $newsName, $newsDate, $newsLocation, $newsDescr, $path);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    
}

function get_news() {

    global $link;
    global $stmt;
    clear();
    extract($_POST);

    mysqli_stmt_prepare($stmt,"SELECT * FROM news WHERE newsName = ?");
    mysqli_stmt_bind_param($stmt,'s', $newsName);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));

    $newsInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $newsInfoArray[] = $row;
        }

        // $currentNews = $newsInfoArray[0];
        //var_dump($newsInfoArray);


        return $newsInfoArray;

   
    }
}

function delete_news() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);
    //var_dump($_POST);

    mysqli_stmt_prepare($stmt,"DELETE FROM news WHERE newsId = ?");
    mysqli_stmt_bind_param($stmt,'s', $newsId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

function delete_user() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);
    //var_dump($_POST);

    mysqli_stmt_prepare($stmt,"DELETE FROM users WHERE userId = ?");
    mysqli_stmt_bind_param($stmt,'s', $userId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

function add_partner() {
    global $stmt, $link;
    clear();
    extract($_POST);
//var_dump($_POST);

    mysqli_stmt_prepare($stmt, "INSERT INTO partners (partnerId, partnerName, path, partnerLink, partnerTerms) VALUES(uuid(), ?, ?, ?, ?)");
    mysqli_stmt_bind_param($stmt, 'ssss',  $partnerName, $path, $partnerLink, $partnerTerms);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    
}

function get_partner() {

    global $link;
    global $stmt;
    clear();
    extract($_POST);
    

    mysqli_stmt_prepare($stmt,"SELECT * FROM partners WHERE partnerId = ?");
    mysqli_stmt_bind_param($stmt,'s', $partnerId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));

    $partnerInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $partnerInfoArray[] = $row;
        }

        // $currentNews = $newsInfoArray[0];
        //var_dump($newsInfoArray);


        return $partnerInfoArray;

   
    }
}

function get_all_partners_json(){

	global $link;
	$query = "SELECT * FROM partners";
	$result = mysqli_query($link, $query);
    
    $partners = array();

    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $partners[] = $row;
          
        }

        $partners_obj = '{"partners": ' . json_encode($partners, JSON_UNESCAPED_SLASHES) . '}';
 
        return ($partners_obj);

    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function delete_partner() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);
    //var_dump($_POST);

    mysqli_stmt_prepare($stmt,"DELETE FROM partners WHERE partnerId = ?");
    mysqli_stmt_bind_param($stmt,'s', $partnerId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

function add_banner() {
    global $stmt, $link;
    clear();
    extract($_POST);
//var_dump($_POST);

    mysqli_stmt_prepare($stmt, "INSERT INTO banners (bannerId, bannerName, path) VALUES(uuid(), ?, ?)");
    mysqli_stmt_bind_param($stmt, 'ss',  $bannerName, $path);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    
}

function get_banner() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);

    mysqli_stmt_prepare($stmt,"SELECT * FROM banners WHERE bannerName = ?");
    mysqli_stmt_bind_param($stmt,'s', $bannerName);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));

    $bannerInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $bannerInfoArray[] = $row;
        }

        // $currentNews = $newsInfoArray[0];
        //var_dump($newsInfoArray);


        return $bannerInfoArray;

   
    }
}

function get_all_banners_json(){

	global $link;
	$query = "SELECT * FROM banners";
	$result = mysqli_query($link, $query);
    
    $banners = array();

    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $banners[] = $row;
          
        }

        $banners_obj = '{"banners": ' . json_encode($banners, JSON_UNESCAPED_SLASHES) . '}';
 
        return ($banners_obj);

    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function delete_banner() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);
    //var_dump($_POST);

    mysqli_stmt_prepare($stmt,"DELETE FROM banners WHERE bannerId = ?");
    mysqli_stmt_bind_param($stmt,'s', $bannerId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

function add_photo() {
    global $stmt, $link;
    clear();
    extract($_POST);
//var_dump($_POST);

    mysqli_stmt_prepare($stmt, "INSERT INTO photos (photoId, photoName, path) VALUES(uuid(), ?, ?)");
    mysqli_stmt_bind_param($stmt, 'ss',  $photoName, $path);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    
}

function get_photo() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);

    mysqli_stmt_prepare($stmt,"SELECT * FROM photos WHERE photoName = ?");
    mysqli_stmt_bind_param($stmt,'s', $photoName);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));

    $photoInfoArray = [];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $photoInfoArray[0] = $row;
        }

        // $currentNews = $newsInfoArray[0];
        //var_dump($newsInfoArray);


        return $photoInfoArray;

   
    }
}

function get_all_photos_json(){

	global $link;
	$query = "SELECT * FROM photos";
	$result = mysqli_query($link, $query);
    
    $photos = array();

    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $photos[] = $row;
          
        }

        $photos_obj = '{"photos": ' . json_encode($photos, JSON_UNESCAPED_SLASHES) . '}';
 
        return ($photos_obj);

    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function delete_photo() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);
    //var_dump($_POST);

    mysqli_stmt_prepare($stmt,"DELETE FROM photos WHERE photoId = ?");
    mysqli_stmt_bind_param($stmt,'s', $photoId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

function add_product() {
    global $stmt, $link;
    clear();
    extract($_POST);
//var_dump($_POST);

    mysqli_stmt_prepare($stmt, "INSERT INTO products (categoryId, category, productId, productName, productImage, productPrice) VALUES(?, ?, uuid(), ?, ?, ?)");
    mysqli_stmt_bind_param($stmt, 'sssss',   $categoryId, $category, $productName, $productImage, $productPrice);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
//print(mysqli_stmt_errno($stmt));
}

function get_product() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);

    mysqli_stmt_prepare($stmt,"SELECT * FROM products WHERE productName = ?");
    mysqli_stmt_bind_param($stmt,'s', $productName);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

    $productInfoArray = [];

    if($mysqli_result){
        foreach($mysqli_result as $row){
            $productInfoArray[] = $row;
        }
        return $productInfoArray;
    }
}

function get_all_products_json(){
    global $stmt;
    global $link;
    $query = "SELECT * FROM products";
    $result = mysqli_query($link, $query);

    $products = array();

    if($result){
        foreach($result as $row){
            $products[] = $row;
        }
        $products_obj = '{"products": ' . json_encode($products, JSON_UNESCAPED_SLASHES) . '}';

        return ($products_obj);
    } else{
        echo "Ошибка: " . mysqli_stmt_errno($stmt);
    }
}

function delete_product() {
    global $link;
    global $stmt;
    clear();
    extract($_POST);
    //var_dump($_POST);

    mysqli_stmt_prepare($stmt,"DELETE FROM products WHERE productId = ?");
    mysqli_stmt_bind_param($stmt,'s', $productId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);
}

function get_all_categories_json(){
    global $stmt;
    global $link;
    $query = "SELECT * FROM categories";
    $result = mysqli_query($link, $query);

    $categories = array();

    if($result){
        foreach($result as $row){
            $categories[] = $row;
        }
        $categories_obj = '{"categories": ' . json_encode($categories, JSON_UNESCAPED_SLASHES) . '}';

        return ($categories_obj);
    } else{
        echo "Ошибка: " . mysqli_stmt_errno($stmt);
    }
}

function get_current_product($productId) {
   
    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt,"SELECT * FROM products WHERE productId = ?");
    mysqli_stmt_bind_param($stmt,'s', $productId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);


    $productInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $productInfoArray[] = $row;
        }

        $productInfoArray[0]["id"] = strval($productInfoArray[0]["id"]);
        
        
        print(json_encode($productInfoArray[0], JSON_UNESCAPED_SLASHES));
        return $productInfoArray[0];
    } else {
        echo "Ошибка: " . print(mysqli_stmt_errno($stmt));
    }
}