<?php
require_once 'connect.php';
require_once 'funcs.php';
// Файлы phpmailer
//require_once ('./PHPMailer/PHPMailer.php');
//require_once('./PhpMailer/PHPMailer.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/PHPMailer/PHPMailer.php');

require_once($_SERVER['DOCUMENT_ROOT'].'/PHPMailer/SMTP.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/PHPMailer/Exception.php');

global $link;
// Переменные, которые отправляет пользователь
clear();
$admin = $_POST['email'];
$subject = $_POST['subject'];

$theme = $_POST['theme'];
$message = $_POST['message'];
$status = '';


// Настройки PHPMailer
$mail = new PHPMailer\PHPMailer\PHPMailer();

//try {
//    $mail->isSMTP();
//    $mail->CharSet = "UTF-8";
//    $mail->SMTPAuth   = true;
//    $mail->SMTPDebug = 2;
//    $mail->Debugoutput = function($str, $level) {$GLOBALS['status'][] = $str;};

    // Настройки вашей почты
//    $mail->Host       = 'mail.cadillac.fvds.ru'; // SMTP сервера вашей почты
//    $mail->Username   = 'admin@cadillac.fvds.ru'; // Логин на почте
//    $mail->Password   = '9R2BgX2EqEhJKmp'; // Пароль на почте
//    $mail->SMTPSecure = 'ssl';
//    $mail->Port       = 465;
    //$mail->Port = 465: 587;

    $mail->CharSet = "UTF-8";
    $mail->setFrom('olga.sadyreva@gmail.com', 'Olga Sadyreva'); // Адрес самой почты и имя отправителя

    // Получатель письма
    $mail->addAddress('admin@cadillac.fvds.ru');
    $mail->addAddress('olga.sadyreva@mail.ru'); // Ещё один, если нужен
    $mail->addAddress('elena@cadillacfamilyrussia.ru');
    $mail->Subject = 'Заявка';
    $mail->msgHTML("<html><body>
                <h1>Здравствуйте!</h1>
                <p>$theme</p>
                <p>$message</p>
                </html></body>");

// Отправляем
if ($mail->send()) {
    echo 'Письмо отправлено!';
} else {
    echo 'Ошибка: ' . $mail->ErrorInfo;
}

//($mail);
    // Прикрипление файлов к письму
//    if (!empty($file['name'][0])) {
//        for ($ct = 0; $ct < count($file['tmp_name']); $ct++) {
//            $uploadfile = tempnam(sys_get_temp_dir(), sha1($file['name'][$ct]));
//            $filename = $file['name'][$ct];
//            if (move_uploaded_file($file['tmp_name'][$ct], $uploadfile)) {
//                $mail->addAttachment($uploadfile, $filename);
//                $rfile[] = "Файл $filename прикреплён";
//            } else {
//                $rfile[] = "Не удалось прикрепить файл $filename";
//            }
//        }
//    }
// Отправка сообщения
//    $mail->isHTML(true);
//    $mail->Subject = $title;
//    $mail->Body = $body;

// Проверяем отравленность сообщения
//    if ($mail->send()) {$result = "success";}
//    else {$result = "error";}

//} catch (Exception $e) {
//    $result = "error";
//    $status = "Сообщение не было отправлено. Причина ошибки: {$mail->ErrorInfo}";
//}

// Отображение результата
//echo json_encode(["result" => $result, "resultfile" => $rfile, "status" => $status]);
// echo json_encode(["result" => $result, "status" => $status]);