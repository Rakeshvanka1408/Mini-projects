
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.rakesh.elams.model.EmployeePerformance" %>

<%
    // =========================================================
    // MANAGER ROLE CHECK
    // =========================================================

    String role = (String) session.getAttribute("role");

    if (role == null || !role.equalsIgnoreCase("MANAGER")) {
        response.sendRedirect("login.jsp");
        return;
    }


    // =========================================================
    // GET MANAGER NAME
    // =========================================================

    String managerName =
            (String) session.getAttribute("managerName");

    if (managerName == null ||
        managerName.trim().isEmpty()) {

        managerName = "Manager";
    }


    // =========================================================
    // GET PERFORMANCE DATA FROM SERVLET
    // =========================================================

    List<EmployeePerformance> performanceList =
            (List<EmployeePerformance>)
            request.getAttribute("performanceList");


    // =========================================================
    // IF PAGE IS OPENED DIRECTLY
    // REDIRECT TO SERVLET
    // =========================================================

    if (performanceList == null) {

        response.sendRedirect("PerformanceServlet");
        return;
    }


    // =========================================================
    // CALCULATE TEAM STATISTICS
    // =========================================================

    int totalEmployees =
            performanceList.size();

    int totalTasks = 0;

    int completedTasks = 0;

    double totalPerformance = 0;

    int topPerformers = 0;


    for (EmployeePerformance p : performanceList) {

        totalTasks += p.getTotalTasks();

        completedTasks += p.getCompletedTasks();

        totalPerformance +=
                p.getPerformancePercentage();


        if (p.getPerformancePercentage() >= 90) {

            topPerformers++;
        }
    }


    // =========================================================
    // AVERAGE TEAM PERFORMANCE
    // =========================================================

    double averagePerformance = 0;

    if (totalEmployees > 0) {

        averagePerformance =
                totalPerformance / totalEmployees;
    }


    // =========================================================
    // TEAM PRODUCTIVITY
    // =========================================================

    double teamProductivity = 0;

    if (totalTasks > 0) {

        teamProductivity =
                (completedTasks * 100.0)
                / totalTasks;
    }

%>


<!DOCTYPE html>

<html lang="en">


<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">


<title>
    Performance | ELAMS
</title>


<!-- =====================================================
     GOOGLE FONT
===================================================== -->

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>


<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">


<!-- =====================================================
     FONT AWESOME
===================================================== -->

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


<!-- =====================================================
     CHART JS
===================================================== -->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<style>


/* =====================================================
   RESET
===================================================== */

* {

    margin: 0;

    padding: 0;

    box-sizing: border-box;

    font-family: 'Poppins', sans-serif;

}


/* =====================================================
   BODY
===================================================== */

body {

    background: #f4f7fb;

    color: #1f2937;

    padding: 30px;

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


.page-title {

    display: flex;

    align-items: center;

    gap: 15px;

}


.page-title-icon {

    width: 50px;

    height: 50px;

    border-radius: 14px;

    background: #2563eb;

    color: white;

    display: flex;

    justify-content: center;

    align-items: center;

    font-size: 22px;

}


.page-title h2 {

    font-size: 25px;

}


.page-title p {

    color: #64748b;

    font-size: 13px;

    margin-top: 3px;

}


.manager-label {

    color: #64748b;

    font-size: 13px;

    margin-top: 4px;

}


/* =====================================================
   STATISTICS
===================================================== */

.stats {

    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 20px;

    margin-bottom: 25px;

}


.stat-card {

    background: white;

    padding: 22px;

    border-radius: 16px;

    box-shadow:
        0 8px 20px rgba(0,0,0,.06);

    display: flex;

    justify-content: space-between;

    align-items: center;

    transition: .3s;

}


.stat-card:hover {

    transform: translateY(-4px);

}


.stat-card h4 {

    color: #64748b;

    font-size: 13px;

    margin-bottom: 8px;

}


.stat-card h2 {

    font-size: 28px;

}


.stat-card small {

    color: #22c55e;

    font-size: 11px;

}


.stat-icon {

    width: 50px;

    height: 50px;

    border-radius: 14px;

    background: #eff6ff;

    color: #2563eb;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 22px;

}


/* =====================================================
   CONTENT GRID
===================================================== */

.content-grid {

    display: grid;

    grid-template-columns:
        2fr 1fr;

    gap: 25px;

}


/* =====================================================
   PANEL
===================================================== */

.panel {

    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 8px 20px rgba(0,0,0,.06);

}


.panel-header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 20px;

}


.panel-header h3 {

    font-size: 18px;

}


.panel-header p {

    font-size: 12px;

    color: #64748b;

    margin-top: 3px;

}


/* =====================================================
   PERFORMANCE TABLE
===================================================== */

.table-container {

    width: 100%;

    overflow-x: auto;

}


.performance-table {

    width: 100%;

    border-collapse: collapse;

}


.performance-table th,
.performance-table td {

    padding: 14px 10px;

    text-align: left;

    border-bottom:
        1px solid #e5e7eb;

    font-size: 13px;

}


.performance-table th {

    color: #64748b;

    font-weight: 600;

    background: #f8fafc;

}


