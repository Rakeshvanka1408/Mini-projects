<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ELAMS Login - Employee Leave & Attendance Management
	System</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.login-container {
	width: 100%;
	max-width: 430px;
	padding: 45px 40px;
	border-radius: 20px;
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(15px);
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
	animation: fadeIn 0.6s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-25px) scale(0.96);
}

to {
	opacity: 1;
	transform: translateY(0) scale(1);
}

}
.logo-section {
	text-align: center;
	margin-bottom: 30px;
}

.logo-section h1 {
	color: #0f4c81;
	font-size: 42px;
	font-weight: 800;
	letter-spacing: 2px;
}

.logo-section p {
	color: #666;
	font-size: 13px;
	margin-top: 8px;
	letter-spacing: 1px;
}

.divider {
	height: 2px;
	background: linear-gradient(to right, transparent, #00b4d8, transparent);
	margin: 25px 0;
}

.form-group {
	margin-bottom: 22px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-size: 13px;
	font-weight: 700;
	color: #2d3436;
	text-transform: uppercase;
}

input[type="email"], input[type="password"], input[type="text"] {
	width: 100%;
	padding: 15px 18px;
	border: 2px solid #dfe6e9;
	border-radius: 12px;
	font-size: 14px;
	background: #f8fafc;
	transition: all .3s ease;
}

input[type="email"]:focus, input[type="password"]:focus, input[type="text"]:focus
	{
	outline: none;
	border-color: #00b4d8;
	background: white;
	box-shadow: 0 0 0 5px rgba(0, 180, 216, 0.15);
}

.password-container {
	position: relative;
}

.toggle-password {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	border: none;
	background: none;
	cursor: pointer;
	font-size: 18px;
	color: #777;
}

.toggle-password:hover {
	color: #00b4d8;
}

.alert {
	padding: 14px;
	border-radius: 10px;
	margin-bottom: 20px;
	font-size: 14px;
}

.alert-error {
	background: #ffe5e5;
	color: #d63031;
	border-left: 5px solid #d63031;
}

.alert-success {
	background: #e8fff0;
	color: #27ae60;
	border-left: 5px solid #27ae60;
}

.remember-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
	font-size: 13px;
}

.checkbox-wrapper {
	display: flex;
	align-items: center;
}

input[type="checkbox"] {
	margin-right: 6px;
	width: 17px;
	height: 17px;
	accent-color: #00b4d8;
}

.checkbox-wrapper label {
	text-transform: none;
	font-weight: 500;
	margin: 0;
}

.forgot-password {
	color: #0077b6;
	text-decoration: none;
	font-weight: 600;
}

.forgot-password:hover {
	text-decoration: underline;
}

.login-btn, .register-btn {
	width: 100%;
	padding: 15px;
	border: none;
	border-radius: 12px;
	background: linear-gradient(135deg, #00b4d8, #0077b6);
	color: white;
	font-size: 15px;
	font-weight: 700;
	cursor: pointer;
	transition: all .3s ease;
	box-shadow: 0 8px 20px rgba(0, 119, 182, 0.35);
}

.login-btn:hover, .register-btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 25px rgba(0, 119, 182, 0.45);
}

.login-btn:active, .register-btn:active {
	transform: translateY(0);
}

.signup-section {
	margin-top: 25px;
	padding-top: 20px;
	text-align: center;
	border-top: 1px solid #ecf0f1;
	color: #636e72;
	font-size: 13px;
}

.signup-section a {
	color: #0077b6;
	font-weight: 700;
	text-decoration: none;
}

.signup-section a:hover {
	text-decoration: underline;
}

.security-notice {
	margin-top: 18px;
	text-align: center;
	font-size: 11px;
	color: #7f8c8d;
}

.form-container {
	display: none;
}

.form-container.active {
	display: block;
}

.password-strength {
	margin-top: 8px;
	padding: 8px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 600;
}

.password-strength.weak {
	background: #ffe5e5;
	color: #d63031;
}

