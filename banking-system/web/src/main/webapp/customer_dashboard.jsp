<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root {
            --bg: #F3F3E0;
            --primary: #133E87;
            --accent: #608BC1;
            --card: #CBDCEB;
            --text: #133E87;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: var(--primary);
            min-height: 100vh;
            padding: 30px 20px;
            color: var(--bg);
        }

        .sidebar h2 {
            margin-bottom: 40px;
            font-size: 24px;
            text-align: center;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            color: var(--bg);
            text-decoration: none;
            font-size: 16px;
            transition: 0.3s;
        }

        .sidebar a:hover {
            opacity: 0.8;
        }

        /* Main */
        .main {
            flex-grow: 1;
            padding: 40px;
        }

        .main h2 {
            font-size: 26px;
            margin-bottom: 20px;
        }

        /* Account Cards */
        .account-section h3 {
            margin-bottom: 20px;
            font-size: 20px;
        }

        .account-cards {
            display: flex;
            overflow-x: auto;
            gap: 20px;
            padding-bottom: 20px;
        }

        .card {
            background-color: var(--card);
            padding: 20px;
            border-radius: 16px;
            min-width: 260px;
            flex-shrink: 0;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }

        .card h4 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 14px;
            margin: 6px 0;
        }

        /* Buttons */
        .button-group {
            margin: 30px 0;
        }

        .button-group form {
            display: inline-block;
        }

        .button-group button {
            background-color: var(--accent);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            margin-right: 12px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        .button-group button:hover {
            background-color: #4e78a5;
        }

        /* Transaction Table */
        .transaction-section h3 {
            font-size: 20px;
            margin-top: 40px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid var(--accent);
        }

        th {
            background-color: var(--card);
            color: var(--primary);
            text-align: left;
        }

        tr:last-child td {
            border-bottom: none;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }

            .main {
                padding: 20px;
            }

            .account-cards {
                flex-direction: column;
            }

            table {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2><i class="fa-solid fa-university"></i> MyBank</h2>
    <a href="#"><i class="fa-solid fa-chart-line"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/transferOwn"><i class="fa-solid fa-arrow-right-arrow-left"></i> Transfer (Own)</a>
    <a href="${pageContext.request.contextPath}/transferOther"><i class="fa-solid fa-right-left"></i> Transfer (Other)</a>
    <a href="#"><i class="fa-solid fa-user"></i> Profile</a>
    <a href="#" onclick="showLogoutConfirm(event)"><i class="fa-solid fa-sign-out-alt"></i> Logout</a>
</div>

<div class="main">
    <h2>Welcome, ${customer.fullName}!</h2>

    <div class="account-section">
        <h3>Your Bank Accounts</h3>
        <div class="account-cards">
            <c:forEach var="acc" items="${accounts}">
                <div class="card">
                    <h4><i class="fa-solid fa-wallet"></i> Account #: ${acc.accountNumber}</h4>
                    <p><strong>Type:</strong> ${acc.accountType}</p>
                    <p><strong>Balance:</strong> LKR. ${acc.balance}</p>
                    <p><strong>Created:</strong> ${acc.createdAt}</p>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="button-group">
        <form action="${pageContext.request.contextPath}/transferOwn" method="GET">
            <button type="submit"><i class="fa-solid fa-arrow-right-arrow-left"></i> Transfer to Own Account</button>
        </form>
        <form action="${pageContext.request.contextPath}/transferOther" method="GET">
            <button type="submit"><i class="fa-solid fa-right-left"></i> Transfer to Other Account</button>
        </form>
    </div>

    <div class="transaction-section">
        <h3>Your Transaction History</h3>
        <table>
            <thead>
            <tr>
                <th>From Account</th>
                <th>To Account</th>
                <th>Amount (LKR)</th>
                <th>Type</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="txn" items="${transactions}">
                <tr>
                    <td>${txn.fromAccount.accountNumber}</td>
                    <td>${txn.toAccount.accountNumber}</td>
                    <td>${txn.amount}</td>
                    <td>${txn.type}</td>
                    <td>${txn.timestamp}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Logout Modal -->
<div id="logoutModal" style="
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background-color: rgba(0,0,0,0.6);
    z-index: 1000;
    justify-content: center;
    align-items: center;
">
    <div style="
        background: white;
        padding: 30px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    ">
        <h3>Are you sure you want to log out?</h3>
        <div style="margin-top: 20px;">
            <form action="${pageContext.request.contextPath}/logout" method="POST" style="display:inline;">
                <button type="submit" style="
                    background-color: var(--primary);
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 6px;
                    font-weight: bold;
                    cursor: pointer;
                ">Yes</button>
            </form>
            <button onclick="hideLogoutConfirm()" style="
                background-color: #ccc;
                color: black;
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                margin-left: 10px;
                cursor: pointer;
            ">Cancel</button>
        </div>
    </div>
</div>

<script>
    function showLogoutConfirm(event) {
        event.preventDefault();
        document.getElementById('logoutModal').style.display = 'flex';
    }

    function hideLogoutConfirm() {
        document.getElementById('logoutModal').style.display = 'none';
    }
</script>
</body>
</html>
