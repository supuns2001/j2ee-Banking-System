<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F4EBD3;
            color: #555879;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 240px;
            background-color: #555879;
            min-height: 100vh;
            padding: 30px 20px;
            color: #F4EBD3;
        }

        .sidebar h2 {
            margin-bottom: 40px;
            font-size: 22px;
            text-align: center;
        }

        .sidebar a {
            display: block;
            margin-bottom: 20px;
            color: #F4EBD3;
            text-decoration: none;
            font-size: 16px;
            transition: opacity 0.3s;
        }

        .sidebar a:hover {
            opacity: 0.7;
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
            background-color: #DED3C4;
            padding: 20px;
            border-radius: 16px;
            min-width: 260px;
            flex-shrink: 0;
            box-shadow: 0 6px 12px rgba(85, 88, 121, 0.2);
        }

        .card h4 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 14px;
            margin: 6px 0;
            color: #555879;
        }

        /* Buttons */
        .button-group {
            margin: 30px 0;
        }

        .button-group form {
            display: inline-block;
        }

        .button-group button {
            background-color: #555879;
            color: #F4EBD3;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            margin-right: 12px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .button-group button:hover {
            background-color: #3e405b;
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
            box-shadow: 0 4px 10px rgba(85, 88, 121, 0.15);
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid #98A1BC;
        }

        th {
            background-color: #98A1BC;
            color: white;
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
    <h2>MyBank</h2>
    <a href="#">Dashboard</a>
    <a href="${pageContext.request.contextPath}/transferOwn">Transfer (Own)</a>
    <a href="${pageContext.request.contextPath}/transferOther">Transfer (Other)</a>
    <a href="#">Profile</a>
    <a href="#">Logout</a>
</div>

<div class="main">
    <h2>Welcome, ${customer.fullName}!</h2>

    <div class="account-section">
        <h3>Your Bank Accounts</h3>
        <div class="account-cards">
            <c:forEach var="acc" items="${accounts}">
                <div class="card">
                    <h4>Account #: ${acc.accountNumber}</h4>
                    <p><strong>Type:</strong> ${acc.accountType}</p>
                    <p><strong>Balance:</strong> $${acc.balance}</p>
                    <p><strong>Created:</strong> ${acc.createdAt}</p>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="button-group">
        <form action="${pageContext.request.contextPath}/transferOwn" method="GET">
            <button type="submit">Transfer to Own Account</button>
        </form>
        <form action="${pageContext.request.contextPath}/transferOther" method="GET">
            <button type="submit">Transfer to Other Account</button>
        </form>
    </div>

    <div class="transaction-section">
        <h3>Your Transaction History</h3>
        <table>
            <thead>
            <tr>
                <th>From Account</th>
                <th>To Account</th>
                <th>Amount</th>
                <th>Type</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="txn" items="${transactions}">
                <tr>
                    <td>${txn.fromAccount.accountNumber}</td>
                    <td>${txn.toAccount.accountNumber}</td>
                    <td>$${txn.amount}</td>
                    <td>${txn.type}</td>
                    <td>${txn.timestamp}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
