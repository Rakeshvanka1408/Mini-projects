<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String registerError = (String) session.getAttribute("registerError");

if (registerError != null) {
    session.removeAttribute("registerError");
}

String registerSuccess = (String) session.getAttribute("registerSuccess");

if (registerSuccess != null) {
    session.removeAttribute("registerSuccess");
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
    content="width=device-width, initial-scale=1.0">

<title>Create Account | ELAMS</title>

<link rel="preconnect"
    href="https://fonts.googleapis.com">

<link rel="preconnect"
    href="https://fonts.gstatic.com"
    crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
    rel="stylesheet">

<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

body {

    min-height: 100vh;

    display: flex;

    align-items: center;

    justify-content: center;

    background:
        linear-gradient(
            135deg,
            #eff6ff,
            #f8fafc
        );

    padding: 20px;
}


/* =========================================
   REGISTER CONTAINER
========================================= */

.register-container {

    width: 100%;

    max-width: 1050px;

    min-height: 620px;

    display: grid;

    grid-template-columns: 1fr 1fr;

    background: white;

    border-radius: 22px;

    overflow: hidden;

    box-shadow:
        0 20px 50px
        rgba(15, 23, 42, 0.12);
}


/* =========================================
   LEFT SIDE
========================================= */

.register-left {

    position: relative;

    padding: 55px;

    display: flex;

    flex-direction: column;

    justify-content: center;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #0ea5e9
        );

    color: white;

    overflow: hidden;
}


.register-left::before {

    content: "";

    position: absolute;

    width: 300px;

    height: 300px;

    border-radius: 50%;

    background:
        rgba(255, 255, 255, 0.08);

    top: -100px;

    right: -100px;
}


.register-left::after {

    content: "";

    position: absolute;

    width: 250px;

    height: 250px;

    border-radius: 50%;

    background:
        rgba(255, 255, 255, 0.06);

    bottom: -100px;

    left: -80px;
}


.brand {

    position: relative;

    z-index: 2;

    display: flex;

    align-items: center;

    gap: 14px;

    margin-bottom: 45px;
}


.brand-icon {

    width: 52px;

    height: 52px;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 14px;

    background:
        rgba(255, 255, 255, 0.18);

    font-size: 23px;
}


.brand h1 {

    font-size: 24px;

    font-weight: 700;
}


.brand p {

    font-size: 11px;

    opacity: 0.85;

    margin-top: 2px;
}


.register-left-content {

    position: relative;

    z-index: 2;
}


.register-left h2 {

    font-size: 34px;

    line-height: 1.3;

    font-weight: 600;

    margin-bottom: 18px;
}


.register-left-content > p {

    font-size: 14px;

    line-height: 1.8;

    opacity: 0.9;

    max-width: 420px;
}


.features {

    margin-top: 35px;

    display: flex;

    flex-direction: column;

    gap: 16px;
}


.feature {

    display: flex;

    align-items: center;

    gap: 12px;

    font-size: 13px;
}


.feature-icon {

    width: 32px;

    height: 32px;

    border-radius: 8px;

    background:
        rgba(255, 255, 255, 0.15);

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 13px;
}


/* =========================================
   RIGHT SIDE
========================================= */

.register-right {

    padding: 45px 55px;

    display: flex;

    align-items: center;

    justify-content: center;
}


.register-form-container {

    width: 100%;

    max-width: 390px;
}


.register-header {

    margin-bottom: 25px;
}


.register-header h2 {

    font-size: 27px;

    color: #111827;

    font-weight: 600;

    margin-bottom: 7px;
}


.register-header p {

    color: #64748b;

    font-size: 13px;
}


/* =========================================
   ALERTS
========================================= */

.alert {

    display: flex;

    align-items: center;

    gap: 10px;

    padding: 12px 14px;

    border-radius: 9px;

    margin-bottom: 18px;

    font-size: 12px;

    font-weight: 500;
}


.alert-error {

    background: #fef2f2;

    color: #b91c1c;

    border:
        1px solid #fecaca;
}


.alert-success {

    background: #ecfdf5;

    color: #047857;

    border:
        1px solid #a7f3d0;
}


/* =========================================
   FORM
========================================= */

.form-group {

    margin-bottom: 17px;
}


.form-group label {

    display: block;

    color: #374151;

    font-size: 12px;

    font-weight: 600;

    margin-bottom: 7px;
}


.input-wrapper {

    position: relative;
}


.input-wrapper > i {

    position: absolute;

    left: 15px;

    top: 50%;

    transform:
        translateY(-50%);

    color: #94a3b8;

    font-size: 14px;

    pointer-events: none;
}


