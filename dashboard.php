<?php

session_start();
if(!isset($_SESSION['email'])){
	header("Location: login.php");
	exit();
}
?>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Welcome</title>
</head>
<body>
	Welcome to Dashboard
	<a href="logout.php"><button type="submit">Logout</button></a>
</body>
</html>

<?php

$conn = mysqli_connect("localhost", "root", "", "semester");
$sql = "select * from students";

$result = mysqli_query($conn, $sql);

if(mysqli_num_rows($result) <= 0){
	session_start();
	session_unset();
	session_destroy();
	header("Location: index.html");
}

echo "<table border='2'>";
echo "<tr>
        <th>Name</th>
        <th>Email</th>
        <th>Department</th>
        <th>Image</th>
        <th colspan=2>Operation</th>

      </tr>";

while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>";
    echo "<td>{$row['name']}</td>";
    echo "<td>{$row['email']}</td>";
    echo "<td>{$row['department']}</td>";
    echo "<td><img src='data:image/jpeg;base64,{$row['image']}' width='100' height='100'></td>";
    echo "<td> <a href='update.php?id={$row['id']}'>Update</a> </td>";
	echo "<td><a href='delete.php?id={$row['id']}' onclick='return confirm(\"Are you sure?\")'>Delete</a></td>";
    echo "</tr>";
}

echo "</td>";
echo "</table>";

?>