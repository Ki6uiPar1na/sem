<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.tailwindcss.com"></script>
	<title>Login Page</title>
</head>
<body class="min-h-screen flex items-center justify-center">
	<form action="verify.php" method="post">
		<label>
			Email: 
			<input type="email" name="email" id="email" class="border p-2 rounded" required>
		</label>
		<label>
			Password: 
			<input type="password" name="pass" id="pass" class="border p-2 rounded" required>
		</label>
		<label>
			<button type="submit" class="bg-blue-500 text-white p-2 rounded">Submit</button>
		</label>
	</form>
</body>
</html>