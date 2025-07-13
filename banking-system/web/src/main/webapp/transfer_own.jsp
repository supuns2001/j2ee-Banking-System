<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Transfer Between Your Own Accounts</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f9f9f9;
        }

        h2 {
            margin-bottom: 20px;
        }

        form {
            max-width: 500px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        select,
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            margin-top: 20px;
            background-color: #007bff;
            border: none;
            padding: 10px 20px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<h2>Transfer Between Your Own Accounts</h2>

<c:if test="${not empty errorMessage}">
    <div class="error">${errorMessage}</div>
</c:if>

<form method="POST" action="${pageContext.request.contextPath}/transferOwn">

    <label for="sourceAccount">From Account:</label>
    <select id="sourceAccount" name="sourceAccount" required>
        <option value="">-- Select source account --</option>
        <c:forEach var="acc" items="${myAccounts}">
            <option value="${acc.accountNumber}">
                    ${acc.accountNumber} - LKR ${acc.balance}
            </option>
        </c:forEach>
    </select>

    <label for="targetAccount">To Account:</label>
    <select id="targetAccount" name="targetAccount" required>
        <option value="">-- Select target account --</option>
        <c:forEach var="acc" items="${myAccounts}">
            <option value="${acc.accountNumber}">
                    ${acc.accountNumber} - LKR ${acc.balance}
            </option>
        </c:forEach>
    </select>

    <label for="amount">Amount (LKR):</label>
    <input type="number" id="amount" name="amount" step="0.01" min="0.01" required />

    <label for="note">Note (optional):</label>
    <textarea id="note" name="note" rows="4" placeholder="Optional note..."></textarea>

    <input type="submit" value="Transfer">
</form>

</body>
</html>
