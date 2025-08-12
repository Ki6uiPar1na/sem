<?php

$id = $_GET['id'];
echo $id;

$sql = "delete from students where id = '$id'";
$conn = mysqli_connect("localhost", "root", "", "semester");

mysqli_query($conn, $sql);
header("Location: logout.php");


?>