<?php

require_once 'usermanagement.php';

if (isset($_GET['name']) && isset($_GET['email']) && isset($_GET['phone']) && isset($_GET['contact'])){
    $name = $_GET['name'];
    $email = $_GET['email'];
    $phone = $_GET['phone'];
    $contact = $_GET['contact'];

    addUser($name, $email, $phone, $contact);


} else {
    echo "There is an error in the input received.";
}
