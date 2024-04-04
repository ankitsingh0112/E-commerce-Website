<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.Entities.Product"%>
<%@page import="com.provider.FactoryProvider"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shoppee</title>

<script src="https://cdn.tailwindcss.com"></script>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />
	
	<link rel="stylesheet" href="custom.css" />

</head>
<body class="bg-white border-gray-200 dark:bg-slate-800">
	<%@include file="navbar.jsp"%>

	<!-- carousel -->


	<div id="default-carousel" class="relative w-full z-[-1]"
		data-carousel="slide">
		<!-- Carousel wrapper -->
		<div class="relative h-56 overflow-hidden rounded-lg md:h-96">
			<!-- Item 1 -->
			<div class="hidden duration-700 ease-in-out" data-carousel-item>
				<img src="./images/pic0.jpg"
					class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
					alt="...">
			</div>
			<!-- Item 2 -->
			<div class="hidden duration-700 ease-in-out" data-carousel-item>
				<img src="./images/pic1.jpg"
					class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
					alt="...">
			</div>
			<!-- Item 3 -->
			<div class="hidden duration-700 ease-in-out" data-carousel-item>
				<img src="./images/pic2.jpg"
					class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
					alt="...">
			</div>
			<!-- Item 4 -->
			<div class="hidden duration-700 ease-in-out" data-carousel-item>
				<img src="./images/pic0.jpg"
					class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
					alt="...">
			</div>
			<!-- Item 5 -->
			<div class="hidden duration-700 ease-in-out" data-carousel-item>
				<img src="./images/pic1.jpg"
					class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
					alt="...">
			</div>
		</div>
		<!-- Slider indicators -->
		<div
			class="absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3 rtl:space-x-reverse">
			<button type="button" class="w-3 h-3 rounded-full"
				aria-current="true" aria-label="Slide 1" data-carousel-slide-to="0"></button>
			<button type="button" class="w-3 h-3 rounded-full"
				aria-current="false" aria-label="Slide 2" data-carousel-slide-to="1"></button>
			<button type="button" class="w-3 h-3 rounded-full"
				aria-current="false" aria-label="Slide 3" data-carousel-slide-to="2"></button>
			<button type="button" class="w-3 h-3 rounded-full"
				aria-current="false" aria-label="Slide 4" data-carousel-slide-to="3"></button>
			<button type="button" class="w-3 h-3 rounded-full"
				aria-current="false" aria-label="Slide 5" data-carousel-slide-to="4"></button>
		</div>
		<!-- Slider controls -->
		<button type="button"
			class="absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
			data-carousel-prev>
			<span
				class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
				<svg class="w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180"
					aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
					viewBox="0 0 6 10">
                <path stroke="currentColor" stroke-linecap="round"
						stroke-linejoin="round" stroke-width="2" d="M5 1 1 5l4 4" />
            </svg> <span class="sr-only">Previous</span>
			</span>
		</button>
		<button type="button"
			class="absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
			data-carousel-next>
			<span
				class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
				<svg class="w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180"
					aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
					viewBox="0 0 6 10">
                <path stroke="currentColor" stroke-linecap="round"
						stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4" />
            </svg> <span class="sr-only">Next</span>
			</span>
		</button>
	</div>

	<!-- CAROUSEL END -->

	<div class="w-2/3 mx-auto">
		<%@include file="message.jsp"%>
	</div>

	<!-- PRODUCTS -->

	<%
	// yeha pr jo category h navbar ke dropdown se aa rha h
	String cat = request.getParameter("category"); // navbar me jo category ka link h waha se category ko as a id from the link get kr lenge
	Session s2 = FactoryProvider.getSessionFactory().openSession();
	List<Product> proList = null;
	Query q1 = null;
	if (cat == null || cat.trim().equals("all")) {
		q1 = s2.createQuery("FROM Product");
		proList = q1.getResultList();
	} else {
		q1 = s2.createQuery("FROM Product AS p WHERE p.category.categoryId =: id");
		q1.setParameter("id", cat);
		proList = q1.getResultList();
	}
	%>
	<div
		class="grid grid-cols-2 gap-8 p-2 mx-auto text-gray-900 sm:grid-cols-3 xl:grid-cols-4 dark:text-white sm:p-4">
		<%
		for (Product p : proList) {
			double discount = p.getpDiscount();
			double costPrice = p.getpPrice();
			double disAmount = ((discount / 100) * costPrice);
			int sellPrice = (int) (costPrice - disAmount);
		%>
		<!-- product image -->
		<div
			class="w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
			<a href="#"> <img class="p-4 rounded-t-lg max-h-64 mx-auto"
				src="./images/products/<%=p.getpPhoto()%>" alt="product image" />
			</a>
			<!-- title of the product -->
			<div class="px-5 pb-5">
				<a href="#">
					<h5
						class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white"><%=p.getpTitle()%></h5>
				</a>
				<!-- Rating -->
				<!-- 
				<div class="flex items-center mt-2.5 mb-5">
					<div class="flex items-center space-x-1 rtl:space-x-reverse">
						<svg class="w-4 h-4 text-yellow-300" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="currentColor"
							viewBox="0 0 22 20">
                    <path
								d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                </svg>
						<svg class="w-4 h-4 text-yellow-300" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="currentColor"
							viewBox="0 0 22 20">
                    <path
								d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                </svg>
						<svg class="w-4 h-4 text-yellow-300" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="currentColor"
							viewBox="0 0 22 20">
                    <path
								d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                </svg>
						<svg class="w-4 h-4 text-yellow-300" aria-hidden="true"
							xmlns="http://www.w3.org/2000/svg" fill="currentColor"
							viewBox="0 0 22 20">
                    <path
								d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                </svg>
						<svg class="w-4 h-4 text-gray-200 dark:text-gray-600"
							aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
							fill="currentColor" viewBox="0 0 22 20">
                    <path
								d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                </svg>
					</div>
					<span
						class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ms-3">4.0</span>
				</div>
				 -->

				<!-- pricing -->
				<div class="flex items-center justify-between flex-col">
					<div class="flex items-end justify-start gap-2 my-4 flex-wrap">
						<span class="text-2xl font-bold text-gray-900 dark:text-white">&#8377;<%=sellPrice%>.0
						</span> <span
							class="text-xl font-bold text-gray-900 dark:text-gray-600 line-through">&#8377;<%=costPrice%></span>
						<span class="text-lg font-bold text-green-900 dark:text-green-600"><%=discount%>%
							off</span>
					</div>
					<button class="w-full text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center"
						onClick="add_to_cart(<%=p.getPid()%>, '<%=p.getpTitle()%>', <%=sellPrice%>)">Add
						to cart</button>
				</div>
			</div>
		</div>
		<%
		}
		if (proList.size() == 0) {
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("message", "Sorry! No product is availabe in this category...");
		response.sendRedirect("index.jsp");
		return;
		}
		s.close();
		%>
	</div>



	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
	<script src="./js/script.js"></script>
</body>
</html>
