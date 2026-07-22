<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equalsIgnoreCase("MANAGER")) {
response.sendRedirect("login.jsp");
return;
}

String managerName = (String) session.getAttribute("managerName");
String username = (String) session.getAttribute("username");

if (managerName == null || managerName.trim().isEmpty()) {
managerName = "Manager";
}

if (username == null || username.trim().isEmpty()) {
username = managerName;
}

/* Generate initials */
String initials = "";

for (String part : managerName.trim().split("\s+")) {
if (!part.isEmpty()) {
initials += part.substring(0, 1).toUpperCase();
}
}

if (initials.length() > 2) {
initials = initials.substring(0, 2);
}

/* Messages */
String profileSuccess = (String) session.getAttribute("profileSuccess");
String profileError = (String) session.getAttribute("profileError");

if (profileSuccess != null) {
session.removeAttribute("profileSuccess");
}

if (profileError != null) {
session.removeAttribute("profileError");
}
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Profile | ELAMS</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

/* =====================================================
   RESET
===================================================== */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {

    --primary: #2563eb;
    --primary-dark: #1d4ed8;

    --blue-light: #eff6ff;

    --success: #16a34a;
    --success-bg: #dcfce7;

    --danger: #dc2626;
    --danger-bg: #fee2e2;

    --warning: #d97706;
    --warning-bg: #fef3c7;

    --text: #0f172a;
    --text-secondary: #64748b;
    --text-light: #94a3b8;

    --border: #e2e8f0;

    --background: #f5f7fb;

    --white: #ffffff;

    --shadow:
        0 10px 30px rgba(15, 23, 42, 0.06);

    --radius: 18px;
}


/* =====================================================
   BODY
===================================================== */

body {

    min-height: 100vh;

    background:
        linear-gradient(
            135deg,
            #f8fafc 0%,
            #f1f5f9 100%
        );

    color: var(--text);

    font-family: 'Inter', sans-serif;

    padding: 30px;

}


/* =====================================================
   MAIN CONTAINER
===================================================== */

.profile-container {

    max-width: 1200px;

    margin: 0 auto;

}


/* =====================================================
   PAGE HEADER
===================================================== */

.page-header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 25px;

}


.page-header-left {

    display: flex;

    align-items: center;

    gap: 15px;

}


.page-icon {

    width: 50px;

    height: 50px;

    border-radius: 14px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #0ea5e9
        );

    color: white;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 21px;

    box-shadow:
        0 8px 20px rgba(37, 99, 235, .25);

}


.page-header h1 {

    font-size: 25px;

    font-weight: 700;

    letter-spacing: -.5px;

}


.page-header p {

    color: var(--text-secondary);

    font-size: 13px;

    margin-top: 5px;

}


/* =====================================================
   ALERTS
===================================================== */

.alert {

    display: flex;

    align-items: center;

    gap: 10px;

    padding: 14px 18px;

    border-radius: 12px;

    margin-bottom: 20px;

    font-size: 14px;

    font-weight: 500;

    animation: slideDown .4s ease;

}


.alert-success {

    background: var(--success-bg);

    color: #166534;

    border:
        1px solid #bbf7d0;

}


.alert-error {

    background: var(--danger-bg);

    color: #991b1b;

    border:
        1px solid #fecaca;

}


@keyframes slideDown {

    from {

        opacity: 0;

        transform:
            translateY(-10px);

    }

    to {

        opacity: 1;

        transform:
            translateY(0);

    }

}


/* =====================================================
   PROFILE HERO
===================================================== */

.profile-hero {

    position: relative;

    overflow: hidden;

    background: white;

    border-radius: var(--radius);

    box-shadow: var(--shadow);

    margin-bottom: 25px;

}


.profile-cover {

    height: 145px;

    background:
        linear-gradient(
            135deg,
            #1d4ed8,
            #2563eb 50%,
            #0ea5e9
        );

    position: relative;

}


.profile-cover::before {

    content: "";

    position: absolute;

    width: 300px;

    height: 300px;

    border-radius: 50%;

    background:
        rgba(255,255,255,.08);

    top: -180px;

    right: 50px;

}


.profile-cover::after {

    content: "";

    position: absolute;

    width: 200px;

    height: 200px;

    border-radius: 50%;

    background:
        rgba(255,255,255,.06);

    bottom: -150px;

    left: 100px;

}


/* =====================================================
   PROFILE DETAILS
===================================================== */

.profile-details {

    display: flex;

    align-items: center;

    gap: 22px;

    padding: 0 30px 25px;

}


.avatar-wrapper {

    margin-top: -55px;

    position: relative;

}


