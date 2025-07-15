<%@ page import="lk.jiat.bank.core.entities.Customer" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="lk.jiat.bank.core.service.CustomerService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    InitialContext ctx = new InitialContext();
    CustomerService customerService = (CustomerService) ctx.lookup("lk.jiat.bank.core.service.CustomerService");
    List<Customer> customerList = customerService.getAllUsers();
%>

<html>
<head>
    <title>Create Bank Account</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --primary: #113F67;
            --secondary: #34699A;
            --accent: #58A0C8;
            --highlight: #FDF5AA;
            --white: #ffffff;
            --gray-light: #f4f4f4;
            --gray-dark: #444;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--gray-light);
            color: var(--primary);
            margin: 0;
            padding: 40px;
        }

        h1 {
            text-align: center;
            color: var(--secondary);
            margin-bottom: 30px;
        }

        form {
            max-width: 600px;
            margin: 0 auto;
            background: var(--white);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 20px 0 5px;
            font-weight: 600;
        }

        input, select {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .form-group {
            position: relative;
        }

        .form-group i {
            position: absolute;
            left: 10px;
            top: 40px;
            color: var(--accent);
        }

        input, select {
            padding-left: 35px;
        }

        button {
            margin-top: 25px;
            width: 100%;
            background: linear-gradient(to right, var(--accent), var(--secondary));
            color: var(--white);
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        button:hover {
            background: linear-gradient(to right, var(--secondary), var(--primary));
            transform: scale(1.03);
        }

        select:invalid,
        input:invalid {
            color: #999;
        }
    </style>
</head>
<body>

<h1><i class="fa-solid fa-university"></i> Create New Bank Account</h1>

<form action="CreateAccountServlet" method="post">

    <div class="form-group">
        <label for="customerId"><i class="fa-solid fa-user"></i> Select Customer</label>
        <select name="customerId" id="customerId" required>
            <option value="">-- Select Customer --</option>
            <%
                for (Customer customer : customerList) {
            %>
            <option value="<%= customer.getId() %>">
                <%= customer.getFullName() %> (<%= customer.getEmail() %>)
            </option>
            <%
                }
            %>
        </select>
    </div>

    <div class="form-group">
        <label for="accountNumber"><i class="fa-solid fa-hashtag"></i> Account Number</label>
        <input type="text" name="accountNumber" id="accountNumber" required />
    </div>

    <div class="form-group">
        <label for="accountType"><i class="fa-solid fa-layer-group"></i> Account Type</label>
        <select name="accountType" id="accountType" required>
            <option value="">-- Select Type --</option>
            <option value="SAVINGS">Savings</option>
            <option value="CURRENT">Current</option>
            <option value="FIXED">Fixed</option>
        </select>
    </div>

    <div class="form-group">
        <label for="balance"><i class="fa-solid fa-money-bill-wave"></i> Initial Balance (Rs.)</label>
        <input type="number" step="0.01" name="balance" id="balance" required />
    </div>

    <div class="form-group">
        <label for="interestRate"><i class="fa-solid fa-percent"></i> Annual Interest Rate (%)</label>
        <input type="number" step="0.01" name="interestRate" id="interestRate" required />
    </div>

    <button type="submit"><i class="fa-solid fa-check-circle"></i> Create Account</button>
</form>

</body>
</html>
