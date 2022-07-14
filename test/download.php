<?php
// Initialize a file URL to the variable
$file_path = 'https://cadillacapp.ru/test/download.php';
$file_name = 'app-release.apk';


//header("Cache-Control: public");
//header("Content-description: File Transfer");
//header('Content-Type: application/com.android.package-install');
header('Content-Type: application/vnd.android.package-archive');
//header("Content-length: " . filesize($file_name));
header('Content-Disposition: attachment; filename="' . $file_name . '"');
header("Content-Tranfer-Encoding: binary");
ob_end_flush();
readfile($file_path);
return true;