.avatar {

    width: 110px;

    height: 110px;

    border-radius: 50%;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #0ea5e9
        );

    border:
        5px solid white;

    box-shadow:
        0 8px 25px rgba(0,0,0,.15);

    display: flex;

    align-items: center;

    justify-content: center;

    color: white;

    font-size: 32px;

    font-weight: 700;

}


.online-indicator {

    position: absolute;

    right: 8px;

    bottom: 8px;

    width: 20px;

    height: 20px;

    border-radius: 50%;

    background: #22c55e;

    border:
        4px solid white;

}


.profile-main-info {

    padding-top: 18px;

    flex: 1;

}


.profile-main-info h2 {

    font-size: 23px;

    font-weight: 700;

    margin-bottom: 6px;

}


.profile-email {

    color: var(--text-secondary);

    font-size: 13px;

    margin-bottom: 10px;

}


.profile-meta {

    display: flex;

    align-items: center;

    gap: 10px;

    flex-wrap: wrap;

}


.role-badge {

    display: inline-flex;

    align-items: center;

    gap: 6px;

    padding: 6px 12px;

    border-radius: 20px;

    background: var(--blue-light);

    color: var(--primary);

    font-size: 12px;

    font-weight: 600;

}


.status-badge {

    display: inline-flex;

    align-items: center;

    gap: 6px;

    padding: 6px 12px;

    border-radius: 20px;

    background: var(--success-bg);

    color: #15803d;

    font-size: 12px;

    font-weight: 600;

}


.status-dot {

    width: 7px;

    height: 7px;

    background: #22c55e;

    border-radius: 50%;

}


/* =====================================================
   PROFILE GRID
===================================================== */

.profile-grid {

    display: grid;

    grid-template-columns:
        minmax(0, 1.5fr)
        minmax(300px, 1fr);

    gap: 25px;

}


/* =====================================================
   CARD
===================================================== */

.card {

    background: white;

    border-radius: var(--radius);

    box-shadow: var(--shadow);

    border:
        1px solid rgba(226,232,240,.7);

    overflow: hidden;

}


.card-header {

    padding: 22px 25px;

    border-bottom:
        1px solid var(--border);

    display: flex;

    align-items: center;

    gap: 12px;

}


.card-header-icon {

    width: 38px;

    height: 38px;

    border-radius: 10px;

    background: var(--blue-light);

    color: var(--primary);

    display: flex;

    align-items: center;

    justify-content: center;

}


.card-header h3 {

    font-size: 16px;

    font-weight: 700;

}


.card-header p {

    font-size: 11px;

    color: var(--text-secondary);

    margin-top: 3px;

}


.card-body {

    padding: 25px;

}


/* =====================================================
   FORM
===================================================== */

.form-grid {

    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 20px;

}


.form-group {

    margin-bottom: 20px;

}


.form-group.full {

    grid-column: 1 / -1;

}


.form-group label {

    display: block;

    color: #475569;

    font-size: 12px;

    font-weight: 600;

    margin-bottom: 8px;

}


.input-wrapper {

    position: relative;

}


.input-wrapper i {

    position: absolute;

    left: 14px;

    top: 50%;

    transform:
        translateY(-50%);

    color: var(--text-light);

    font-size: 14px;

}


.form-group input {

    width: 100%;

    height: 46px;

    padding:
        0 14px 0 42px;

    border:
        1px solid var(--border);

    border-radius: 10px;

    background: #f8fafc;

    color: var(--text);

    outline: none;

    font-family: inherit;

    font-size: 13px;

    transition: .25s;

}


.form-group input:focus {

    border-color:
        var(--primary);

    background: white;

    box-shadow:
        0 0 0 3px
        rgba(37,99,235,.10);

}


.form-group input[readonly] {

    background: #f1f5f9;

    color: var(--text-secondary);

    cursor: not-allowed;

}


/* =====================================================
   BUTTON
===================================================== */

.form-actions {

    display: flex;

    justify-content: flex-end;

    gap: 10px;

    padding-top: 5px;

}


.btn {

    height: 44px;

    padding:
        0 22px;

    border: none;

    border-radius: 10px;

    font-family: inherit;

    font-size: 13px;

    font-weight: 600;

    cursor: pointer;

    display: inline-flex;

    align-items: center;

    justify-content: center;

    gap: 8px;

    transition: .25s;

}


.btn-primary {

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #1d4ed8
        );

    color: white;

    box-shadow:
        0 6px 15px
        rgba(37,99,235,.20);

}


.btn-primary:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 10px 20px
        rgba(37,99,235,.25);

}


/* =====================================================
   ACCOUNT INFORMATION
===================================================== */

