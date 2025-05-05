<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

///
///
///

$conn = new mysqli('localhost', '2336879', 'v1zh41', 'db2336879');

if ($conn->connect_error) {
    echo json_encode(['error' => 'Database could not be accessed']);
    exit;
}


function NumScan($CourseCode){
    global $conn;

    try {
        $statement = "UPDATE qrcodes SET NumScan = NumScan + 1 WHERE CourseCode = $CourseCode";

        if ($conn->query($statement) === TRUE) {
            echo "Record updated successfully";
        } else {
            echo "Error updating record: " . $conn->error;
        }
    } catch (Exception $e) {
        echo "Exception occurred: " . $e->getMessage(); //Error Handling
    }
    $conn->close();// Close connection

}

function Interested($CourseCode){
    global $conn;

    try {
        $statement = "UPDATE qrcodes SET Interested = Interested + 1 WHERE CourseCode = $CourseCode";

        if ($conn->query($statement) === TRUE) {
            echo "Interested column updated successfully";
        } else {
            echo "Error updating record: " . $conn->error;
        }
    } catch (Exception $e) {
        echo "Exception occurred: " . $e->getMessage(); //Error Handling
    }

    try {
        $statement = "UPDATE qrcodes SET NumScan = NumScan + 1 WHERE CourseCode = $CourseCode";

        if ($conn->query($statement) === TRUE) {
            echo "NumScan column updated successfully";
        } else {
            echo "Error updating record: " . $conn->error;
        }
    } catch (Exception $e) {
        echo "Exception occurred: " . $e->getMessage(); //Error Handling
    }
    $conn->close();// Close connection
}

?>