.form-control {

    width: 100%;

    height: 46px;

    border:
        1px solid #dbe3ec;

    border-radius: 10px;

    padding:
        0 45px 0 42px;

    background: #f8fafc;

    color: #1e293b;

    font-size: 13px;

    outline: none;

    transition:
        all 0.2s ease;
}


.form-control:focus {

    background: white;

    border-color: #2563eb;

    box-shadow:
        0 0 0 3px
        rgba(37, 99, 235, 0.08);
}


/* =========================================
   PASSWORD TOGGLE
========================================= */

.password-toggle {

    position: absolute;

    right: 15px;

    top: 50%;

    transform:
        translateY(-50%);

    border: none;

    background: none;

    color: #94a3b8;

    cursor: pointer;

    font-size: 14px;
}


.password-toggle:hover {

    color: #2563eb;
}


/* =========================================
   ROLE
========================================= */

.role-wrapper {

    position: relative;
}


.role-wrapper select {

    width: 100%;

    height: 46px;

    border:
        1px solid #dbe3ec;

    border-radius: 10px;

    padding:
        0 15px 0 42px;

    background: #f8fafc;

    color: #1e293b;

    font-size: 13px;

    outline: none;

    cursor: pointer;
}


.role-wrapper select:focus {

    background: white;

    border-color: #2563eb;

    box-shadow:
        0 0 0 3px
        rgba(37, 99, 235, 0.08);
}


.role-wrapper > i {

    position: absolute;

    left: 15px;

    top: 50%;

    transform:
        translateY(-50%);

    color: #94a3b8;

    font-size: 14px;

    pointer-events: none;

    z-index: 2;
}


/* =========================================
   REGISTER BUTTON
========================================= */

.register-btn {

    width: 100%;

    height: 48px;

    border: none;

    border-radius: 10px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #1d4ed8
        );

    color: white;

    font-size: 13px;

    font-weight: 600;

    cursor: pointer;

    display: flex;

    align-items: center;

    justify-content: center;

    gap: 9px;

    margin-top: 8px;

    box-shadow:
        0 7px 16px
        rgba(37, 99, 235, 0.18);

    transition:
        all 0.25s ease;
}


.register-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 10px 22px
        rgba(37, 99, 235, 0.25);
}


.register-btn:active {

    transform:
        translateY(0);
}


/* =========================================
   FOOTER
========================================= */

.register-footer {

    margin-top: 20px;

    text-align: center;

    color: #94a3b8;

    font-size: 11px;

    line-height: 1.7;
}


.register-footer a {

    color: #2563eb;

    text-decoration: none;

    font-weight: 600;
}


.register-footer a:hover {

    text-decoration: underline;
}


/* =========================================
   SECURITY
========================================= */

.security-info {

    display: flex;

    align-items: center;

    justify-content: center;

    gap: 7px;

    margin-top: 15px;

    color: #94a3b8;

    font-size: 10px;
}


.security-info i {

    color: #22c55e;
}


/* =========================================
   RESPONSIVE
========================================= */

@media (max-width: 850px) {

    .register-container {

        grid-template-columns: 1fr;

        max-width: 500px;
    }


    .register-left {

        padding: 35px;

        min-height: 300px;
    }


    .register-left h2 {

        font-size: 27px;
    }


    .features {

        display: none;
    }


    .brand {

        margin-bottom: 25px;
    }


    .register-right {

        padding: 40px 30px;
    }

}


@media (max-width: 500px) {

    body {

        padding: 12px;
    }


    .register-left {

        padding: 30px 25px;
    }


    .register-right {

        padding: 35px 22px;
    }


    .register-left h2 {

        font-size: 24px;
    }


    .register-header h2 {

        font-size: 23px;
    }

}

</style>

</head>


<body>


<div class="register-container">


<!-- =========================================
     LEFT SIDE
========================================= -->

<div class="register-left">


    <div class="brand">

        <div class="brand-icon">

            <i class="fa-solid fa-users-gear"></i>

        </div>


        <div>

            <h1>ELAMS</h1>

            <p>
                Employee Leave & Attendance
                Management System
            </p>

        </div>

    </div>


    <div class="register-left-content">


        <h2>
            Create Your Account
        </h2>


        <p>
            Register for an ELAMS account to manage
            employee activities, attendance, leave
            requests and assigned tasks.
        </p>


        <div class="features">


            <div class="feature">

                <div class="feature-icon">

                    <i class="fa-solid fa-user-check"></i>

                </div>

                <span>
                    Create your ELAMS account
                </span>

            </div>


            <div class="feature">

                <div class="feature-icon">

                    <i class="fa-solid fa-calendar-check"></i>

                </div>

                <span>
                    Manage attendance and leave
                </span>

            </div>


            <div class="feature">

                <div class="feature-icon">

                    <i class="fa-solid fa-list-check"></i>

                </div>

                <span>
                    Track your assigned tasks
                </span>

            </div>


        </div>


    </div>


