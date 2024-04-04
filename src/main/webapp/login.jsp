<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up - Shoppee</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />
</head>
<body class="bg-white border-gray-200 dark:bg-slate-800">
	<%@include file="navbar.jsp"%>

	<!-- register form -->
	<div class="border rounded-xl max-w-md py-2 px-4 mt-1 mx-auto">
		<%@include file="message.jsp"%>
		<img class="h-24 mx-auto" alt="" src="./images/register.png">
		<h2 class="text-center text-3xl dark:text-white">Login!!!</h2>

		<form class="max-w-sm mx-auto mt-1 text-black dark:text-white"
			method="post" action="LoginServlet">

			<div class="mb-2">
				<label for="email" class="block mb-1 text-sm font-medium">Enter
					your email</label> <input name="user_email" type="email" id="email"
					class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
					placeholder="johncena@gmail.com" required />
			</div>
			<div class="mb-2">
				<label for="password" class="block mb-1 text-sm font-medium">Enter
					your password</label> <input name="user_password" type="password"
					id="password"
					class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
					placeholder="Enter your password" required />
			</div>
			<p class="text-sm my-2">If not registered <a href="register.jsp" class="text-blue-400">Click Here</a>.</p>
			<div class="text-center">
				<button type="submit"
					class="text-white bg-purple-700 hover:bg-purple-800 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center">Login</button>
			</div>
		</form>
	</div>


	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>

</body>
</html>