.password-strength.medium {
	background: #fff4d6;
	color: #e67e22;
}

.password-strength.strong {
	background: #e8fff0;
	color: #27ae60;
}

@media ( max-width :480px) {
	.login-container {
		padding: 30px 25px;
	}
	.logo-section h1 {
		font-size: 34px;
	}
	.remember-section {
		flex-direction: column;
		align-items: flex-start;
		gap: 10px;
	}
}
</style>

</head>

<body>

	<div class="login-container">
		<!-- Logo Section -->
		<div class="logo-section">
			<h1>ELAMS</h1>
			<p>Employee Leave & Attendance Management System</p>
		</div>

		<div class="divider"></div>

		<!-- Error Message Display -->
		<%
		String error = (String) request.getAttribute("errorMessage");
		String success = (String) request.getAttribute("successMessage");

		if (error != null && !error.isEmpty()) {
		%>
		<div class="alert alert-error">
			<%=error%>
		</div>
		<%
		}

		if (success != null && !success.isEmpty()) {
		%>
		<div class="alert alert-success">
			<%=success%>
		</div>
		<%
		}
		%>

		<!-- Login Form -->
		<div id="loginForm" class="form-container active">
			<form action="login" method="post"
				onsubmit="return validateLoginForm()" autocomplete="off">

				<!-- Email Field -->
				<div class="form-group">
					<label for="loginEmail">Email Address</label> <input type="email"
						id="loginEmail" name="email" placeholder="Enter your email"
						required autocomplete="email" aria-label="Email Address">
				</div>

				<!-- Password Field -->
				<div class="form-group">
					<label for="loginPassword">Password</label>
					<div class="password-container">
						<input type="password" id="loginPassword" name="password"
							placeholder="Enter your password" required
							autocomplete="current-password" aria-label="Password">
						<button type="button" class="toggle-password"
							id="toggleLoginPassword" aria-label="Toggle password visibility">👁️</button>
					</div>
				</div>

				<!-- Remember Me & Forgot Password -->
				<div class="remember-section">
					<div class="checkbox-wrapper">
						<input type="checkbox" id="rememberMe" name="rememberMe">
						<label for="rememberMe">Remember me</label>
					</div>
					<a href="forgotPassword.jsp" class="forgot-password">Forgot
						Password?</a>
				</div>

				<!-- Login Button -->
				<button type="submit" class="login-btn" id="loginBtn">Login</button>

			</form>

			<!-- Signup Link -->
			<div class="signup-section">
				Don't have an account? <a class="toggle-form-btn"
					onclick="toggleForms()">Sign Up</a>
			</div>
		</div>

		<!-- Registration Form -->
		<div id="registerForm" class="form-container">
			<form action="register" method="post"
				onsubmit="return validateRegisterForm()" autocomplete="off">

				<!-- Email Field -->
				<div class="form-group">
					<label for="registerEmail">Email Address</label> <input
						type="email" id="registerEmail" name="email"
						placeholder="Enter your email" required autocomplete="email"
						aria-label="Email Address">
				</div>

				<!-- Password Field -->
				<div class="form-group">
					<label for="registerPassword">Password</label>
					<div class="password-container">
						<input type="password" id="registerPassword" name="password"
							placeholder="Enter a strong password" required
							autocomplete="new-password" aria-label="Password"
							onchange="checkPasswordStrength()">
						<button type="button" class="toggle-password"
							id="toggleRegisterPassword"
							aria-label="Toggle password visibility">👁️</button>
					</div>
					<div id="passwordStrength"></div>
				</div>

				<!-- Confirm Password Field -->
				<div class="form-group">
					<label for="confirmPassword">Confirm Password</label>
					<div class="password-container">
						<input type="password" id="confirmPassword" name="confirmPassword"
							placeholder="Confirm your password" required
							autocomplete="new-password" aria-label="Confirm Password">
						<button type="button" class="toggle-password"
							id="toggleConfirmPassword"
							aria-label="Toggle password visibility">👁️</button>
					</div>
				</div>

				<!-- Register Button -->
				<button type="submit" class="register-btn" id="registerBtn">Sign
					Up</button>

			</form>

			<!-- Login Link -->
			<div class="signup-section">
				Already have an account? <a class="toggle-form-btn"
					onclick="toggleForms()">Login</a>
			</div>
		</div>

		<!-- Security Notice -->
		<div class="security-notice">🔒 Your login information is secure
			and encrypted</div>
	</div>

	<script>
		// Toggle between Login and Register forms
		function toggleForms() {
			document.getElementById('loginForm').classList.toggle('active');
			document.getElementById('registerForm').classList.toggle('active');
		}

		// Toggle Password Visibility - Login Form
		const toggleLoginPassword = document
				.getElementById('toggleLoginPassword');
		const loginPasswordInput = document.getElementById('loginPassword');

		toggleLoginPassword
				.addEventListener(
						'click',
						function(e) {
							e.preventDefault();
							const type = loginPasswordInput
									.getAttribute('type') === 'password' ? 'text'
									: 'password';
							loginPasswordInput.setAttribute('type', type);
							toggleLoginPassword.textContent = type === 'password' ? '👁️'
									: '👁️‍🗨️';
						});

		// Toggle Password Visibility - Register Form
		const toggleRegisterPassword = document
				.getElementById('toggleRegisterPassword');
		const registerPasswordInput = document
				.getElementById('registerPassword');

		toggleRegisterPassword
				.addEventListener(
						'click',
						function(e) {
							e.preventDefault();
							const type = registerPasswordInput
									.getAttribute('type') === 'password' ? 'text'
									: 'password';
							registerPasswordInput.setAttribute('type', type);
							toggleRegisterPassword.textContent = type === 'password' ? '👁️'
									: '👁️‍🗨️';
						});

		// Toggle Password Visibility - Confirm Password
		const toggleConfirmPassword = document
				.getElementById('toggleConfirmPassword');
		const confirmPasswordInput = document.getElementById('confirmPassword');

		toggleConfirmPassword
				.addEventListener(
						'click',
						function(e) {
							e.preventDefault();
							const type = confirmPasswordInput
									.getAttribute('type') === 'password' ? 'text'
									: 'password';
							confirmPasswordInput.setAttribute('type', type);
							toggleConfirmPassword.textContent = type === 'password' ? '👁️'
									: '👁️‍🗨️';
						});

		// Password Strength Checker
		function checkPasswordStrength() {
			const password = document.getElementById('registerPassword').value;
			const strengthDisplay = document.getElementById('passwordStrength');

			let strength = 'weak';
			let message = 'Weak';

			// Password strength criteria
			const hasUpperCase = /[A-Z]/.test(password);
			const hasLowerCase = /[a-z]/.test(password);
			const hasNumbers = /\d/.test(password);
			const hasSpecialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/
					.test(password);
			const isLengthValid = password.length >= 8;

			const strengthCount = [ hasUpperCase, hasLowerCase, hasNumbers,
					hasSpecialChar, isLengthValid ].filter(Boolean).length;

			if (strengthCount >= 4) {
				strength = 'strong';
				message = 'Strong ✓';
			} else if (strengthCount >= 3) {
				strength = 'medium';
				message = 'Medium';
			}

			strengthDisplay.className = 'password-strength ' + strength;
			strengthDisplay.textContent = message;
		}

		// Login Form Validation
		function validateLoginForm() {
			const email = document.getElementById('loginEmail').value.trim();
			const password = document.getElementById('loginPassword').value;

			// Validate email
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				alert('Please enter a valid email address');
				document.getElementById('loginEmail').focus();
				return false;
			}

			// Validate password
			if (password.length < 6) {
				alert('Password must be at least 6 characters');
				document.getElementById('loginPassword').focus();
				return false;
			}

			// Add loading state
			const loginBtn = document.getElementById('loginBtn');
			loginBtn.classList.add('loading');
			loginBtn.disabled = true;

			return true;
		}

		// Register Form Validation
		function validateRegisterForm() {
			const fullName = document.getElementById('fullName').value.trim();
			const email = document.getElementById('registerEmail').value.trim();
			const password = document.getElementById('registerPassword').value;
			const confirmPassword = document.getElementById('confirmPassword').value;

			// Validate full name
			if (fullName.length < 3) {
				alert('Full name must be at least 3 characters long');
				document.getElementById('fullName').focus();
				return false;
			}

			// Validate email
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				alert('Please enter a valid email address');
				document.getElementById('registerEmail').focus();
				return false;
			}

			// Validate password strength
			if (password.length < 8) {
				alert('Password must be at least 8 characters long');
				document.getElementById('registerPassword').focus();
				return false;
			}

			const hasUpperCase = /[A-Z]/.test(password);
			const hasLowerCase = /[a-z]/.test(password);
			const hasNumbers = /\d/.test(password);
			const hasSpecialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/
					.test(password);

			if (!hasUpperCase || !hasLowerCase || !hasNumbers
					|| !hasSpecialChar) {
				alert('Password must contain uppercase, lowercase, numbers, and special characters');
				document.getElementById('registerPassword').focus();
				return false;
			}

			// Validate password confirmation
			if (password !== confirmPassword) {
				alert('Passwords do not match');
				document.getElementById('confirmPassword').focus();
				return false;
			}

			// Add loading state
			const registerBtn = document.getElementById('registerBtn');
			registerBtn.classList.add('loading');
			registerBtn.disabled = true;

			return true;
		}

		// Real-time email validation
		document.getElementById('loginEmail').addEventListener('blur',
				function() {
					const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
					if (this.value && !emailRegex.test(this.value)) {
						this.style.borderColor = '#e74c3c';
					} else {
						this.style.borderColor = '#ecf0f1';
					}
				});

		document.getElementById('registerEmail').addEventListener('blur',
				function() {
					const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
					if (this.value && !emailRegex.test(this.value)) {
						this.style.borderColor = '#e74c3c';
					} else {
						this.style.borderColor = '#ecf0f1';
					}
				});

		// Focus styles
		document.getElementById('loginEmail').addEventListener('focus',
				function() {
					this.style.borderColor = '#667eea';
				});

		document.getElementById('loginPassword').addEventListener('focus',
				function() {
					this.style.borderColor = '#667eea';
				});

		document.getElementById('registerEmail').addEventListener('focus',
				function() {
					this.style.borderColor = '#667eea';
				});

		document.getElementById('registerPassword').addEventListener('focus',
				function() {
					this.style.borderColor = '#667eea';
				});

		document.getElementById('confirmPassword').addEventListener('focus',
				function() {
					this.style.borderColor = '#667eea';
				});

		// Prevent form submission on Enter key in toggle buttons
		document.getElementById('toggleLoginPassword').addEventListener(
				'keydown', function(e) {
					if (e.key === 'Enter') {
						e.preventDefault();
					}
				});

		document.getElementById('toggleRegisterPassword').addEventListener(
				'keydown', function(e) {
					if (e.key === 'Enter') {
						e.preventDefault();
					}
				});

		document.getElementById('toggleConfirmPassword').addEventListener(
				'keydown', function(e) {
					if (e.key === 'Enter') {
						e.preventDefault();
					}
				});

		// Remember me functionality
		window.addEventListener('load', function() {
			if (localStorage.getItem('rememberMe') === 'true') {
				document.getElementById('rememberMe').checked = true;
				document.getElementById('loginEmail').value = localStorage
						.getItem('email')
						|| '';
			}
		});

		document.getElementById('rememberMe').addEventListener(
				'change',
				function() {
					if (this.checked) {
						localStorage.setItem('rememberMe', 'true');
						localStorage.setItem('email', document
								.getElementById('loginEmail').value);
					} else {
						localStorage.removeItem('rememberMe');
						localStorage.removeItem('email');
					}
				});
	</script>

</body>
</html>