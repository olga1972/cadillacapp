<?php
// Initialize a file URL to the variable
if( !ini_get('allow_url_fopen')){
    echo "'allow_url_fopen' is off\n";
    exit(1);
}

$file_path = 'https://cadillacapp.ru/cadillac.ipa';
$file_name = 'cadillac.ipa';


//header("Cache-Control: public");
header("Content-description: File Transfer");
//header('Content-Type: application/com.android.package-install');
header('Content-Type: application/vnd.android.package-archive');
//header("Content-length: " . filesize($file_name));
header('Content-Disposition: attachment; filename="' . $file_name . '"');
header("Content-Tranfer-Encoding: binary");
header('Cache-Control: must-revalidate');
header('Pragma: public');
ob_end_flush();
readfile($file_path);

return true;

