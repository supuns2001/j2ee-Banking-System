<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transfer Between Your Accounts</title>
    <style>
        :root {
            --primary: #555879;
            --secondary: #98A1BC;
            --bg-light: #F4EBD3;
            --card-bg: #DED3C4;
            --error: #e74c3c;
            --button: #555879;
            --button-hover: #3e405b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-light);
            color: var(--primary);
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        .container {
            max-width: 600px;
            width: 100%;
            background-color: var(--card-bg);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 12px rgba(85, 88, 121, 0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: var(--primary);
        }

        label {
            display: block;
            margin-top: 18px;
            font-weight: 600;
        }

        select,
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            background-color: white;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            margin-top: 30px;
            width: 100%;
            background-color: var(--button);
            color: var(--bg-light);
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: var(--button-hover);
        }

        .error {
            margin-top: 15px;
            color: var(--error);
            font-size: 14px;
            background-color: #fff2f2;
            padding: 10px;
            border-left: 4px solid var(--error);
            border-radius: 6px;
        }

        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }

            input[type="submit"] {
                font-size: 15px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>

<div class="container">
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
        <textarea id="note" name="note" rows="3" placeholder="Optional note..."></textarea>

        <input type="submit" value="Transfer">
    </form>
</div>

</body>
</html>
