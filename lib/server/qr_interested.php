<?php

header('Content-Type: application/json; charset=utf-8');

require_once 'qrmanagement.php';

if(isset($_GET['course_code'])){
    $course_code = $_GET['course_code'];

//    NumScan($course_code);
    Interested($course_code);

} else {
    error_log("Course code not provided in URL.");
}

?>
