<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transfer Between Your Accounts</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --primary: #133E87;
            --secondary: #608BC1;
            --bg-light: #F3F3E0;
            --card-bg: #CBDCEB;
            --error: #e74c3c;
            --button: #133E87;
            --button-hover: #0f2e65;
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
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
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

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
        }

        select,
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px 12px 12px 38px;
            margin-top: 8px;
            border: 1px solid var(--secondary);
            border-radius: 8px;
            font-size: 15px;
            background-color: white;
            color: var(--primary);
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
    <h2><i class="fas fa-random"></i> Transfer Between Your Accounts</h2>

    <c:if test="${not empty errorMessage}">
        <div class="error"><i class="fas fa-exclamation-triangle"></i> ${errorMessage}</div>
    </c:if>

    <form method="POST" action="${pageContext.request.contextPath}/transferOwn">

        <label for="sourceAccount">From Account:</label>
        <div class="input-icon">
            <i class="fas fa-wallet"></i>
            <select id="sourceAccount" name="sourceAccount" required>
                <option value="">-- Select source account --</option>
                <c:forEach var="acc" items="${myAccounts}">
                    <option value="${acc.accountNumber}">
                            ${acc.accountNumber} - LKR ${acc.balance}
                    </option>
                </c:forEach>
            </select>
        </div>

        <label for="targetAccount">To Account:</label>
        <div class="input-icon">
            <i class="fas fa-university"></i>
            <select id="targetAccount" name="targetAccount" required>
                <option value="">-- Select target account --</option>
                <c:forEach var="acc" items="${myAccounts}">
                    <option value="${acc.accountNumber}">
                            ${acc.accountNumber} - LKR ${acc.balance}
                    </option>
                </c:forEach>
            </select>
        </div>

        <label for="amount">Amount (LKR):</label>
        <div class="input-icon">
            <i class="fas fa-coins"></i>
            <input type="number" id="amount" name="amount" step="0.01" min="0.01" required />
        </div>

        <label for="note">Note (optional):</label>
        <div class="input-icon">
            <i class="fas fa-comment-dots"></i>
            <textarea id="note" name="note" rows="3" placeholder="Optional note..."></textarea>
        </div>

        <input type="submit" value="Transfer">
    </form>
</div>

</body>
</html>
