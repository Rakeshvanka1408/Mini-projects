<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/*
 * ============================================
 * CHECK IF USER IS ALREADY LOGGED IN
 * ============================================
 */

String role = (String) session.getAttribute("role");

if (role != null) {

    if ("ADMIN".equalsIgnoreCase(role)) {

        response.sendRedirect("adminHome.jsp");
        return;

    } else if ("MANAGER".equalsIgnoreCase(role)) {

        response.sendRedirect("managerHome.jsp");
        return;

    } else if ("EMPLOYEE".equalsIgnoreCase(role)) {

        response.sendRedirect("employeeHome.jsp");
        return;
    }
}


/*
 * ============================================
 * READ LOGIN ERROR MESSAGE
 * ============================================
 */

String loginError =
        (String) session.getAttribute("loginError");

if (loginError != null) {

    session.removeAttribute("loginError");
}


/*
 * ============================================
 * READ LOGOUT MESSAGE
 * ============================================
 */

String logoutMessage =
        (String) session.getAttribute("logoutMessage");

if (logoutMessage != null) {

    session.removeAttribute("logoutMessage");
}


/*
 * ============================================
 * READ REGISTRATION SUCCESS MESSAGE
 * ============================================
 */

String registerSuccess =
        (String) session.getAttribute("registerSuccess");

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

<title>ELAMS Login</title>


<!-- =========================================
     GOOGLE FONT
========================================= -->

<link rel="preconnect"
    href="https://fonts.googleapis.com">

<link rel="preconnect"
    href="https://fonts.gstatic.com"
    crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
    rel="stylesheet">


<!-- =========================================
     FONT AWESOME
========================================= -->

<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


<style>

/* =========================================
   RESET
========================================= */

* {

    margin: 0;

    padding: 0;

    box-sizing: border-box;

    font-family: 'Poppins', sans-serif;

}


/* =========================================
   BODY
========================================= */

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
   MAIN LOGIN CONTAINER
========================================= */

