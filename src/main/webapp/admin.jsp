<%@page import="com.Entities.Product"%>
<%@page import="org.hibernate.Session"%>
<%@page import="jakarta.persistence.Query"%>
<%@page import="com.provider.FactoryProvider"%>
<%@page import="java.util.List"%>
<%@page import="com.Entities.Category"%>
<%@page import="com.Entities.User"%>

<!-- protecting admin panel -->

<%
User user = (User) session.getAttribute("current_user");
// checking whether the user is logged in or not
if (user == null) {
	session.setAttribute("message", "You're not logged in !!! Login first...");
	response.sendRedirect("login.jsp");
	return;
}
// if logged in then whether the user is admin or not
else {
	if (user.getUserType().equals("normal")) {
		session.setAttribute("message", "You're not allowed to access this...");
		response.sendRedirect("login.jsp");
		return;
	}
}
%>


<%
Session s1 = FactoryProvider.getSessionFactory().openSession();
Query que = s1.createQuery("FROM Category");
List<Category> cList = que.getResultList();

List<Product> pList = s1.createQuery("FROM Product").getResultList();
List<User> uList = s1.createQuery("FROM User").getResultList();
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="custom.css" />
</head>
<body class="bg-white border-gray-200 dark:bg-slate-800">
	<%@include file="navbar.jsp"%>
	<!-- panel design -->
	<div class="p-4 bg-white rounded-lg md:p-8 dark:bg-gray-800" id="stats">
		<dl
			class="grid max-w-screen-xl grid-cols-2 gap-8 p-4 mx-auto text-gray-900 sm:grid-cols-3 xl:grid-cols-4 dark:text-white sm:p-8">
			<div class="flex flex-col items-center justify-center">
				<dt class="mb-2 text-3xl font-extrabold"><%= cList.size() %>+</dt>
				<dd class="text-gray-500 dark:text-gray-400">Categories</dd>
			</div>
			<div class="flex flex-col items-center justify-center">
				<dt class="mb-2 text-3xl font-extrabold"><%= pList.size() %>+</dt>
				<dd class="text-gray-500 dark:text-gray-400">Products</dd>
			</div>
			<div class="flex flex-col items-center justify-center">
				<dt class="mb-2 text-3xl font-extrabold"><%= uList.size() %>+</dt>
				<dd class="text-gray-500 dark:text-gray-400">Users</dd>
			</div>
			<div class="flex flex-col items-center justify-center">
				<dt class="mb-2 text-3xl font-extrabold">1K+</dt>
				<dd class="text-gray-500 dark:text-gray-400">Orders</dd>
			</div>


		</dl>
	</div>

	<!-- Category section -->
	<div class="w-full bg-slate-700 flex justify-evenly p-2">
		<div
			class="w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
			<div class="flex flex-col items-center pb-10">
				<img class="w-24 h-24 my-3 rounded-sm" src="./images/category.png"
					alt="Bonnie image" />
				<h5 class="mb-1 text-xl font-medium text-gray-900 dark:text-white">Category</h5>
				<span class="text-sm text-gray-500 dark:text-gray-400">Want
					to add more category or view</span>
				<div class="flex mt-4 md:mt-6">
					<a href="#" data-modal-target="category-modal"
						data-modal-toggle="category-modal"
						class="inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-800">Add
						Category</a> <a href="#"
						class="py-2 px-4 ms-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">View
						Category</a>
				</div>
			</div>
		</div>
		<!-- Product section -->

		<div
			class="w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
			<div class="flex flex-col items-center pb-10">
				<img class="w-24 h-24 my-3 rounded-sm" src="./images/product.png"
					alt="Bonnie image" />
				<h5 class="mb-1 text-xl font-medium text-gray-900 dark:text-white">Product</h5>
				<span class="text-sm text-gray-500 dark:text-gray-400">Want
					to add more category or view</span>
				<div class="flex mt-4 md:mt-6">
					<a href="#" data-modal-target="product-modal"
						data-modal-toggle="product-modal"
						class="inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">Add
						Product</a> <a href="#"
						class="py-2 px-4 ms-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">View
						Product</a>
				</div>
			</div>
		</div>
	</div>

	<div class="w-2/3 mx-auto">
		<%@include file="message.jsp"%>
	</div>

	<!-- >>>>>>>>>>>>>>>>>>>>>>>>>CATEGORY MODAL<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< -->

	<!-- Main modal -->
	<div id="category-modal" tabindex="-1" aria-hidden="true"
		class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
		<div class="relative p-4 w-full max-w-md max-h-full">
			<!-- Modal content -->
			<div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
				<!-- Modal header -->
				<div
					class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
					<h3 class="text-lg font-semibold text-gray-900 dark:text-white">
						Create New Category</h3>
					<button type="button"
						class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
						data-modal-toggle="category-modal">
						<svg class="w-3 h-3" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="none"
							viewBox="0 0 14 14">
                        <path stroke="currentColor"
								stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
								d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                    </svg>
						<span class="sr-only">Close modal</span>
					</button>
				</div>
				<!-- Modal body -->
				<form class="p-4 md:p-5" action="ProductOperationServlet"
					method="post">
					<input type="hidden" name="operation" value="add_category" />
					<div class="grid gap-4 mb-4 grid-cols-2">
						<div class="col-span-2">
							<label for="name"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">New
								Category Name</label> <input type="text" name="category_name" id="name"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
								placeholder="Type product name" required />
						</div>

						<div class="col-span-2">
							<label for="description"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Category
								Description</label>
							<textarea id="description" rows="4" name="category_decription"
								class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
								placeholder="Write product description here"></textarea>
						</div>
					</div>
					<button type="submit"
						class="text-white inline-flex items-center bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-800">
						<svg class="me-1 -ms-1 w-5 h-5" fill="currentColor"
							viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd"
								d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
								clip-rule="evenodd"></path></svg>
						Add new category
					</button>
				</form>
			</div>
		</div>
	</div>

	<!-- *********************END CATEGORY MODAL************************* -->

	<!-- >>>>>>>>>>>>>>>>>>>>>>PRODUCT MODAL<<<<<<<<<<<<<<<<<<<<<<<<<<<< -->

	<!-- Main modal -->
	<div id="product-modal" tabindex="-1" aria-hidden="true"
		class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
		<div class="relative p-4 w-full max-w-md max-h-full">
			<!-- Modal content -->
			<div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
				<!-- Modal header -->
				<div
					class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
					<h3 class="text-lg font-semibold text-gray-900 dark:text-white">
						Create New Product</h3>
					<button type="button"
						class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
						data-modal-toggle="product-modal">
						<svg class="w-3 h-3" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="none"
							viewBox="0 0 14 14">
                        <path stroke="currentColor"
								stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
								d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                    </svg>
						<span class="sr-only">Close modal</span>
					</button>
				</div>
				<!-- Modal body -->
				<form class="p-4 md:p-5" action="ProductOperationServlet"
					method="post" enctype="multipart/form-data">
					<input type="hidden" name="operation" value="add_product" />
					<div class="grid gap-4 mb-4 grid-cols-2">
						<div class="col-span-2">
							<label for="name"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
							<input type="text" name="product_name" id="name"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
								placeholder="Type product name" required>
						</div>
						<div class="col-span-2 sm:col-span-1">
							<label for="price"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Price</label>
							<input type="number" name="product_price" id="price"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
								placeholder="$2999" required>
						</div>
						<div class="col-span-2 sm:col-span-1">
							<label for="category"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Category</label>
							<select id="category" name="product_category"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
								<option selected>Select category</option>

								<%
								for (Category c : cList) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
								<%
								}
								s.close();
								%>
							</select>
						</div>
						<div class="col-span-2 sm:col-span-1">
							<label for="price"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Discount</label>
							<input type="number" name="product_discount" id="discount"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
								placeholder="30%" required>
						</div>
						<div class="col-span-2 sm:col-span-1">
							<label for="price"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Quantity</label>
							<input type="number" name="product_quantity" id="quantity"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
								placeholder="0" required>
						</div>
						<div class="col-span-2">
							<label for="image"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Product
								Image</label> <input type="file" name="product_image" id="image"
								class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400"
								required>
						</div>
						<div class="col-span-2">
							<label for="description"
								class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Product
								Description</label>
							<textarea id="description" rows="4" name="product_description"
								class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
								placeholder="Write product description here"></textarea>
						</div>
					</div>
					<button type="submit"
						class="text-white inline-flex items-center bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-blue-800">
						<svg class="me-1 -ms-1 w-5 h-5" fill="currentColor"
							viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd"
								d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
								clip-rule="evenodd"></path></svg>
						Add new product
					</button>
				</form>
			</div>
		</div>
	</div>

	<!-- *********************END PRODUCT MODAL************************* -->

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
	<script src="./js/script.js"></script>
</body>
</html>