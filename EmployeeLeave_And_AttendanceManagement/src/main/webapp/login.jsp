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
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.login-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
	padding: 45px 40px;
	width: 100%;
	max-width: 420px;
	animation: slideIn 0.5s ease-out;
}

@
keyframes slideIn {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.logo-section {
	text-align: center;
	margin-bottom: 30px;
}

.logo-section h1 {
	color: #667eea;
	font-size: 36px;
	font-weight: 700;
	margin-bottom: 5px;
	letter-spacing: 1px;
}

.logo-section p {
	color: #7f8c8d;
	font-size: 13px;
	font-weight: 500;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.divider {
	height: 2px;
	background: linear-gradient(90deg, transparent, #667eea, transparent);
	margin: 25px 0;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 8px;
	color: #2c3e50;
	font-weight: 600;
	font-size: 14px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

input[type="email"], input[type="password"], input[type="text"] {
	width: 100%;
	padding: 14px 16px;
	border: 2px solid #ecf0f1;
	border-radius: 6px;
	font-size: 14px;
	transition: all 0.3s ease;
	background: #f8f9fa;
	font-family: 'Segoe UI', sans-serif;
}

input[type="email"]:focus, input[type="password"]:focus, input[type="text"]:focus
	{
	outline: none;
	border-color: #667eea;
	background: white;
	box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
}

input[type="email"]:invalid:not(:placeholder-shown), input[type="password"]:invalid:not(:placeholder-shown)
	{
	border-color: #e74c3c;
}

.password-container {
	position: relative;
}

.toggle-password {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
	color: #7f8c8d;
	font-size: 18px;
	user-select: none;
	border: none;
	background: none;
}

.toggle-password:hover {
	color: #667eea;
}

.alert {
	padding: 14px 16px;
	border-radius: 6px;
	margin-bottom: 20px;
	font-size: 14px;
	font-weight: 500;
	animation: slideIn 0.3s ease-out;
}

.alert-error {
	background: #fee;
	color: #c33;
	border-left: 4px solid #e74c3c;
	display: flex;
	align-items: center;
	gap: 10px;
}

.alert-error::before {
	content: "⚠";
	font-size: 18px;
}

.alert-success {
	background: #efe;
	color: #3c3;
	border-left: 4px solid #27ae60;
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
	cursor: pointer;
	width: 18px;
	height: 18px;
	accent-color: #667eea;
}

.checkbox-wrapper label {
	margin: 0;
	text-transform: none;
	font-weight: normal;
	cursor: pointer;
	color: #555;
}

.forgot-password {
	color: #667eea;
	text-decoration: none;
	font-weight: 600;
	transition: color 0.3s;
}

.forgot-password:hover {
	color: #764ba2;
	text-decoration: underline;
}

.login-btn, .register-btn {
	width: 100%;
	padding: 14px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 1px;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.login-btn:hover, .register-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
}

.login-btn:active, .register-btn:active {
	transform: translateY(0);
}

.login-btn:disabled, .register-btn:disabled {
	opacity: 0.6;
	cursor: not-allowed;
}

.signup-section {
	text-align: center;
	margin-top: 20px;
	padding-top: 20px;
	border-top: 1px solid #ecf0f1;
	font-size: 13px;
	color: #7f8c8d;
}

.signup-section a {
	color: #667eea;
	text-decoration: none;
	font-weight: 600;
	transition: color 0.3s;
	cursor: pointer;
}

.signup-section a:hover {
	color: #764ba2;
	text-decoration: underline;
}

.security-notice {
	text-align: center;
	margin-top: 15px;
	font-size: 11px;
	color: #95a5a6;
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
	border-radius: 4px;
	font-size: 12px;
	font-weight: 500;
}

.password-strength.weak {
	background: #fee;
	color: #c33;
}

.password-strength.medium {
	background: #ffd;
	color: #993;
}

.password-strength.strong {
	background: #efe;
	color: #3c3;
}

.toggle-form-btn {
	color: #667eea;
	cursor: pointer;
	font-weight: 600;
}

@media ( max-width : 480px) {
	.login-container {
		padding: 30px 20px;
	}
	.logo-section h1 {
		font-size: 28px;
	}
	.logo-section p {
		font-size: 11px;
	}
	.remember-section {
		flex-direction: column;
		align-items: flex-start;
		gap: 12px;
	}
}

/* Loading state */
.login-btn.loading, .register-btn.loading {
	pointer-events: none;
}

.login-btn.loading::after, .register-btn.loading::after {
	content: " ⏳";
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

				<!-- Full Name Field -->
				<div class="form-group">
					<label for="fullName">Full Name</label> <input type="text"
						id="fullName" name="fullName" placeholder="Enter your full name"
						required autocomplete="name" aria-label="Full Name">
				</div>

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