<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

///
///
///

$conn = new mysqli('localhost', '2336879', 'v1zh41', 'db2336879');

if ($conn -> connect_error){
    echo json_encode(['error' => 'Database could not be accessed']);
    exit;
}


function GetAll(){
    global $conn;

    $statement = "SELECT ID, Name, Email, Phone, Contact FROM users"; //Query
    $result = $conn -> query($statement); //Execute Query

    $rows = array();
    while ($row = $result -> fetch_assoc()){
        $rows[] = $row;
    }

    print json_encode($rows);

    $result -> free_result();
    $conn -> close(); //Close connection

}


function addUser($name, $email, $phone, $contact) {
    global $conn;

    try{
        $statement = $conn->prepare("INSERT INTO users (Name, Email, Phone, Contact) VALUES (?, ?, ?, ?)"); //Query
        $statement->bind_param("sssi", $name, $email, $phone, $contact); //Use entered Data
        //Execute query
        if ($statement->execute()) {
            echo "New record created successfully";
        } else {
            echo "Error: ". $statement->error; //Error Handling
        }
        $statement -> close(); //Close Query
    } catch (Exception $e) {
        echo "Exception occurred: ". $e->getMessage(); //Error Handling
    }
    $conn->close(); //Close connection
}


?>