.info-list {

    display: flex;

    flex-direction: column;

}


.info-row {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 15px;

    padding: 17px 0;

    border-bottom:
        1px solid #f1f5f9;

}


.info-row:last-child {

    border-bottom: none;

}


.info-label {

    display: flex;

    align-items: center;

    gap: 10px;

    color: var(--text-secondary);

    font-size: 12px;

}


.info-label i {

    width: 28px;

    height: 28px;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 8px;

    background: #f8fafc;

    color: var(--primary);

}


.info-value {

    font-size: 12px;

    font-weight: 600;

    color: var(--text);

    text-align: right;

    word-break: break-word;

}


.active-text {

    color: var(--success);

}


/* =====================================================
   SECURITY CARD
===================================================== */

.security-card {

    margin-top: 25px;

}


.security-item {

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 16px 0;

    border-bottom:
        1px solid #f1f5f9;

}


.security-item:last-child {

    border-bottom: none;

}


.security-left {

    display: flex;

    align-items: center;

    gap: 12px;

}


.security-icon {

    width: 38px;

    height: 38px;

    border-radius: 10px;

    background: #f8fafc;

    color: var(--primary);

    display: flex;

    align-items: center;

    justify-content: center;

}


.security-title {

    font-size: 13px;

    font-weight: 600;

}


.security-description {

    font-size: 11px;

    color: var(--text-secondary);

    margin-top: 3px;

}


.security-action {

    color: var(--primary);

    font-size: 12px;

    font-weight: 600;

    text-decoration: none;

}


.security-action:hover {

    text-decoration: underline;

}


/* =====================================================
   RESPONSIVE
===================================================== */

@media(max-width: 900px) {

    body {

        padding: 20px;

    }


    .profile-grid {

        grid-template-columns: 1fr;

    }

}


@media(max-width: 650px) {

    body {

        padding: 15px;

    }


    .page-header {

        margin-bottom: 20px;

    }


    .profile-cover {

        height: 110px;

    }


    .profile-details {

        flex-direction: column;

        text-align: center;

        padding:
            0 20px 25px;

    }


    .avatar-wrapper {

        margin-top: -50px;

    }


    .profile-main-info {

        padding-top: 10px;

    }


    .profile-meta {

        justify-content: center;

    }


    .form-grid {

        grid-template-columns: 1fr;

        gap: 0;

    }


    .form-group.full {

        grid-column: auto;

    }


    .form-actions {

        justify-content: stretch;

    }


    .btn {

        width: 100%;

    }


    .card-body {

        padding: 20px;

    }


    .info-row {

        align-items: flex-start;

        flex-direction: column;

        gap: 5px;

    }


    .info-value {

        text-align: left;

    }

}

</style>

</head>

<body>

<div class="profile-container">

<!-- =====================================================
     PAGE HEADER
===================================================== -->

<div class="page-header">

```
<div class="page-header-left">

    <div class="page-icon">

        <i class="fa-solid fa-user"></i>

    </div>

    <div>

        <h1>My Profile</h1>

        <p>Manage your personal information and account details</p>

    </div>

</div>
```

</div>

<!-- =====================================================
     SUCCESS MESSAGE
===================================================== -->

<% if (profileSuccess != null) { %>

<div class="alert alert-success">

```
<i class="fa-solid fa-circle-check"></i>

<span><%= profileSuccess %></span>
```

</div>

<% } %>

<!-- =====================================================
     ERROR MESSAGE
===================================================== -->

<% if (profileError != null) { %>

<div class="alert alert-error">

```
<i class="fa-solid fa-circle-exclamation"></i>

<span><%= profileError %></span>
```

</div>

<% } %>

<!-- =====================================================
     PROFILE HERO
===================================================== -->

<div class="profile-hero">

```
<div class="profile-cover"></div>


<div class="profile-details">


    <div class="avatar-wrapper">

        <div class="avatar">

            <%= initials %>

        </div>

        <div class="online-indicator"></div>

    </div>


    <div class="profile-main-info">

        <h2>
            <%= managerName %>
        </h2>

        <div class="profile-email">

            <i class="fa-solid fa-envelope"></i>

            &nbsp;

            <%= username %>

        </div>


        <div class="profile-meta">

            <span class="role-badge">

                <i class="fa-solid fa-user-tie"></i>

                Manager

            </span>


            <span class="status-badge">

                <span class="status-dot"></span>

                Active Account

            </span>

        </div>

    </div>


</div>
```

</div>

<!-- =====================================================
     PROFILE CONTENT
===================================================== -->

<div class="profile-grid">

<!-- =====================================================
     PERSONAL INFORMATION
===================================================== -->

