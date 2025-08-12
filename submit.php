<?php
$conn = mysqli_connect("localhost", "root", "", "semester");

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $name = $_POST['name'];
    $dept = $_POST['dept']; // changed to match form
    $email = $_POST['email'];
    $pass = $_POST['pass'];
    $imageData = file_get_contents($_FILES['profilePhoto']['tmp_name']);
    $imageHash = base64_encode($imageData);

    $sql = "INSERT INTO students (name, department, email, pass, image) 
            VALUES('$name', '$dept', '$email', '$pass', '$imageHash')";

    $flag = mysqli_query($conn, $sql);
    if($flag){
        echo "Success";
        header("Location: login.php");
        exit;
    } else {
        echo "Failed to insert";
        header("Location: index.html");
        exit;
    }

    echo $name . $dept . $email . $pass;
    echo "<br>Image: <img src='data:image/jpeg;base64,{$imageHash}' width='150'>";
} else {
    echo "Something Error";
}
?>