.performance-table tbody tr {

    transition: .2s;

}


.performance-table tbody tr:hover {

    background: #f8fafc;

}


/* =====================================================
   EMPLOYEE NAME
===================================================== */

.employee-name {

    font-weight: 600;

    color: #1f2937;

}


.employee-id {

    display: block;

    font-size: 10px;

    color: #94a3b8;

    margin-top: 3px;

}


/* =====================================================
   PROGRESS BAR
===================================================== */

.progress-wrapper {

    display: flex;

    align-items: center;

    gap: 10px;

}


.progress {

    width: 100px;

    height: 8px;

    background: #e2e8f0;

    border-radius: 20px;

    overflow: hidden;

}


.progress-bar {

    height: 100%;

    background: #2563eb;

    border-radius: 20px;

    transition: width .5s ease;

}


.progress-value {

    font-size: 12px;

    font-weight: 600;

    color: #475569;

}


/* =====================================================
   RATING BADGES
===================================================== */

.badge {

    padding: 5px 10px;

    border-radius: 20px;

    font-size: 11px;

    font-weight: 600;

    display: inline-block;

}


.excellent {

    background: #dcfce7;

    color: #15803d;

}


.good {

    background: #dbeafe;

    color: #1d4ed8;

}


.average {

    background: #fef3c7;

    color: #b45309;

}


.needs-improvement {

    background: #fee2e2;

    color: #b91c1c;

}


/* =====================================================
   EMPTY MESSAGE
===================================================== */

.empty-message {

    text-align: center;

    padding: 60px 20px;

    color: #64748b;

}


.empty-message i {

    font-size: 45px;

    margin-bottom: 15px;

    color: #94a3b8;

}


.empty-message p {

    font-size: 14px;

}


/* =====================================================
   CHART
===================================================== */

.chart-container {

    position: relative;

    height: 350px;

}


/* =====================================================
   RESPONSIVE
===================================================== */

@media(max-width: 1100px) {

    .stats {

        grid-template-columns:
            repeat(2, 1fr);

    }

}


@media(max-width: 900px) {

    .content-grid {

        grid-template-columns: 1fr;

    }

}


@media(max-width: 600px) {

    body {

        padding: 15px;

    }


    .stats {

        grid-template-columns: 1fr;

    }


    .page-header {

        flex-direction: column;

        align-items: flex-start;

        gap: 15px;

    }


    .page-title h2 {

        font-size: 21px;

    }


    .panel {

        padding: 15px;

    }

}


</style>

</head>


<body>


<!-- =====================================================
     PAGE HEADER
===================================================== -->

<div class="page-header">


    <div class="page-title">


        <div class="page-title-icon">

            <i class="fa-solid fa-chart-line"></i>

        </div>


        <div>


            <h2>
                Team Performance
            </h2>


            <p>
                Monitor the performance and productivity
                of your employees
            </p>


            <div class="manager-label">

                Manager:

                <strong>
                    <%= managerName %>
                </strong>

            </div>


        </div>


    </div>


</div>



<!-- =====================================================
     STATISTICS CARDS
===================================================== -->

<div class="stats">


    <!-- TEAM EMPLOYEES -->

    <div class="stat-card">


        <div>


            <h4>
                Team Employees
            </h4>


            <h2>
                <%= totalEmployees %>
            </h2>


            <small>
                Employees reporting to you
            </small>


        </div>


        <div class="stat-icon">

            <i class="fa-solid fa-users"></i>

        </div>


    </div>



    <!-- AVERAGE PERFORMANCE -->

    <div class="stat-card">


        <div>


            <h4>
                Average Performance
            </h4>


            <h2>

                <%= String.format(
                    "%.1f",
                    averagePerformance
                ) %>%

            </h2>


            <small>
                Team average
            </small>


        </div>


        <div class="stat-icon">

            <i class="fa-solid fa-arrow-trend-up"></i>

        </div>


    </div>



    <!-- COMPLETED TASKS -->

    <div class="stat-card">


        <div>


            <h4>
                Tasks Completed
            </h4>


            <h2>
                <%= completedTasks %>
            </h2>


            <small>

                Out of

                <%= totalTasks %>

                total tasks

            </small>


        </div>


        <div class="stat-icon">

            <i class="fa-solid fa-check-double"></i>

        </div>


    </div>



    <!-- TOP PERFORMERS -->

    <div class="stat-card">


        <div>


            <h4>
                Top Performers
            </h4>


            <h2>
                <%= topPerformers %>
            </h2>


            <small>
                Performance 90%+
            </small>


        </div>


        <div class="stat-icon">

            <i class="fa-solid fa-trophy"></i>

        </div>


    </div>


</div>



<!-- =====================================================
     CONTENT
===================================================== -->

<div class="content-grid">



<!-- =====================================================
     EMPLOYEE PERFORMANCE TABLE
===================================================== -->