<div class="card">

```
<div class="card-header">


    <div class="card-header-icon">

        <i class="fa-solid fa-user-pen"></i>

    </div>


    <div>

        <h3>Personal Information</h3>

        <p>Update your profile information</p>

    </div>


</div>


<div class="card-body">


    <form action="UpdateProfileServlet" method="post">


        <div class="form-grid">


            <!-- FULL NAME -->

            <div class="form-group full">

                <label>
                    Full Name
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-user"></i>

                    <input
                        type="text"
                        name="name"
                        value="<%= managerName %>"
                        placeholder="Enter your full name"
                        required>

                </div>

            </div>


            <!-- USERNAME -->

            <div class="form-group full">

                <label>
                    Username / Email
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-envelope"></i>

                    <input
                        type="text"
                        name="username"
                        value="<%= username %>"
                        placeholder="Enter your username or email"
                        required>

                </div>

            </div>


            <!-- ROLE -->

            <div class="form-group">

                <label>
                    Account Role
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-shield-halved"></i>

                    <input
                        type="text"
                        value="MANAGER"
                        readonly>

                </div>

            </div>


            <!-- STATUS -->

            <div class="form-group">

                <label>
                    Account Status
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-circle-check"></i>

                    <input
                        type="text"
                        value="Active"
                        readonly>

                </div>

            </div>


        </div>


        <div class="form-actions">

            <button
                type="submit"
                class="btn btn-primary">

                <i class="fa-solid fa-floppy-disk"></i>

                Save Changes

            </button>

        </div>


    </form>


</div>
```

</div>

<!-- =====================================================
     ACCOUNT INFORMATION
===================================================== -->

<div class="card">

```
<div class="card-header">


    <div class="card-header-icon">

        <i class="fa-solid fa-circle-info"></i>

    </div>


    <div>

        <h3>Account Information</h3>

        <p>Your ELAMS account details</p>

    </div>


</div>


<div class="card-body">


    <div class="info-list">


        <div class="info-row">

            <div class="info-label">

                <i class="fa-solid fa-user"></i>

                Account Name

            </div>

            <div class="info-value">

                <%= managerName %>

            </div>

        </div>


        <div class="info-row">

            <div class="info-label">

                <i class="fa-solid fa-envelope"></i>

                Username

            </div>

            <div class="info-value">

                <%= username %>

            </div>

        </div>


        <div class="info-row">

            <div class="info-label">

                <i class="fa-solid fa-user-tie"></i>

                Role

            </div>

            <div class="info-value">

                MANAGER

            </div>

        </div>


        <div class="info-row">

            <div class="info-label">

                <i class="fa-solid fa-circle-check"></i>

                Account Status

            </div>

            <div class="info-value active-text">

                Active

            </div>

        </div>


        <div class="info-row">

            <div class="info-label">

                <i class="fa-solid fa-shield-halved"></i>

                Access Level

            </div>

            <div class="info-value">

                Manager Portal

            </div>

        </div>


    </div>


</div>
```

</div>

</div>

<!-- =====================================================
     SECURITY SECTION
===================================================== -->

<div class="card security-card">

```
<div class="card-header">


    <div class="card-header-icon">

        <i class="fa-solid fa-lock"></i>

    </div>


    <div>

        <h3>Security & Account</h3>

        <p>Manage your account security</p>

    </div>


</div>


<div class="card-body">


    <div class="security-item">


        <div class="security-left">


            <div class="security-icon">

                <i class="fa-solid fa-key"></i>

            </div>


            <div>

                <div class="security-title">

                    Password

                </div>


                <div class="security-description">

                    Keep your account secure with a strong password.

                </div>

            </div>


        </div>


        <a
            href="changePassword.jsp"
            class="security-action">

            Change Password

        </a>


    </div>


    <div class="security-item">


        <div class="security-left">


            <div class="security-icon">

                <i class="fa-solid fa-right-from-bracket"></i>

            </div>


            <div>

                <div class="security-title">

                    Sign out

                </div>


                <div class="security-description">

                    Securely sign out from your ELAMS manager account.

                </div>

            </div>


        </div>


        <a
            href="logout"
            class="security-action">

            Logout

        </a>


    </div>


</div>
```

</div>

</div>

<script>

/* =====================================================
   AUTO HIDE ALERTS
===================================================== */

setTimeout(function() {

    const alerts =
        document.querySelectorAll(".alert");

    alerts.forEach(function(alert) {

        alert.style.transition =
            "opacity .5s ease";

        alert.style.opacity = "0";

        setTimeout(function() {

            alert.remove();

        }, 500);

    });

}, 5000);

</script>

</body>

</html>
