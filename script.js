// Function to handle form submissions
function handleFormSubmission(event) {
  event.preventDefault();

  // Get form data
  const formData = new FormData(event.target);
  const data = Object.fromEntries(formData.entries());

  // Simulate form submission (you can replace this with actual form submission logic)
  console.log("Form Data:", data);

  // Example: Display success message for login
  if (event.target.id === "login-form") {
    alert("Login successful!");
    // Redirect or handle login logic here
  }

  // Example: Display success message for registration
  if (event.target.id === "registration-form") {
    alert("Registration successful!");
    // Redirect or handle registration logic here
  }
}

// Attach event listeners to forms
document.addEventListener("DOMContentLoaded", () => {
  const loginForm = document.getElementById("login-form");
  const registrationForm = document.getElementById("registration-form");

  if (loginForm) {
    loginForm.addEventListener("submit", handleFormSubmission);
  }

  if (registrationForm) {
    registrationForm.addEventListener("submit", handleFormSubmission);
  }
});
