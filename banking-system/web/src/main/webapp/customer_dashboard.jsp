<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px 0;
            font-family: Arial, sans-serif;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        h2, h3 {
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>

<h2>Welcome, ${customer.fullName}!</h2>

<h3>Your Bank Accounts</h3>
<table>
    <thead>
    <tr>
        <th>Account Number</th>
        <th>Type</th>
        <th>Balance</th>
        <th>Created At</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="acc" items="${accounts}">
        <tr>
            <td>${acc.accountNumber}</td>
            <td>${acc.accountType}</td>
            <td>${acc.balance}</td>
            <td>${acc.createdAt}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div style="margin-bottom: 20px;">
    <form action="${pageContext.request.contextPath}/transferOwn" method="GET" style="display: inline;">
        <button type="submit" style="padding: 10px 20px; margin-right: 10px;">Transfer to Own Account</button>
    </form>

    <form action="${pageContext.request.contextPath}/transferOther" method="GET" style="display: inline;">
        <button type="submit" style="padding: 10px 20px;">Transfer to Other Account</button>
    </form>
</div>

</body>
</html>
