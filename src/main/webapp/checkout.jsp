<%@page import="com.Entities.User" %>

<%
User user=(User)session.getAttribute("current_user");
if(user==null)
{
	session.setAttribute("message", "You are not logged in !! Login first...");
	response.sendRedirect("login.jsp");
	return;
}
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="custom.css" />
</head>
<body class="bg-white border-gray-200 dark:bg-slate-800">
	<%@include file="navbar.jsp"%>

	<div
		class="flex justify-evenly p-4 md:p-10 border rounded-t dark:border-gray-600">

		<!-- Cart -->
		<div class="border rounded-xl py-2 px-4 h-max">
			<h3
				class="text-xl text-center font-semibold text-gray-900 dark:text-white">
				My Cart</h3>
			<div
				class="cart-body relative overflow-x-auto shadow-md sm:rounded-lg">

			</div>
		</div>
		<!-- checkout details -->
		<div class="border rounded-xl py-2 px-4 h-max">
			<h3
				class="text-xl text-center font-semibold text-gray-900 dark:text-white">
				Address details</h3>
			<div>
				<form class="max-w-sm mx-auto mt-1 text-black dark:text-white"
					method="post" action="">
					<div class="mb-3">
						<label for="name" class="block mb-1 text-sm font-medium">Name</label>
						<input value="<%= user.getUserName() %>" name="user_name" type="text" id="name"
							class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
							placeholder="John Cena" required />
					</div>
					<div class="mb-2">
						<label for="email" class="block mb-1 text-sm font-medium">Email
							address</label> <input value="<%= user.getUserEmail() %>" name="user_email" type="email" id="email"
							class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
							placeholder="johncena@gmail.com" required />
					</div>

					<div class="mb-2">
						<label for="phone" class="block mb-1 text-sm font-medium">Contact
							no.</label> <input name="user_phone" value="<%= user.getUserPhone() %>" type="text" id="phone"
							class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
							placeholder="Enter your contact number" required />
					</div>
					
					<div class="mb-2">
						<label for="address" class="block mb-1 text-sm font-medium">Shipping
							Address</label>
						<textarea name="user_address" id="address" rows="3"
							class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
							placeholder="Enter your address..."><%= user.getUserAddress() %></textarea>
					</div>

					<div class="flex gap-2 justify-center">
						<button type="button"
							class="text-white bg-yellow-600 hover:bg-yellow-700 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center">Continue
							Shopping</button>
						<button type="submit"
							class="text-white bg-green-700 hover:bg-green-800 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center">Order
							Now</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
	<script src="./js/script.js"></script>
</body>
</html>