.login-container {

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

.login-left {

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


/* Decorative Circle - Top Right */

.login-left::before {

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


/* Decorative Circle - Bottom Left */

.login-left::after {

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


/* =========================================
   BRAND
========================================= */

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


/* =========================================
   LEFT CONTENT
========================================= */

.login-left-content {

    position: relative;

    z-index: 2;

}


.login-left h2 {

    font-size: 34px;

    line-height: 1.3;

    font-weight: 600;

    margin-bottom: 18px;

}


.login-left-content > p {

    font-size: 14px;

    line-height: 1.8;

    opacity: 0.9;

    max-width: 420px;

}


/* =========================================
   FEATURES
========================================= */

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

.login-right {

    padding: 45px 55px;

    display: flex;

    align-items: center;

    justify-content: center;

}


.login-form-container {

    width: 100%;

    max-width: 390px;

}


/* =========================================
   LOGIN HEADER
========================================= */

.login-header {

    margin-bottom: 25px;

}


.login-header h2 {

    font-size: 27px;

    color: #111827;

    font-weight: 600;

    margin-bottom: 7px;

}


.login-header p {

    color: #64748b;

    font-size: 13px;

}


/* =========================================
   ALERT MESSAGES
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
   FORM GROUP
========================================= */

.form-group {

    margin-bottom: 20px;

}


.form-group label {

    display: block;

    color: #374151;

    font-size: 12px;

    font-weight: 600;

    margin-bottom: 8px;

}


/* =========================================
   INPUT WRAPPER
========================================= */

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


/* =========================================
   INPUT
========================================= */

.form-control {

    width: 100%;

    height: 48px;

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
   LOGIN BUTTON
========================================= */

.login-btn {

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


.login-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 10px 22px
        rgba(37, 99, 235, 0.25);

}


.login-btn:active {

    transform:
        translateY(0);

}


/* =========================================
   REGISTER / CREATE ACCOUNT
========================================= */

.login-footer {

    margin-top: 25px;

    text-align: center;

    color: #94a3b8;

    font-size: 11px;

    line-height: 1.7;

}


.login-footer p {

    margin-bottom: 8px;

}


.login-footer a {

    color: #2563eb;

    text-decoration: none;

    font-weight: 600;

}


.login-footer a:hover {

    text-decoration: underline;

}


/* =========================================
   SECURITY INFO
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
   RESPONSIVE DESIGN
========================================= */

@media (max-width: 850px) {

    .login-container {

        grid-template-columns: 1fr;

        max-width: 500px;

    }


    .login-left {

        padding: 35px;

        min-height: 330px;

    }


    .login-left h2 {

        font-size: 27px;

    }


    .features {

        display: none;

    }


    .brand {

        margin-bottom: 25px;

    }


    .login-right {

        padding: 40px 30px;

    }

}


@media (max-width: 500px) {

    body {

        padding: 12px;

    }


    .login-left {

        padding: 30px 25px;

    }


    .login-right {

        padding: 35px 22px;

    }


    .login-left h2 {

        font-size: 24px;

    }


    .login-header h2 {

        font-size: 23px;

    }

}

</style>

</head>


<body>


<!-- =========================================
     MAIN LOGIN CONTAINER
========================================= -->

<div class="login-container">


    <!-- =====================================
         LEFT SIDE
    ====================================== -->

    <div class="login-left">


        <!-- BRAND -->

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


        <!-- LEFT CONTENT -->

        <div class="login-left-content">


            <h2>
                Welcome Back!
            </h2>


            <p>

                Sign in to access your ELAMS account
                and manage employee activities,
                attendance, leave requests and tasks.

            </p>


            <!-- FEATURES -->

            <div class="features">


                <!-- FEATURE 1 -->

                <div class="feature">


                    <div class="feature-icon">

                        <i class="fa-solid fa-calendar-check"></i>

                    </div>


                    <span>

                        Manage attendance and leave

                    </span>


                </div>


                <!-- FEATURE 2 -->

                <div class="feature">


                    <div class="feature-icon">

                        <i class="fa-solid fa-list-check"></i>

                    </div>


                    <span>

                        Track and manage assigned tasks

                    </span>


                </div>


                <!-- FEATURE 3 -->

                <div class="feature">


                    <div class="feature-icon">

                        <i class="fa-solid fa-chart-line"></i>

                    </div>


                    <span>

                        View reports and performance

                    </span>


                </div>


            </div>


        </div>


    </div>


    <!-- =====================================
         RIGHT SIDE
    ====================================== -->

    <div class="login-right">


        <div class="login-form-container">


            <!-- LOGIN HEADER -->

            <div class="login-header">


                <h2>
                    Sign In
                </h2>


                <p>
                    Enter your credentials to continue
                </p>


            </div>


            <!-- =================================
                 LOGIN ERROR MESSAGE
            ================================== -->

            <% if (loginError != null) { %>


                <div class="alert alert-error">


                    <i class="fa-solid fa-circle-exclamation"></i>


                    <span>

                        <%= loginError %>

                    </span>


                </div>


            <% } %>


            <!-- =================================
                 REGISTRATION SUCCESS MESSAGE
            ================================== -->

            <% if (registerSuccess != null) { %>


                <div class="alert alert-success">


                    <i class="fa-solid fa-circle-check"></i>


                    <span>

                        <%= registerSuccess %>

                    </span>


                </div>


            <% } %>


            <!-- =================================
                 LOGOUT SUCCESS MESSAGE
            ================================== -->

            <% if (logoutMessage != null) { %>


                <div class="alert alert-success">


                    <i class="fa-solid fa-circle-check"></i>


                    <span>

                        <%= logoutMessage %>

                    </span>


                </div>


            <% } %>


            <!-- =================================
                 LOGIN FORM
            ================================== -->

            <form
                action="login"
                method="post">


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
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>


                        <!-- PASSWORD SHOW/HIDE BUTTON -->

                        <button
                            type="button"
                            class="password-toggle"
                            onclick="togglePassword()"
                            aria-label="Show or hide password">


                            <i
                                id="passwordIcon"
                                class="fa-solid fa-eye">
                            </i>


                        </button>


                    </div>


                </div>


                <!-- LOGIN BUTTON -->

                <button
                    type="submit"
                    class="login-btn">


                    <i class="fa-solid fa-right-to-bracket"></i>


                    Sign In


                </button>


            </form>


            <!-- =================================
                 CREATE ACCOUNT OPTION
            ================================== -->

            <div class="login-footer">


                <p>

                    Don't have an account?

                    <a href="register.jsp">

                        Create Account

                    </a>

                </p>


                <p>

                    New users can register as an
                    Employee or Manager.

                </p>


            </div>


            <!-- =================================
                 SECURITY INFO
            ================================== -->

            <div class="security-info">


                <i class="fa-solid fa-shield-halved"></i>


                Secure ELAMS Authentication


            </div>


        </div>


    </div>


</div>


<!-- =========================================
     PASSWORD TOGGLE SCRIPT
========================================= -->

<script>

function togglePassword() {


    const passwordInput =
        document.getElementById("password");


    const passwordIcon =
        document.getElementById("passwordIcon");


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