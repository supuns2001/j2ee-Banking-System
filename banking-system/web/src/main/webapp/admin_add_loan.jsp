<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, lk.jiat.bank.core.entities.Customer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Loan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
            min-height: 100vh;
        }

        .card {
            background: #ffffff;
            padding: 35px 40px;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 600px;
        }

        h2 {
            text-align: center;
            color: #113F67;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #113F67;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px 14px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #f9f9f9;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        button {
            width: 100%;
            background: #113F67;
            color: #ffffff;
            padding: 14px;
            font-weight: bold;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #34699A;
        }

        .icon-label {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 6px;
            color: #58A0C8;
        }

        .icon-label i {
            font-size: 16px;
        }
    </style>
</head>
<body>

<div class="card">
    <h2><i class="fa-solid fa-hand-holding-dollar"></i> Add New Loan</h2>

    <form action="${pageContext.request.contextPath}/addLoan" method="post">

        <div class="form-group">
            <div class="icon-label"><i class="fa-solid fa-user"></i><label for="customerId">Select Customer</label></div>
            <select name="customerId" id="customerId" required>
                <option value="">-- Select Customer --</option>
                <c:forEach var="c" items="${customers}">
                    <option value="${c.id}">${c.fullName} (${c.email})</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <div class="icon-label"><i class="fa-solid fa-layer-group"></i><label for="loanType">Loan Type</label></div>
            <select name="loanType" id="loanType" required>
                <option value="">-- Select Type --</option>
                <c:forEach var="t" items="${loanTypes}">
                    <option value="${t}">${t}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <div class="icon-label"><i class="fa-solid fa-money-bill-wave"></i><label for="principal">Principal Amount (Rs.)</label></div>
            <input type="text" name="principal" id="principal" required />
        </div>

        <div class="form-group">
            <div class="icon-label"><i class="fa-solid fa-calendar-check"></i><label for="monthlyInstallment">Monthly Installment (Rs.)</label></div>
            <input type="text" name="monthlyInstallment" id="monthlyInstallment" required />
        </div>

        <div class="form-group">
            <div class="icon-label"><i class="fa-solid fa-note-sticky"></i><label for="description">Description</label></div>
            <textarea name="description" id="description"></textarea>
        </div>

        <button type="submit"><i class="fa-solid fa-circle-check"></i> Submit Loan</button>
    </form>
</div>

</body>
</html>
