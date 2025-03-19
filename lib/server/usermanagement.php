<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

///
///
///

$conn = new mysqli('localhost', '2350900', 'Lavinder2010', 'db2350900');

if ($conn -> connect_error){
    echo json_encode(['error' => 'Database could not be accessed']);
    exit;
}

function addUser($conn, $name, $email, $phone, $contact) {

    $statement = $conn->prepare("INSERT INTO Guests (Name, Email, Phone, Contact) VALUES (?, ?, ?, ?)");
    $statement->bind_param("sssi", $name, $email, $phone, $contact);
    try{
        $statement->execute();
    } catch (Exception $e) {

    }

}


?>
