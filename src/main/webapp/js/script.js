// add to cart

function add_to_cart(pid, pname, price) {
	let cart = localStorage.getItem("cart");
	if (cart == null) {
		// no cart yet
		let products = [];
		let product = {
			productId: pid,
			productName: pname,
			productQuantity: 1,
			productPrice: price
		};
		products.push(product);
		localStorage.setItem("cart", JSON.stringify(products));
		console.log("Product is added for the first time");
		showToastMessage("Product is added");
	}
	else {
		// cart is already present
		let pcart = JSON.parse(cart);

		let oldProduct = pcart.find((item) => item.productId == pid);
		console.log(oldProduct);
		if (oldProduct) {
			// we have to increase the quantity
			oldProduct.productQuantity = oldProduct.productQuantity + 1;
			pcart.map((item) => {
				if (item.productId === oldProduct.productId) {
					item.productQuantity = oldProduct.productQuantity;
				}
			})
			localStorage.setItem("cart", JSON.stringify(pcart));
			console.log("product quantity is increased");
			showToastMessage("Product's quantity is increaded");
		}
		else {
			// we have to add the product
			let product = {
				productId: pid,
				productName: pname,
				productQuantity: 1,
				productPrice: price
			};
			pcart.push(product);
			localStorage.setItem("cart", JSON.stringify(pcart));
			console.log("Product is added");
			showToastMessage("Product is added");
		}
	}
	updateCart();
}

// update cart

function updateCart() {
	let cartString = localStorage.getItem("cart");
	let cart = JSON.parse(cartString);
	if (cart == null || cart.length == 0) {
		console.log("Cart is empty!!");
		document.querySelector(".cart-items").innerText = "Cart(0)";
		let emtCart = document.querySelectorAll(".cart-body");
		let emtColor = document.querySelectorAll(".cart-body");
		for(let i = 0; i < emtCart.length; i++) {
			emtCart[i].innerHTML = `<h4 class="text-center text-xl">Your cart is empty!!</h4>`;
			emtColor[i].style.color = "yellow";
		}
		document.querySelector(".checkout-btn").disabled = true;
		document.querySelector(".checkout-btn").classList.add("checkout-disabled");
	}
	else {
		// something is in the cart
		console.log(cart);
		document.querySelector(".cart-items").innerText = `Cart(${cart.length})`;
		document.querySelector(".checkout-btn").disabled = false;
		document.querySelector(".checkout-btn").classList.remove("checkout-disabled");

		let table = `
			<table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
			<thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                    Product
                </th>
                <th scope="col" class="px-6 py-3">
                    Price
                </th>
                <th scope="col" class="px-6 py-3">
                    Qty
                </th>
                <th scope="col" class="px-6 py-3">
                    Total Price
                </th>
                <th scope="col" class="px-6 py-3">
                    Action
                </th>
            </tr>
        </thead>
		`;

		let totalPrice = 0;

		cart.map((item) => {
			table += `
				<tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                <td class="px-6 py-4 font-semibold text-gray-900 dark:text-white">
                    ${item.productName}
                </td>
                <td class="px-6 py-4 font-semibold text-gray-900 dark:text-white">
                	${item.productPrice}
                </td>
                
                <td class="qty px-6 py-4 font-semibold text-gray-900 dark:text-white">
                	${item.productQuantity}
                </td>
                <td class="px-6 py-4 font-semibold text-gray-900 dark:text-white">
                    ${item.productPrice * item.productQuantity}
                </td>
                <td class="px-6 py-4">
                    <button onClick='removeProduct(${item.productId})' class="font-medium text-red-600 dark:text-red-500 hover:underline">Remove</button>
                </td>
            </tr>
			`;
			totalPrice += item.productPrice * item.productQuantity;
		})

		table = table + `
		<tr class="px-6 py-4 font-semibold text-gray-900 dark:text-white">
			<td colspan="5" class="px-6 py-4 font-semibold text-gray-900 dark:text-yellow-200 text-right">Bill Amount : ${totalPrice}</td>
		</tr>
		</table>`;
		let nodeList = document.querySelectorAll(".cart-body");
		for (let i = 0; i < nodeList.length; i++) {
			nodeList[i].innerHTML = table;
		}
	}
}

// remove from cart

function removeProduct(pid) {
	let cart = JSON.parse(localStorage.getItem('cart'));
	let newCart = cart.filter((item) => item.productId != pid);

	localStorage.setItem('cart', JSON.stringify(newCart));
	console.log("Product is removed");

	updateCart();
}

// to load the updateCart --> we have to do this bcoz initally the cart is not loading by itself
document.addEventListener('DOMContentLoaded', updateCart);


// for toast/snackbar message
function showToastMessage(message) {
	var x = document.getElementById("snackbar");
	x.className = "show";
	x.innerText = message;
	setTimeout(function() { x.className = x.className.replace("show", ""); }, 3000);
}

function gotoCheckout() {
	window.location = "checkout.jsp";
}