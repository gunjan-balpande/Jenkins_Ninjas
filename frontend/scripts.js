const backendBaseUrl = "http://54.177.225.81"; // Replace with your public EC2 instance IP or DNS

// Register form submission handler
document
  .getElementById("registerForm")
  ?.addEventListener("submit", function (event) {
    event.preventDefault();
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    fetch(`${backendBaseUrl}/register`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ username, password }),
    })
      .then((response) => response.text())
      .then((result) => {
        const registerMessage = document.getElementById("registerMessage");
        if (result.toLowerCase().includes("success")) {
          registerMessage.textContent = "Registration successful!";
          registerMessage.innerHTML += '<a href="login.html"> Login here</a>.';
          registerMessage.style.color = "green";
        } else {
          registerMessage.textContent = "Already Registered!";
          registerMessage.style.color = "black";
        }
        registerMessage.style.display = "block";
      })
      .catch((error) => {
        console.error("Error:", error);
        const registerMessage = document.getElementById("registerMessage");
        registerMessage.textContent = "An error occurred. Please try again.";
        registerMessage.style.color = "red";
        registerMessage.style.display = "block";
      });
  });

// Login form submission handler
document
  .getElementById("loginForm")
  ?.addEventListener("submit", function (event) {
    event.preventDefault();
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    fetch(`${backendBaseUrl}/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ username, password }),
    })
      .then((response) => response.text())
      .then((result) => {
        const loginMessage = document.getElementById("loginMessage");
        if (result.toLowerCase().includes("success")) {
          loginMessage.textContent = "Login successful!";
          loginMessage.style.color = "green";
          setTimeout(() => {
            localStorage.setItem("username", username);
            localStorage.setItem("isLoggedIn", "true");
            window.location.href = "index.html";
          }, 1000);
        } else {
          loginMessage.textContent = "Invalid credentials. Please try again.";
          loginMessage.style.color = "red";
        }
        loginMessage.style.display = "block";
      })
      .catch((error) => {
        console.error("Error:", error);
        const loginMessage = document.getElementById("loginMessage");
        loginMessage.textContent = "An error occurred. Please try again.";
        loginMessage.style.color = "red";
        loginMessage.style.display = "block";
      });
  });

// Dynamic navbar adjustment
function updateNavbar() {
  const username = localStorage.getItem("username");
  const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
  const navbar = document.getElementById("navbar");

  if (navbar) {
    if (isLoggedIn && username) {
      // User is logged in, show My Profile dropdown with Logout option
      navbar.innerHTML = `
        <a href="index.html">Home</a>
        <a href="#products">Products</a>
        <div class="dropdown">
          <button class="dropbtn">My Profile</button>
          <div class="dropdown-content">
            <a href="order.html">My Orders</a>
            <a href="#" id="logout-link">Logout</a>
          </div>
        </div>
      `;

      // Logout event
      document
        .getElementById("logout-link")
        ?.addEventListener("click", function () {
          localStorage.removeItem("username");
          localStorage.removeItem("isLoggedIn");
          window.location.href = "index.html";
        });
    } else {
      // User is not logged in, show login and register links
      navbar.innerHTML = `
        <a href="index.html">Home</a>
        <a href="#products">Products</a>
        <a href="login.html" id="login-link">Login</a>
        <a href="register.html" id="register-link">Register</a>
      `;
    }
  }
}

// Handle Add to Cart button click
function setupAddToCartButtons() {
  const addToCartButtons = document.querySelectorAll(".add-to-cart");

  addToCartButtons.forEach((button) => {
    button.addEventListener("click", function () {
      const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
      if (!isLoggedIn) {
        // If user is not logged in, redirect to login page
        alert("You must be logged in to add items to your cart.");
        window.location.href = "login.html";
        return;
      }

      const productName = this.getAttribute("data-product");
      const productPrice = this.getAttribute("data-price");
      const productImage = this.parentElement.querySelector("img").src;

      // Add product to cart array
      const product = {
        name: productName,
        price: productPrice,
        img: productImage,
      };

      // Get existing cart or create a new one
      const cart = JSON.parse(localStorage.getItem("cart")) || [];
      cart.push(product);

      // Update cart in localStorage
      localStorage.setItem("cart", JSON.stringify(cart));

      alert(`${productName} has been added to your cart.`);
    });
  });
}

// For order.html (cart page)
function displayCartItems() {
  if (document.getElementById("cartItems")) {
    const cartItemsContainer = document.getElementById("cartItems");
    const cart = JSON.parse(localStorage.getItem("cart")) || [];

    if (cart.length === 0) {
      cartItemsContainer.innerHTML = "<p>Your cart is empty</p>";
    } else {
      cartItemsContainer.innerHTML = ""; // Clear existing content
      cart.forEach((item, index) => {
        const productItem = document.createElement("div");
        productItem.classList.add("product-item");

        productItem.innerHTML = `
          <img src="${item.img}" alt="${item.name}" />
          <h3>${item.name}</h3>
          <p>₹${item.price}</p>
          <button class="remove-item" data-index="${index}">Remove</button>
        `;

        cartItemsContainer.appendChild(productItem);
      });

      // Add functionality to remove items
      document.querySelectorAll(".remove-item").forEach((button) => {
        button.addEventListener("click", function () {
          const index = this.getAttribute("data-index");
          cart.splice(index, 1); // Remove the item from cart array
          localStorage.setItem("cart", JSON.stringify(cart)); // Update localStorage
          displayCartItems(); // Refresh the cart display
        });
      });
    }
  }
}

// Handle welcome message for index.html
function displayWelcomeMessage() {
  if (document.getElementById("welcomeMessage")) {
    const username = localStorage.getItem("username");
    if (username) {
      const welcomeMessage = document.getElementById("welcomeMessage");
      welcomeMessage.textContent = `Welcome, ${username}`;
      welcomeMessage.style.fontSize = "30px";
    }
  }
}

// Initialize page
document.addEventListener("DOMContentLoaded", function () {
  updateNavbar();
  setupAddToCartButtons();
  displayCartItems();
  displayWelcomeMessage();
});
