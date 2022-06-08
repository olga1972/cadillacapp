<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

require '../PHPMailer/src/Exception.php';
require '../PHPMailer/src/PHPMailer.php';
require '../PHPMailer/src/SMTP.php';

require '../PHPMailer/PHPMailerAutoload.php';

$admin_email = $_POST["admin_email"];
print($admin_email);
//$admin_email = array();
//foreach ( $_POST["admin_email"] as $key => $value ) {
//    array_push($admin_email, $value);
//}

$form_subject = trim($_POST["form_subject"]);
print($form_subject);

$mail = new PHPMailer;
$mail->CharSet = 'UTF-8';

try {
    //Server settings
    $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
    $mail->isSMTP();                                            //Send using SMTP
    $mail->Host       = 'smtp.google.com';                     //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = 'olga.sadyreva@gmail.com';                     //SMTP username
    $mail->Password   = 'lazurit(9';                               //SMTP password
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
    $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

    //Recipients
    $mail->setFrom('from@example.com', 'Mailer');
    $mail->addAddress('olga.sadyreva@mail.ru', 'Joe User');     //Add a recipient
    $mail->addAddress('olgasadyreva@yandex.com');               //Name is optional
    $mail->addReplyTo('info@example.com', 'Information');
    $mail->addCC('cc@example.com');
    $mail->addBCC('bcc@example.com');

    //Attachments
//    $mail->addAttachment('/var/tmp/file.tar.gz');         //Add attachments
//    $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    //Optional name

    //Content
    $mail->isHTML(true);                                  //Set email format to HTML
    $mail->Subject = 'Here is the subject';
    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}

// Настройки SMTP
// $mail->isSMTP();
// $mail->SMTPAuth = true;
// $mail->SMTPDebug = 0;

// $mail->Host = 'ssl://smtp.gmail.com';
// $mail->Port = 465;
// $mail->Username = 'Логин';
// $mail->Password = 'Пароль';


//$c = true;
//$message = '';
//foreach ( $_POST as $key => $value ) {
//    if ( $value != ""  && $key != "admin_email" && $key != "form_subject" ) {
//        if (is_array($value)) {
//            $val_text = '';
//            foreach ($value as $val) {
//                if ($val && $val != '') {
//                    $val_text .= ($val_text==''?'':', ').$val;
//                }
//            }
//            $value = $val_text;
//        }
//        $message .= "
//		" . ( ($c = !$c) ? '<tr>':'<tr>' ) . "
//		<td style='padding: 10px; width: auto;'><b>$key:</b></td>
//		<td style='padding: 10px;width: 100%;'>$value</td>
//		</tr>
//		";
//    }
//}
//$message = "<table style='width: 50%;'>$message</table>";
//
//
//// От кого
//$mail->setFrom('adm@' . $_SERVER['HTTP_HOST'], 'Your best site');
//
//// Кому
////foreach ( $admin_email as $key => $value ) {
////    $mail->addAddress($value);
////}
//$mail->addAddress($admin_email);
//// Тема письма
//$mail->Subject = $form_subject;
//
//// Тело письма
//$body = $message;
//// $mail->isHTML(true);  это если прям верстка
//$mail->msgHTML($body);
//
//// Приложения
//if ($_FILES){
//    foreach ( $_FILES['file']['tmp_name'] as $key => $value ) {
//        $mail->addAttachment($value, $_FILES['file']['name'][$key]);
//    }
//}
//$mail->send();
?>
