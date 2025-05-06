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

    $statement = "SELECT ID, CourseCode, CourseName, NumScan, Interested FROM QR"; //Query
    $result = $conn -> query($statement); //Execute Query

    $row = $result -> fetch_assoc();
    print json_encode($row);

    $result -> free_result();
    $conn -> close(); //Close connection

}

function NumScan($conn, $CourseCode) {
    try{
    $statement = "UPDATE QR SET NumScan = NumScan + 1 WHERE CourseCode = $CourseCode";

    if ($conn->query($statement) === TRUE) {
        echo "Record updated successfully";
    } else {
        echo "Error updating record: ". $conn->error;
    }
    } catch (Exception $e) {
        echo "Exception occurred: ". $e->getMessage(); //Error Handling
    }
    $conn->close();// Close connection

}

function Interested($conn, $CourseCode) {
    try{
    $statement = "UPDATE QR SET Interested = Interested + 1 WHERE CourseCode = $CourseCode";

    if ($conn->query($statement) === TRUE) {
        echo "Record updated successfully";
    } else {
        echo "Error updating record: ". $conn->error;
    }
    } catch (Exception $e) {
        echo "Exception occurred: ". $e->getMessage(); //Error Handling
    }
    $conn->close();// Close connection
}
?>