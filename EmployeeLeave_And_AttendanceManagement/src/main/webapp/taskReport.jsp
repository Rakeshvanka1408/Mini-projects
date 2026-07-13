<%
String role = (String) session.getAttribute("role");

if (role == null || !"MANAGER".equalsIgnoreCase(role)) {
    response.sendRedirect("login.jsp");
    return;
}

// Calculate percentages once at the top
Object totalObj = request.getAttribute("totalTasks");
Object completedObj = request.getAttribute("completedTasks");
Object pendingObj = request.getAttribute("pendingTasks");
Object progressObj = request.getAttribute("inProgressTasks");
Object overdueObj = request.getAttribute("overdueTasks");

int total = totalObj != null ? Integer.parseInt(totalObj.toString()) : 0;
int completed = completedObj != null ? Integer.parseInt(completedObj.toString()) : 0;
int pending = pendingObj != null ? Integer.parseInt(pendingObj.toString()) : 0;
int inProgress = progressObj != null ? Integer.parseInt(progressObj.toString()) : 0;
int overdue = overdueObj != null ? Integer.parseInt(overdueObj.toString()) : 0;

int completedPercent = total > 0 ? (completed * 100) / total : 0;
int pendingPercent = total > 0 ? (pending * 100) / total : 0;
int progressPercent = total > 0 ? (inProgress * 100) / total : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Task Report Dashboard - ELAMS</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', 'Roboto', sans-serif;
}