</div>


<!-- =========================================
     RIGHT SIDE
========================================= -->

<div class="register-right">


<div class="register-form-container">


    <div class="register-header">

        <h2>
            Create Account
        </h2>

        <p>
            Enter your details to create your ELAMS account
        </p>

    </div>


    <!-- ERROR MESSAGE -->

    <% if (registerError != null) { %>

        <div class="alert alert-error">

            <i class="fa-solid fa-circle-exclamation"></i>

            <span>
                <%= registerError %>
            </span>

        </div>

    <% } %>


    <!-- SUCCESS MESSAGE -->

    <% if (registerSuccess != null) { %>

        <div class="alert alert-success">

            <i class="fa-solid fa-circle-check"></i>

            <span>
                <%= registerSuccess %>
            </span>

        </div>

    <% } %>


    <!-- =========================================
         REGISTRATION FORM

         Change "register" if your servlet
         mapping is different.
    ========================================== -->

    <form
        action="register"
        method="post">


        <!-- NAME -->

        <div class="form-group">

            <label for="name">
                Full Name
            </label>


            <div class="input-wrapper">

                <i class="fa-solid fa-user"></i>

                <input
                    type="text"
                    id="name"
                    name="name"
                    class="form-control"
                    placeholder="Enter your full name"
                    autocomplete="name"
                    required>

            </div>

        </div>


        <!-- EMAIL -->

        <div class="form-group">

            <label for="email">
                Email Address
            </label>


            <div class="input-wrapper">

                <i class="fa-solid fa-envelope"></i>

                <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-control"
                    placeholder="Enter your email address"
                    autocomplete="email"
                    required>

            </div>

        </div>


        <!-- PASSWORD -->

        <div class="form-group">

            <label for="password">
                Password
            </label>


            <div class="input-wrapper">

                <i class="fa-solid fa-lock"></i>


                <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-control"
                    placeholder="Create a password"
                    autocomplete="new-password"
                    minlength="6"
                    required>


                <button
                    type="button"
                    class="password-toggle"
                    onclick="togglePassword('password', 'passwordIcon')"
                    aria-label="Show or hide password">

                    <i
                        id="passwordIcon"
                        class="fa-solid fa-eye">
                    </i>

                </button>

            </div>

        </div>


        <!-- CONFIRM PASSWORD -->

        <div class="form-group">

            <label for="confirmPassword">
                Confirm Password
            </label>


            <div class="input-wrapper">

                <i class="fa-solid fa-lock"></i>


                <input
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    class="form-control"
                    placeholder="Confirm your password"
                    autocomplete="new-password"
                    minlength="6"
                    required>


                <button
                    type="button"
                    class="password-toggle"
                    onclick="togglePassword('confirmPassword', 'confirmPasswordIcon')"
                    aria-label="Show or hide password">

                    <i
                        id="confirmPasswordIcon"
                        class="fa-solid fa-eye">
                    </i>

                </button>

            </div>

        </div>


        <!-- ROLE -->

        <div class="form-group">

            <label for="role">
                Account Role
            </label>


            <div class="role-wrapper">

                <i class="fa-solid fa-user-shield"></i>


                <select
                    id="role"
                    name="role"
                    required>

                    <option value="">
                        Select your role
                    </option>

                    <option value="EMPLOYEE">
                        Employee
                    </option>

                    <option value="MANAGER">
                        Manager
                    </option>

                </select>

            </div>

        </div>


        <!-- REGISTER BUTTON -->

        <button
            type="submit"
            class="register-btn">

            <i class="fa-solid fa-user-plus"></i>

            Create Account

        </button>


    </form>


    <!-- FOOTER -->

    <div class="register-footer">

        <p>

            Already have an account?

            <a href="login.jsp">
                Sign In
            </a>

        </p>

    </div>


    <div class="security-info">

        <i class="fa-solid fa-shield-halved"></i>

        Secure ELAMS Authentication

    </div>


</div>


</div>


</div>


<script>

function togglePassword(inputId, iconId) {

    const passwordInput =
        document.getElementById(inputId);

    const passwordIcon =
        document.getElementById(iconId);


    if (passwordInput.type === "password") {

        passwordInput.type = "text";

        passwordIcon.classList.remove(
            "fa-eye"
        );

        passwordIcon.classList.add(
            "fa-eye-slash"
        );

    } else {

        passwordInput.type = "password";

        passwordIcon.classList.remove(
            "fa-eye-slash"
        );

        passwordIcon.classList.add(
            "fa-eye"
        );

    }

}

</script>


</body>

</html>