<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.tailwindcss.com"></script>
	<title>Sign Up Page</title>
</head>
<body class="min-h-screen flex items-center justify-center">
	<div class="bg-blue-100 flex flex-row p-4 text-black">
    <form action="submit.php" method="post" enctype="multipart/form-data" class="flex flex-col gap-3 w-full">
        <label>
            Name:
            <input type="text" name="name" id="name" placeholder="Enter your name" class="text-black p-2 rounded w-full">
        </label>

        <label>
            Department:
            <input type="text" name="dept" id="dept" placeholder="Enter your Department name" class="text-black p-2 rounded w-full">
        </label>

        <label>
            Email:
            <input type="email" name="email" id="email" placeholder="Enter your email" class="text-black p-2 rounded w-full">
        </label>

        <label>
            Password:
            <input type="password" name="pass" id="pass" placeholder="Enter your password" class="text-black p-2 rounded w-full">
        </label>

        <label>
            Upload your image:
            <input type="file" name="profilePhoto" id="profilePhoto" class="text-black p-2 rounded w-full">
        </label>

        <button type="submit" class="bg-white text-blue-600 font-bold p-2 rounded hover:bg-green-400">
            Submit
        </button>
    </form>
</div>

</body>
</html>