<div class="panel">


    <div class="panel-header">


        <div>


            <h3>

                <i class="fa-solid fa-users"></i>

                Employee Performance

            </h3>


            <p>

                Performance of employees assigned
                to <%= managerName %>

            </p>


        </div>


    </div>



    <% if (performanceList.isEmpty()) { %>


        <!-- NO EMPLOYEES -->

        <div class="empty-message">


            <i class="fa-solid fa-users-slash"></i>


            <p>

                No employees are currently
                assigned to you.

            </p>


        </div>


    <% } else { %>


        <div class="table-container">


            <table class="performance-table">


                <thead>


                    <tr>


                        <th>
                            Employee
                        </th>


                        <th>
                            Total Tasks
                        </th>


                        <th>
                            Completed
                        </th>


                        <th>
                            Completion
                        </th>


                        <th>
                            Performance
                        </th>


                        <th>
                            Rating
                        </th>


                    </tr>


                </thead>


                <tbody>


                <%


                for (EmployeePerformance p :
                        performanceList) {


                    String ratingClass =
                            "needs-improvement";


                    if ("Excellent".equals(
                            p.getRating())) {


                        ratingClass =
                                "excellent";


                    } else if ("Good".equals(
                            p.getRating())) {


                        ratingClass =
                                "good";


                    } else if ("Average".equals(
                            p.getRating())) {


                        ratingClass =
                                "average";

                    }


                %>


                    <tr>


                        <!-- EMPLOYEE -->

                        <td>


                            <span class="employee-name">

                                <%= p.getEmployeeName() %>

                            </span>


                            <span class="employee-id">

                                Employee ID:

                                <%= p.getEmployeeId() %>

                            </span>


                        </td>



                        <!-- TOTAL TASKS -->

                        <td>

                            <strong>

                                <%= p.getTotalTasks() %>

                            </strong>

                        </td>



                        <!-- COMPLETED TASKS -->

                        <td>

                            <strong>

                                <%= p.getCompletedTasks() %>

                            </strong>


                        </td>



                        <!-- COMPLETION PROGRESS -->

                        <td>


                            <div class="progress-wrapper">


                                <div class="progress">


                                    <div class="progress-bar"

                                         style="width:<%=

                                         p.getCompletionPercentage()

                                         %>%">

                                    </div>


                                </div>


                                <span class="progress-value">

                                    <%= String.format(

                                        "%.0f",

                                        p.getCompletionPercentage()

                                    ) %>%

                                </span>


                            </div>


                        </td>



                        <!-- PERFORMANCE -->

                        <td>


                            <strong>

                                <%= String.format(

                                    "%.1f",

                                    p.getPerformancePercentage()

                                ) %>%

                            </strong>


                        </td>



                        <!-- RATING -->

                        <td>


                            <span class="badge <%= ratingClass %>">

                                <%= p.getRating() %>

                            </span>


                        </td>


                    </tr>


                <%


                }


                %>


                </tbody>


            </table>


        </div>


    <% } %>


</div>



<!-- =====================================================
     PERFORMANCE CHART
===================================================== -->

<div class="panel">


    <div class="panel-header">


        <div>


            <h3>

                <i class="fa-solid fa-chart-column"></i>

                Team Performance

            </h3>


            <p>
                Performance comparison
            </p>


        </div>


    </div>



    <div class="chart-container">


        <canvas id="performanceChart"></canvas>


    </div>


</div>



</div>



<!-- =====================================================
     JAVASCRIPT
===================================================== -->

<script>


/* =====================================================
   EMPLOYEE NAMES
===================================================== */

const employeeNames = [

<%

for (int i = 0;

     i < performanceList.size();

     i++) {


    EmployeePerformance p =

        performanceList.get(i);


%>


    "<%= p.getEmployeeName()
          .replace("\\", "\\\\")
          .replace("\"", "\\\"") %>"


<%

    if (i < performanceList.size() - 1) {

%>

    ,

<%

    }

}


%>

];



/* =====================================================
   PERFORMANCE VALUES
===================================================== */

const performanceData = [

<%

for (int i = 0;

     i < performanceList.size();

     i++) {


    EmployeePerformance p =

        performanceList.get(i);


%>


    <%= p.getPerformancePercentage() %>


<%

    if (i < performanceList.size() - 1) {

%>

    ,

<%

    }

}


%>

];



/* =====================================================
   CREATE PERFORMANCE CHART
===================================================== */

const ctx =

    document.getElementById(
        'performanceChart'
    );


if (employeeNames.length > 0) {


    new Chart(ctx, {


        type: 'bar',


        data: {


            labels:
                employeeNames,


            datasets: [{

                label:
                    'Performance %',


                data:
                    performanceData,


                backgroundColor:
                    '#2563eb',


                borderRadius:
                    6,


                barThickness:
                    35

            }]


        },


        options: {


            responsive: true,


            maintainAspectRatio:
                false,


            scales: {


                y: {


                    beginAtZero:
                        true,


                    max:
                        100,


                    ticks: {


                        callback:
                            function(value) {


                                return value + '%';


                            }


                    }


                }


            },


            plugins: {


                legend: {


                    display:
                        false


                },


                tooltip: {


                    callbacks: {


                        label:
                            function(context) {


                                return 'Performance: '
                                    + context.parsed.y
                                    + '%';


                            }


                    }


                }


            }


        }


    });


}

</script>


</body>

</html>
