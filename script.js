// Sample product data
const products = [
  {
    id: 1,
    name: "Ninja Sword",
    price: 199.99,
    image: "/api/placeholder/300/200?text=Ninja+Sword",
  },
  {
    id: 2,
    name: "Shuriken Set",
    price: 49.99,
    image: "/api/placeholder/300/200?text=Shuriken+Set",
  },
  {
    id: 3,
    name: "Stealth Suit",
    price: 299.99,
    image: "/api/placeholder/300/200?text=Stealth+Suit",
  },
  {
    id: 4,
    name: "Grappling Hook",
    price: 79.99,
    image: "/api/placeholder/300/200?text=Grappling+Hook",
  },
  {
    id: 5,
    name: "Smoke Bombs",
    price: 29.99,
    image: "/api/placeholder/300/200?text=Smoke+Bombs",
  },
  {
    id: 6,
    name: "Ninja Mask",
    price: 24.99,
    image: "/api/placeholder/300/200?text=Ninja+Mask",
  },
];

// Cart functionality
let cart = [];

function addToCart(productId) {
  const product = products.find((p) => p.id === productId);
  if (product) {
    cart.push(product);
    updateCartCount();
    alert(`${product.name} added to cart!`);
  }
}

function updateCartCount() {
  const cartCount = document.getElementById("cartCount");
  cartCount.textContent = cart.length;
}

// Display featured products on the homepage
function displayFeaturedProducts() {
  const featuredProductGrid = document.getElementById("featured-product-grid");
  if (featuredProductGrid) {
    const featuredProducts = products.slice(0, 4); // Display first 4 products
    featuredProducts.forEach((product) => {
      const productCard = createProductCard(product);
      featuredProductGrid.appendChild(productCard);
    });
  }
}

// Create a product card element
function createProductCard(product) {
  const card = document.createElement("div");
  card.className = "product-card";
  card.innerHTML = `
        <img src="${product.image}" alt="${product.name}">
        <div class="product-info">
            <h3>${product.name}</h3>
            <p>$${product.price.toFixed(2)}</p>
            <button class="btn" onclick="addToCart(${
              product.id
            })">Add to Cart</button>
        </div>
    `;
  return card;
}

// Initialize the page
function init() {
  displayFeaturedProducts();
  updateCartCount();
}

// Run initialization when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", init);

// Login form submission (for demo purposes)
const loginForm = document.getElementById("loginForm");
if (loginForm) {
  loginForm.addEventListener("submit", function (e) {
    e.preventDefault();
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    console.log(`Login attempt: ${email}`);
    alert("Login successful!");
    window.location.href = "index.html";
  });
}

// Registration form submission (for demo purposes)
const registerForm = document.getElementById("registerForm");
if (registerForm) {
  registerForm.addEventListener("submit", function (e) {
    e.preventDefault();
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    console.log(`Registration: ${name}, ${email}`);
    alert("Registration successful! Please log in.");
    window.location.href = "login.html";
  });
}
