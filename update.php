<?php
echo "Welcome<br><br>";

// Get ID and validate it
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    die("Invalid ID.");
}
$id = (int)$_GET['id'];

// Connect to database
$conn = mysqli_connect("localhost", "root", "", "semester");


if (!$conn) {
    die("Database connection failed: " . mysqli_connect_error());
}

// Fetch student record
$sql = "SELECT * FROM students WHERE id = {$id}";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) === 0) {
    die("No record found for ID {$id}");
}

$row = mysqli_fetch_assoc($result);

// Display current info in a form for updating
?>

<div class="bg-blue-100 flex flex-row p-4 text-black">
    <form action="update_process.php" method="post" enctype="multipart/form-data" class="flex flex-col gap-3 w-full">
    	<input type="hidden" name="id" value="<?php echo $row['id'] ?>">
        <label>
            Name:
            <input type="text" name="name" id="name" placeholder="Enter your name" class="text-black p-2 rounded w-full" value="<?php echo $row['name'] ?>">
        </label>

        <label>
            Department:
            <input type="text" name="dept" id="dept" placeholder="Enter your Department name" class="text-black p-2 rounded w-full" value="<?php echo $row['department'] ?>">
        </label>

        <label>
            Email:
            <input type="email" name="email" id="email" placeholder="Enter your email" class="text-black p-2 rounded w-full" value="<?php echo $row['email'] ?>">
        </label>

        <label>
            Password:
            <input type="text" name="pass" id="pass" placeholder="Enter your password" class="text-black p-2 rounded w-full" value="<?php echo $row['pass'] ?>">
        </label>

        <label>
            Upload your image:
            <input type="file" name="profilePhoto" id="profilePhoto" class="text-black p-2 rounded w-full" value="<?php echo $row['name'] ?>">
        </label>

        <label>Your Current Image
        	<img src="data:image/jpeg;base64, <?php echo $row['image'] ?>">
        </label>

        <button type="submit" class="bg-white text-blue-600 font-bold p-2 rounded hover:bg-green-400">
            Update
        </button>
    </form>
</div>
