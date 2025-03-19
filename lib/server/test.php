<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: *");
header('Content-Type: application/json');

echo json_encode(['status' => 'success', 'message' => 'Test response']);
?>