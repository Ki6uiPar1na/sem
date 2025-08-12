<?php
session_start();
$conn = mysqli_connect("localhost", "root", "", "semester");

$email = $_POST['email'];
$pass  = $_POST['pass'];

$sql = "SELECT * FROM students WHERE email = '{$email}'";
$result = mysqli_query($conn, $sql);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);

    if ($row['pass'] === $pass) {
        $_SESSION['email'] = $email;
        header("Location: dashboard.php");
        exit; // stop script after redirect
    } else {
        echo "Incorrect password";
        header("Location: login.php");
    }
} else {
    echo "User not found";
}
?>