:root {
	--primary: #6366f1;
	--primary-dark: #4f46e5;
	--secondary: #8b5cf6;
	--accent: #f59e0b;
	--success: #10b981;
	--warning: #f59e0b;
	--danger: #ef4444;
	--info: #3b82f6;
	--light: #f9fafb;
	--light-2: #f3f4f6;
	--border: #e5e7eb;
	--text-primary: #1f2937;
	--text-secondary: #6b7280;
	--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
	--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
	--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

body {
	background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
	min-height: 100vh;
	padding: 30px 20px;
	color: var(--text-primary);
}

.container {
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
}

.header {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-bottom: 35px;
	padding-bottom: 25px;
	border-bottom: 2px solid white;
	animation: slideDown 0.5s ease-out;
}

@keyframes slideDown {
	from {
		opacity: 0;
		transform: translateY(-20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.header i {
	font-size: 36px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.header h1 {
	font-size: 32px;
	font-weight: 700;
	color: var(--text-primary);
	margin: 0;
}

/* Report Stats Grid */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 25px;
	margin-bottom: 40px;
	animation: slideUp 0.6s ease-out;
}

@keyframes slideUp {
	from {
		opacity: 0;
		transform: translateY(20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.stat-card {
	background: white;
	border-radius: 16px;
	padding: 30px;
	box-shadow: var(--shadow-lg);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	position: relative;
	overflow: hidden;
	border-top: 4px solid var(--primary);
}

.stat-card::before {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	width: 100px;
	height: 100px;
	background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%, transparent 70%);
	border-radius: 50%;
	transform: translate(30px, -30px);
	pointer-events: none;
}

.stat-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
}

.stat-card.total {
	border-top-color: var(--primary);
	background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, white 100%);
}

.stat-card.completed {
	border-top-color: var(--success);
	background: linear-gradient(135deg, rgba(16, 185, 129, 0.05) 0%, white 100%);
}

.stat-card.pending {
	border-top-color: var(--warning);
	background: linear-gradient(135deg, rgba(245, 158, 11, 0.05) 0%, white 100%);
}

.stat-card.progress {
	border-top-color: var(--info);
	background: linear-gradient(135deg, rgba(59, 130, 246, 0.05) 0%, white 100%);
}

.stat-card.overdue {
	border-top-color: var(--danger);
	background: linear-gradient(135deg, rgba(239, 68, 68, 0.05) 0%, white 100%);
}

.stat-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 20px;
	position: relative;
	z-index: 1;
}

.stat-header h3 {
	font-size: 16px;
	font-weight: 600;
	color: var(--text-secondary);
	margin: 0;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.stat-icon {
	font-size: 32px;
	opacity: 0.8;
}

.stat-icon.total {
	color: var(--primary);
}

.stat-icon.completed {
	color: var(--success);
}

.stat-icon.pending {
	color: var(--warning);
}

.stat-icon.progress {
	color: var(--info);
}

.stat-icon.overdue {
	color: var(--danger);
}

.stat-value {
	font-size: 48px;
	font-weight: 700;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	margin: 0;
	position: relative;
	z-index: 1;
}

.stat-card.completed .stat-value {
	background: linear-gradient(135deg, var(--success), #059669);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.stat-card.pending .stat-value {
	background: linear-gradient(135deg, var(--warning), #d97706);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.stat-card.progress .stat-value {
	background: linear-gradient(135deg, var(--info), #1d4ed8);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.stat-card.overdue .stat-value {
	background: linear-gradient(135deg, var(--danger), #991b1b);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.stat-footer {
	margin-top: 15px;
	padding-top: 15px;
	border-top: 1px solid var(--border);
	font-size: 13px;
	color: var(--text-secondary);
	position: relative;
	z-index: 1;
}

.stat-footer i {
	margin-right: 6px;
	color: var(--primary);
}

.stat-footer.completed i {
	color: var(--success);
}

.stat-footer.pending i {
	color: var(--warning);
}

.stat-footer.progress i {
	color: var(--info);
}

.stat-footer.overdue i {
	color: var(--danger);
}

/* Progress Bars */
.progress-section {
	background: white;
	border-radius: 16px;
	padding: 30px;
	box-shadow: var(--shadow-lg);
	margin-bottom: 30px;
	animation: slideUp 0.7s ease-out;
}

.progress-title {
	font-size: 18px;
	font-weight: 700;
	color: var(--text-primary);
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.progress-title i {
	font-size: 24px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.progress-item {
	margin-bottom: 25px;
}

.progress-item:last-child {
	margin-bottom: 0;
}

.progress-label {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
	font-size: 14px;
	font-weight: 600;
}

.progress-label-name {
	color: var(--text-primary);
	display: flex;
	align-items: center;
	gap: 8px;
}

.progress-label-value {
	color: var(--primary);
	background: rgba(99, 102, 241, 0.1);
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 700;
}

.progress-bar {
	width: 100%;
	height: 12px;
	background: var(--light-2);
	border-radius: 10px;
	overflow: hidden;
	position: relative;
}

.progress-bar-fill {
	height: 100%;
	background: linear-gradient(90deg, var(--primary), var(--secondary));
	border-radius: 10px;
	transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
	position: relative;
	min-width: 2%;
}

.progress-bar-fill::after {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
	animation: shimmer 2s infinite;
}

@keyframes shimmer {
	0% {
		transform: translateX(-100%);
	}
	100% {
		transform: translateX(100%);
	}
}

/* Key Metrics Box */
.metrics-box {
	background: white;
	border-radius: 16px;
	padding: 30px;
	box-shadow: var(--shadow-lg);
	animation: slideUp 0.8s ease-out;
}

.metrics-title {
	font-size: 18px;
	font-weight: 700;
	color: var(--text-primary);
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.metrics-title i {
	font-size: 24px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.metrics-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
}

.metric-item {
	background: linear-gradient(135deg, var(--light-2) 0%, white 100%);
	padding: 20px;
	border-radius: 12px;
	border-left: 4px solid var(--primary);
	text-align: center;
	transition: all 0.3s ease;
}

.metric-item:hover {
	transform: translateY(-4px);
	box-shadow: var(--shadow-md);
}

.metric-label {
	font-size: 13px;
	color: var(--text-secondary);
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	margin-bottom: 8px;
}

.metric-value {
	font-size: 28px;
	font-weight: 700;
	color: var(--primary);
}

.metric-item[style*="--warning"] .metric-value {
	color: var(--warning);
}

.metric-item[style*="--info"] .metric-value {
	color: var(--info);
}

.metric-item[style*="--danger"] .metric-value {
	color: var(--danger);
}

/* Responsive */
@media (max-width: 1024px) {
	.stats-grid {
		grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	}

	.header h1 {
		font-size: 28px;
	}
}

@media (max-width: 768px) {
	body {
		padding: 20px 15px;
	}

	.container {
		max-width: 100%;
	}

	.header {
		flex-direction: column;
		align-items: flex-start;
		margin-bottom: 25px;
	}

	.header h1 {
		font-size: 24px;
	}

	.stats-grid {
		grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
		gap: 15px;
		margin-bottom: 25px;
	}

	.stat-card {
		padding: 20px;
	}

	.stat-value {
		font-size: 36px;
	}

	.progress-section, .metrics-box {
		padding: 20px;
	}

	.metrics-grid {
		grid-template-columns: 1fr;
	}
}

@media (max-width: 480px) {
	body {
		padding: 15px 10px;
	}

	.header i {
		font-size: 28px;
	}

	.header h1 {
		font-size: 20px;
	}

	.stats-grid {
		grid-template-columns: 1fr;
		gap: 12px;
	}

	.stat-card {
		padding: 18px;
	}

	.stat-value {
		font-size: 32px;
	}

	.stat-header h3 {
		font-size: 14px;
	}

	.progress-section, .metrics-box {
		padding: 15px;
	}

	.progress-title {
		font-size: 16px;
	}

	.metrics-title {
		font-size: 16px;
	}

	.metric-value {
		font-size: 24px;
	}
}
</style>

</head>
<body>

	<div class="container">

		<div class="header">
			<i class="fa-solid fa-chart-line"></i>
			<h1>Task Report Dashboard</h1>
		</div>

		<!-- Main Stats Grid -->
		<div class="stats-grid">

			<!-- Total Tasks Card -->
			<div class="stat-card total">
				<div class="stat-header">
					<h3>Total Tasks</h3>
					<i class="fa-solid fa-layer-group stat-icon total"></i>
				</div>
				<p class="stat-value"><%= total %></p>
				<div class="stat-footer">
					<i class="fa-solid fa-check-circle"></i> All assigned tasks
				</div>
			</div>

			<!-- Completed Tasks Card -->
			<div class="stat-card completed">
				<div class="stat-header">
					<h3>Completed Tasks</h3>
					<i class="fa-solid fa-circle-check stat-icon completed"></i>
				</div>
				<p class="stat-value"><%= completed %></p>
				<div class="stat-footer completed">
					<i class="fa-solid fa-check"></i>
					<%= completedPercent %>% completion rate
				</div>
			</div>

			<!-- Pending Tasks Card -->
			<div class="stat-card pending">
				<div class="stat-header">
					<h3>Pending Tasks</h3>
					<i class="fa-solid fa-hourglass-start stat-icon pending"></i>
				</div>
				<p class="stat-value"><%= pending %></p>
				<div class="stat-footer pending">
					<i class="fa-solid fa-clock"></i> Waiting to start
				</div>
			</div>

			<!-- In Progress Tasks Card -->
			<div class="stat-card progress">
				<div class="stat-header">
					<h3>In Progress</h3>
					<i class="fa-solid fa-spinner stat-icon progress"></i>
				</div>
				<p class="stat-value"><%= inProgress %></p>
				<div class="stat-footer progress">
					<i class="fa-solid fa-bolt"></i> Currently working
				</div>
			</div>

			<!-- Overdue Tasks Card -->
			<div class="stat-card overdue">
				<div class="stat-header">
					<h3>Overdue Tasks</h3>
					<i class="fa-solid fa-exclamation-circle stat-icon overdue"></i>
				</div>
				<p class="stat-value"><%= overdue %></p>
				<div class="stat-footer overdue">
					<i class="fa-solid fa-warning"></i> Past due date
				</div>
			</div>

		</div>

		<!-- Progress Section -->
		<div class="progress-section">

			<div class="progress-title">
				<i class="fa-solid fa-chart-bar"></i> Task Status Distribution
			</div>

			<div class="progress-item">
				<div class="progress-label">
					<span class="progress-label-name">
						<i class="fa-solid fa-circle-check" style="color: var(--success);"></i>
						Completed Tasks
					</span>
					<span class="progress-label-value"><%=completedPercent%>%</span>
				</div>
				<div class="progress-bar">
					<div class="progress-bar-fill"
						style="width: <%=completedPercent%>%; background: linear-gradient(90deg, var(--success), #059669);"></div>
				</div>
			</div>

			<div class="progress-item">
				<div class="progress-label">
					<span class="progress-label-name">
						<i class="fa-solid fa-hourglass-start"
							style="color: var(--warning);"></i> Pending Tasks
					</span>
					<span class="progress-label-value"><%=pendingPercent%>%</span>
				</div>
				<div class="progress-bar">
					<div class="progress-bar-fill"
						style="width: <%=pendingPercent%>%; background: linear-gradient(90deg, var(--warning), #d97706);"></div>
				</div>
			</div>

			<div class="progress-item">
				<div class="progress-label">
					<span class="progress-label-name">
						<i class="fa-solid fa-spinner" style="color: var(--info);"></i>
						In Progress Tasks
					</span>
					<span class="progress-label-value"><%=progressPercent%>%</span>
				</div>
				<div class="progress-bar">
					<div class="progress-bar-fill"
						style="width: <%=progressPercent%>%; background: linear-gradient(90deg, var(--info), #1d4ed8);"></div>
				</div>
			</div>

		</div>

		<!-- Key Metrics -->
		<div class="metrics-box">

			<div class="metrics-title">
				<i class="fa-solid fa-chart-pie"></i> Key Performance Indicators
			</div>

			<div class="metrics-grid">

				<div class="metric-item">
					<div class="metric-label">Completion Rate</div>
					<div class="metric-value"><%=completedPercent%>%</div>
				</div>

				<div class="metric-item"
					style="border-left-color: var(--warning);">
					<div class="metric-label">Pending Rate</div>
					<div class="metric-value"
						style="color: var(--warning);">
						<%=pendingPercent%>%
					</div>
				</div>

				<div class="metric-item"
					style="border-left-color: var(--info);">
					<div class="metric-label">In Progress Rate</div>
					<div class="metric-value"
						style="color: var(--info);">
						<%=progressPercent%>%
					</div>
				</div>

				<div class="metric-item"
					style="border-left-color: var(--danger);">
					<div class="metric-label">Overdue Tasks</div>
					<div class="metric-value"
						style="color: var(--danger);">
						<%= overdue %>
					</div>
				</div>

			</div>

		</div>

	</div>

</body>
</html>
