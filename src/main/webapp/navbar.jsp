<%@page import="com.Entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="jakarta.persistence.Query"%>
<%@page import="com.provider.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.Entities.User"%>

<%
// ye httpSession LoginServlet se aa rha h...
User user1 = (User) session.getAttribute("current_user");
%>

<nav class="bg-white border-gray-200 dark:bg-gray-900">
	<div
		class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
		<a href="https://flowbite.com/"
			class="flex items-center space-x-3 rtl:space-x-reverse"> <img
			src="./images/logo.png" class="h-10 rounded-full" alt="Shoppee Logo" />
			<span
			class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">Shoppee</span>
		</a>
		<div
			class="flex md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse gap-2">
			<button data-modal-target="cart" data-modal-toggle="cart">
				<img alt="cart" src="./images/cart.png" class="h-6 self-center">
			</button>
			<button data-modal-target="cart" data-modal-toggle="cart"
				class="cart-items text-black flex text-lg dark:text-gray-400 rounded-md items-center justify-center">Cart(0)</button>
			<!-- login/sign up button -->
			<%
			if (user1 == null) {
			%>
			<a href="login.jsp"><button type="button"
					class="text-white focus:outline-none font-medium rounded-lg text-sm px-4 py-2 text-center bg-slate-700 hover:bg-slate-800">Login</button>
			</a> <a href="register.jsp">
				<button type="button"
					class="text-white focus:outline-none font-medium rounded-lg text-sm px-4 py-2 text-center bg-purple-800 hover:bg-purple-900">Sign
					Up!</button>
			</a>
			<%
			} else {
			%>
			<a href="<%= user1.getUserType().equals("admin")? "admin.jsp":"normal.jsp" %>"
				class="text-black focus:outline-none font-medium rounded-lg text-sm px-4 py-2 text-center dark:text-white"><%=user1.getUserName()%>
			</a> <a href="LogoutServlet">
				<button type="button"
					class="text-white focus:outline-none font-medium rounded-lg text-sm px-4 py-2 text-center bg-slate-600 hover:bg-slate-700">Logout</button>
			</a>
			<%
			}
			%>



			<!-- hidden button (visible for mobile) -->
			<button data-collapse-toggle="navbar-cta" type="button"
				class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
				aria-controls="navbar-cta" aria-expanded="false">
				<span class="sr-only">Open main menu</span>
				<svg class="w-5 h-5" aria-hidden="true"
					xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
			  <path stroke="currentColor" stroke-linecap="round"
						stroke-linejoin="round" stroke-width="2"
						d="M1 1h15M1 7h15M1 13h15" />
		  </svg>
			</button>

		</div>

		<!-- navigation menu -->
		<div
			class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1"
			id="navbar-cta">
			<ul
				class="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
				<li><a href="index.jsp"
					class="block py-2 px-3 md:p-0 text-white bg-blue-700 rounded md:bg-transparent md:text-yellow-700 md:dark:text-yellow-500"
					aria-current="page">Home</a></li>

				<!-- Dropdown menu -->
				<li>
					<button id="dropdownNavbarLink"
						data-dropdown-toggle="dropdownNavbar"
						class="flex items-center justify-between w-full py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-yellow-700 md:p-0 md:w-auto dark:text-white md:dark:hover:text-yellow-500 dark:focus:text-white dark:border-gray-700 dark:hover:bg-gray-700 md:dark:hover:bg-transparent">
						Category
						<svg class="w-2.5 h-2.5 ms-2.5" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
    <path stroke="currentColor" stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" d="m1 1 4 4 4-4" />
  </svg>
					</button>

					<div id="dropdownNavbar"
						class="z-100 hidden font-normal bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700 dark:divide-gray-600">
						<ul class="py-2 text-sm text-gray-700 dark:text-gray-400"
							aria-labelledby="dropdownLargeButton">
							<li><a href="index.jsp?category=all"
								class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">All
									Product</a></li>
							<%
							Session s = FactoryProvider.getSessionFactory().openSession();
							Query query = s.createQuery("FROM Category");
							List<Category> catList = query.getResultList();
							for (Category c : catList) {
							%>
							<li><a href="index.jsp?category=<%=c.getCategoryId()%>"
								class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"><%=c.getCategoryTitle()%></a>
							</li>
							<%
							}
							s.close();
							%>
						</ul>
					</div>
				</li>
				<li><a href="#"
					class="block py-2 px-3 md:p-0 text-gray-900 rounded hover:bg-yellow-100 md:hover:bg-transparent md:hover:text-yellow-700 md:dark:hover:text-yellow-500 dark:text-white dark:hover:bg-yellow-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">About</a>
				</li>
				<li><a href="#"
					class="block py-2 px-3 md:p-0 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:text-yellow-500 dark:text-white dark:hover:bg-gray-700 dark:hover:text-yellow md:dark:hover:bg-transparent dark:border-gray-700">Contact
						Us</a></li>
			</ul>
		</div>
	</div>
</nav>

<!-- cart modal -->



<!-- Modal toggle -->
<!--
<button data-modal-target="static-modal" data-modal-toggle="static-modal" class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" type="button">
  Toggle modal
</button>
-->

<!-- Main modal -->
<div id="cart" data-modal-backdrop="static" tabindex="-1"
	aria-hidden="true"
	class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
	<div class="relative p-4 w-full max-w-2xl max-h-full">
		<!-- Modal content -->
		<div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
			<!-- Modal header -->
			<div
				class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white">
					My Cart</h3>
				<button type="button"
					class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
					data-modal-hide="cart">
					<svg class="w-3 h-3" aria-hidden="true"
						xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                        <path stroke="currentColor"
							stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
							d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                    </svg>
					<span class="sr-only">Close modal</span>
				</button>
			</div>
			<!-- Modal body -->
			<div
				class="cart-body relative overflow-x-auto shadow-md sm:rounded-lg">

			</div>
			<!-- Modal footer -->
			<div
				class="flex items-center justify-end p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-gray-600">
				<button data-modal-hide="cart" type="button"
					class="py-2.5 px-5 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">Close</button>
				<button data-modal-hide="cart" type="button"
					class="checkout-btn text-white ms-3 bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800" onClick="gotoCheckout()">Checkout</button>

			</div>
		</div>
	</div>
</div>


<!-- for toast message -->
<div id="snackbar"></div>
