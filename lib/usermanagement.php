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


function GetAll(){

    $statement = "SELECT id, name, email, telephone, contact FROM Guests"; //Query
    $result = $conn -> query($statement); //Execute Query

    $row = $result -> fetch_assoc();
    print json_encode($row);

    $result -> free_result();
    $conn -> close(); //Close connection

}


function addUser($conn, $name, $email, $phone, $contact) {
    try{
        $statement = $conn->prepare("INSERT INTO Guests (Name, Email, telephone, Contact) VALUES (?, ?, ?, ?)"); //Query
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
