'use strict';

let cart = JSON.parse(localStorage.getItem('cart')) || [];

const cartDOM = document.querySelector('.cart');
const addToCartButtonsDOM = document.querySelectorAll('[data-action="ADD_TO_CART"]');
const id_package = document.querySelector('#id_package').value;
	$.ajax({
		url:"product/get_init_recipe.php",
		method:"POST",
		dataType:"json",
		data: {id:id_package},
		success:function(datas){
			if(datas.length > 0){
				initCart(datas);
			}else{
				initCart(cart);
			}
		}
	});

function initCart(cart){

if (cart.length > 0) {
	cart.forEach(product => {
		insertItemToDOM(product);
		countCartTotal();

		addToCartButtonsDOM.forEach(addToCartButtonDOM => {
			const productDOM = addToCartButtonDOM.parentNode;

			if (productDOM.querySelector('.product__name').innerText === product.name) {
				handleActionButtons(addToCartButtonDOM, product);
			}
		});
	});
}

addToCartButtonsDOM.forEach(addToCartButtonDOM => {
	addToCartButtonDOM.addEventListener('click', () => {
		const productDOM = addToCartButtonDOM.parentNode;
		const product = {
			id: productDOM.querySelector('.product__id').value,
			image: productDOM.querySelector('.product__image').getAttribute('src'),
			name: productDOM.querySelector('.product__name').innerText,
			price: productDOM.querySelector('.product__price').innerText,
			quantity: 1
		};

		const isInCart = cart.filter(cartItem => cartItem.id === product.id).length > 0;
		
		if (!isInCart) {

			insertItemToDOM(product);
			

			cart.push(product);
			saveCart();
			handleActionButtons(addToCartButtonDOM, product);
		}
	});
});


// Function to Insert Item to DOM
function insertItemToDOM(product) {
	cartDOM.insertAdjacentHTML(
		'beforeend',
		`
	<div class="cart__item">
		<input type="hidden" class="product__id" value="${product.id}" />
      <img class="cart__item__image" src="${product.image}" alt="${product.name}" >
      <h3 class="cart__item__name">${product.name}</h3>
      <h3 class="cart__item__price">${product.price}</h3>
      <button class="btn btn--primary btn--small${product.quantity === 1 ? ' btn--danger' : ''}" data-action="DECREASE_ITEM">&minus;</button>
      <h3 class="cart__item__quantity">${product.quantity}</h3>
      <button class="btn btn--primary btn--small" data-action="INCREASE_ITEM">&plus;</button>
      <button class="btn btn--danger btn--small" data-action="REMOVE_ITEM">&times;</button>
    </div>
  `
	);
	addCartFooter();
}

// Funtion to Handle Buttons in the cart
function handleActionButtons(addToCartButtonDOM, product) {
	addToCartButtonDOM.innerText = 'In Cart';
	addToCartButtonDOM.disabled = true;

	const cartItemsDOM = cartDOM.querySelectorAll('.cart__item');
	cartItemsDOM.forEach(cartItemDOM => {
		if (cartItemDOM.querySelector('.cart__item__name').innerText === product.name) {
			cartItemDOM.querySelector('[data-action="INCREASE_ITEM"]').addEventListener('click', () => increaseItem(product, cartItemDOM));
			cartItemDOM
				.querySelector('[data-action="DECREASE_ITEM"]')
				.addEventListener('click', () => decreaseItem(product, cartItemDOM, addToCartButtonDOM));
			cartItemDOM.querySelector('[data-action="REMOVE_ITEM"]').addEventListener('click', () => removeItem(product, cartItemDOM, addToCartButtonDOM));
		}
	});
}

// Function to increase item in cart
function increaseItem(product, cartItemDOM) {
	cart.forEach(cartItem => {
		if (cartItem.name === product.name) {
			cartItemDOM.querySelector('.cart__item__quantity').innerText = ++cartItem.quantity;
			cartItemDOM.querySelector('[data-action="DECREASE_ITEM"]').classList.remove('btn--danger');
			saveCart();
		}
	});
}

// Function to decrease item in cart
function decreaseItem(product, cartItemDOM, addToCartButtonDOM) {
	cart.forEach(cartItem => {
		if (cartItem.name === product.name) {
			if (cartItem.quantity > 1) {
				cartItemDOM.querySelector('.cart__item__quantity').innerText = --cartItem.quantity;
				saveCart();
			} else {
				removeItem(product, cartItemDOM, addToCartButtonDOM);
			}

			if (cartItem.quantity === 1) {
				cartItemDOM.querySelector('[data-action="DECREASE_ITEM"]').classList.add('btn--danger');
			}
		}
	});
}

// Function to remove item from cart
function removeItem(product, cartItemDOM, addToCartButtonDOM) {
	$.ajax({
		url:"donation_package/delete_product.php",
		method:"POST",
		dataType:"json",
		data: {id_product:product.id, id_package:id_package},
		success:function(datas){
		}
	});
	cartItemDOM.classList.add('cart__item--removed');
	setTimeout(() => cartItemDOM.remove(), 250);
	cart = cart.filter(cartItem => cartItem.name !== product.name);
	saveCart();
	addToCartButtonDOM.innerText = 'Add To Cart';
	addToCartButtonDOM.disabled = false;
	if (cart.length < 1) {
		document.querySelector('.cart-footer').remove();
	}
}

// Function to add cart footer
function addCartFooter() {
	if (document.querySelector('.cart-footer') === null) {
		cartDOM.insertAdjacentHTML(
			'afterend',
			`
      <div class="cart-footer">
        <button class="btn btn--danger" data-action="CLEAR_CART">Bersihkan</button>
        <button class="btn btn--primary" data-action="CHECKOUT">Pay</button>
      </div>
    `
		);

		document.querySelector('[data-action="CLEAR_CART"]').addEventListener('click', () => clearCart());
		document.querySelector('[data-action="CHECKOUT"]').addEventListener('click', () => checkout());
	}
}

function clearCart() {
	document.querySelectorAll('.cart__item').forEach(cartItemDOM => {
		cartItemDOM.classList.add('cart__item--removed');
		setTimeout(() => cartItemDOM.remove(), 250);
	});

	cart = [];
	localStorage.removeItem('cart');
	countCartTotal();
	document.querySelector('.cart-footer').remove();

	addToCartButtonsDOM.forEach(addToCartButtonDOM => {
		addToCartButtonDOM.innerText = 'Add To Cart';
		addToCartButtonDOM.disabled = false;
	});

	$.ajax({
		url:"donation_package/clear_package.php",
		method:"POST",
		dataType:"json",
		data: {id:id_package},
		success:function(datas){
			
		}
	});
}
function checkout() {
	$.ajax({
		url:"donation_package/save_selected_products.php",
		method:"POST",
		dataType:"json",
		data: {id_package:id_package, cart:cart},
		success:function(datas){
			console.log("checkout : "+datas);
			if(datas > 0){
				document.location = `index.php?m=donation_package&s=upload&iddpck=${id_package}`;
			}
		}
	});
}

// Function to calculate total amount
function countCartTotal() {
	let cartTotal = 0;
	cart.forEach(cartItem => (cartTotal += cartItem.quantity * cartItem.price));
	document.querySelector('[data-action="CHECKOUT"]').innerText = `Simpan Rp. ${cartTotal}`;
}

// Function to save cart on changes
function saveCart() {
	localStorage.setItem('cart', JSON.stringify(cart));
	countCartTotal();
}

}
