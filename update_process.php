<?php
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $id = (int)$_POST['id'];
    $name = $_POST['name'];
    $department = $_POST['dept']; // match form name
    $email = $_POST['email'];
    $pass = $_POST['pass'];

    // Check if file uploaded
    if (!empty($_FILES['profilePhoto']['tmp_name'])) {
        $image = file_get_contents($_FILES['profilePhoto']['tmp_name']);
        $imageHash = base64_encode($image);

        $sql = "UPDATE students SET 
    name = '$name', 
    department = '$department',
    email = '$email',
    pass = '$pass',
    image = '$imageHash' 
    WHERE id = '$id'";

    }
    else{
    	$sql = "UPDATE students SET 
    name = '$name', 
    department = '$department',
    email = '$email',
    pass = '$pass' 
    WHERE id = '$id'";

    }

	$conn = mysqli_connect("localhost", "root", "", "semester");

	if(mysqli_query($conn, $sql)){
		echo "Updated Successfully";
        header("Location: dashboard.php");
        exit();
	}
	else{
		echo "Not Updated";
	}


    // echo "ID: " . $id;
}
?>
