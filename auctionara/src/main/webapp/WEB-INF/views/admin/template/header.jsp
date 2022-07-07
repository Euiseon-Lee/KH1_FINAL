<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/" />

	<title>경매나라 Admin</title>

	<link href="${root}/css/app.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	
	<script src="js/app.js"></script>

	<!-- <script>
		document.addEventListener("DOMContentLoaded", function() {
			var ctx = document.getElementById("chartjs-dashboard-line").getContext("2d");
			var gradient = ctx.createLinearGradient(0, 0, 0, 225);
			gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
			gradient.addColorStop(1, "rgba(215, 227, 244, 0)");
			// Line chart
			new Chart(document.getElementById("chartjs-dashboard-line"), {
				type: "line",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "Sales ($)",
						fill: true,
						backgroundColor: gradient,
						borderColor: window.theme.primary,
						data: [
							2115,
							1562,
							1584,
							1892,
							1587,
							1923,
							2566,
							2448,
							2805,
							3438,
							2917,
							3327
						]
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					tooltips: {
						intersect: false
					},
					hover: {
						intersect: true
					},
					plugins: {
						filler: {
							propagate: false
						}
					},
					scales: {
						xAxes: [{
							reverse: true,
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}],
						yAxes: [{
							ticks: {
								stepSize: 1000
							},
							display: true,
							borderDash: [3, 3],
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}]
					}
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Pie chart
			new Chart(document.getElementById("chartjs-dashboard-pie"), {
				type: "pie",
				data: {
					labels: ["Chrome", "Firefox", "IE"],
					datasets: [{
						data: [4306, 3801, 1689],
						backgroundColor: [
							window.theme.primary,
							window.theme.warning,
							window.theme.danger
						],
						borderWidth: 5
					}]
				},
				options: {
					responsive: !window.MSInputMethodContext,
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					cutoutPercentage: 75
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Bar chart
			new Chart(document.getElementById("chartjs-dashboard-bar"), {
				type: "bar",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "This year",
						backgroundColor: window.theme.primary,
						borderColor: window.theme.primary,
						hoverBackgroundColor: window.theme.primary,
						hoverBorderColor: window.theme.primary,
						data: [54, 67, 41, 55, 62, 45, 55, 73, 60, 76, 48, 79],
						barPercentage: .75,
						categoryPercentage: .5
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					scales: {
						yAxes: [{
							gridLines: {
								display: false
							},
							stacked: false,
							ticks: {
								stepSize: 20
							}
						}],
						xAxes: [{
							stacked: false,
							gridLines: {
								color: "transparent"
							}
						}]
					}
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var markers = [{
					coords: [31.230391, 121.473701],
					name: "Shanghai"
				},
				{
					coords: [28.704060, 77.102493],
					name: "Delhi"
				},
				{
					coords: [6.524379, 3.379206],
					name: "Lagos"
				},
				{
					coords: [35.689487, 139.691711],
					name: "Tokyo"
				},
				{
					coords: [23.129110, 113.264381],
					name: "Guangzhou"
				},
				{
					coords: [40.7127837, -74.0059413],
					name: "New York"
				},
				{
					coords: [34.052235, -118.243683],
					name: "Los Angeles"
				},
				{
					coords: [41.878113, -87.629799],
					name: "Chicago"
				},
				{
					coords: [51.507351, -0.127758],
					name: "London"
				},
				{
					coords: [40.416775, -3.703790],
					name: "Madrid "
				}
			];
			var map = new jsVectorMap({
				map: "world",
				selector: "#world_map",
				zoomButtons: true,
				markers: markers,
				markerStyle: {
					initial: {
						r: 9,
						strokeWidth: 7,
						stokeOpacity: .4,
						fill: window.theme.primary
					},
					hover: {
						fill: window.theme.primary,
						stroke: window.theme.primary
					}
				},
				zoomOnScroll: false
			});
			window.addEventListener("resize", () => {
				map.updateSize();
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var date = new Date(Date.now() - 5 * 24 * 60 * 60 * 1000);
			var defaultDate = date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + date.getUTCDate();
			document.getElementById("datetimepicker-dashboard").flatpickr({
				inline: true,
				prevArrow: "<span title=\"Previous month\">&laquo;</span>",
				nextArrow: "<span title=\"Next month\">&raquo;</span>",
				defaultDate: defaultDate
			});
		});
	</script> -->
</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="#">
		          <span class="align-middle">경매나라</span>
		        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						매출 관리
					</li>

					<li class="sidebar-item active">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">매출 현황</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						회원 관리
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="user"></i> <span class="align-middle">회원 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="log-in"></i> <span class="align-middle">평가항목 관리</span>
			            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="log-in"></i> <span class="align-middle">제제 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="user-plus"></i> <span class="align-middle">경매 관리</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						현금화 관리
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="book"></i> <span class="align-middle">현금화 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="book"></i> <span class="align-middle">현금화 신청 내역</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						경매 관리
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#	">
			              <i class="align-middle" data-feather="square"></i> <span class="align-middle">경매 게시글 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="check-square"></i> <span class="align-middle">카테고리 관리</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="grid"></i> <span class="align-middle">신고 내역</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						채팅 / 챗봇 관리 
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="align-left"></i> <span class="align-middle">챗봇 관리</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <i class="align-middle" data-feather="coffee"></i> <span class="align-middle">신고 내역</span>
			            </a>
					</li>
				</ul>
			</div>
		</nav>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<div class="list-group text-end">
									
				</div>
			</nav>

			<main class="content">
