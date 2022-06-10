<?php


//$to = 'nobody@example.comolga.sadyreva@mail.ru';
//$subject = 'the subject';
//$message = 'hello';
//$headers = 'From: admin@cadillac.fvds.ru' . "\r\n" .
////    'Reply-To: webmaster@example.com' . "\r\n" .
//    'X-Mailer: PHP/' . phpversion();
//
//mail($to, $subject, $message, $headers);

// Файлы phpmailer
require '../Phpmailer/PHPMailer.php';
require '../Phpmailer/SMTP.php';
require '../Phpmailer/Exception.php';

// Переменные, которые отправляет пользователь
$admin = $_POST['email'];
$subject = $_POST['subject'];

$theme = $_POST['theme'];
$message = $_POST['message'];
$status = '';

var_dump($_POST);

// Формирование самого письма
$title = "Заголовок письма";
$body = "
<h2>Новое письмо</h2>

<b>Почта:</b> $admin<br><br>
<b>Тема:</b><br>$theme<br><br>
<br>Сообщение:</br><br>$message";

// Настройки PHPMailer
$mail = new PHPMailer\PHPMailer\PHPMailer();

try {
    $mail->isSMTP();
    $mail->CharSet = "UTF-8";
    $mail->SMTPAuth   = true;
    $mail->SMTPDebug = 2;
    $mail->Debugoutput = function($str, $level) {$GLOBALS['status'][] = $str;};

    // Настройки вашей почты
    $mail->Host       = 'mail.cadillac.fvds.ru'; // SMTP сервера вашей почты
    $mail->Username   = 'admin@cadillac.fvds.ru'; // Логин на почте
    $mail->Password   = '9R2BgX2EqEhJKmp'; // Пароль на почте
    $mail->SMTPSecure = 'ssl';
    $mail->Port       = 465;
    //SMPT port:465:587
    $mail->setFrom('olga.sadyreva@mail.ru', 'Olga Sadyreva'); // Адрес самой почты и имя отправителя

    // Получатель письма
    $mail->addAddress('sadyreva.o@yandex.ru');
    $mail->addAddress('olga.sadyreva@gmail.com'); // Ещё один, если нужен

    var_dump($mail);
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
    $mail->isHTML(true);
    $mail->Subject = $title;
    $mail->Body = $body;

// Проверяем отравленность сообщения
    if ($mail->send()) {$result = "success";}
    else {$result = "error";}

} catch (Exception $e) {
    $result = "error";
    $status = "Сообщение не было отправлено. Причина ошибки: {$mail->ErrorInfo}";
}

// Отображение результата
//echo json_encode(["result" => $result, "resultfile" => $rfile, "status" => $status]);
echo json_encode(["result" => $result, "status" => $status]);