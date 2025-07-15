<%@ page import="javax.naming.InitialContext" %>
<%@ page import="lk.jiat.bank.core.service.CustomerService" %>
<%@ page import="lk.jiat.bank.core.entities.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.bank.core.service.AccountService" %>
<%@ page import="lk.jiat.bank.core.entities.BankAccount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #113F67;
            --secondary: #34699A;
            --accent: #58A0C8;
            --highlight: #FDF5AA;
            --white: #ffffff;
            --light-bg: #f0f7ff;
            --gray: #ddd;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--light-bg);
            color: #222;
        }

        header {
            background-color: var(--primary);
            color: var(--highlight);
            padding: 20px 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
        }

        .container {
            padding: 30px 40px;
        }

        .card-container {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            flex: 1;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            color: var(--highlight);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .card h3 {
            margin: 0 0 10px;
        }

        .card p {
            font-size: 20px;
            font-weight: bold;
        }

        .btn {
            padding: 24px 28px;
            font-size: 16px;
            font-weight: bold;
            color: var(--white);
            background: linear-gradient(135deg, var(--accent), var(--secondary));
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .btn:hover {
            background: linear-gradient(135deg, var(--secondary), var(--primary));
            transform: scale(1.05);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.3);
        }

        .actions {
            display: flex;
            gap: 25px;
            margin-bottom: 40px;
        }

        .section-title {
            color: var(--primary);
            margin: 30px 0 10px;
        }

        .table-container {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow: hidden;
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        th {
            background-color: var(--accent);
            color: var(--white);
            text-align: left;
            padding: 12px;
            position: sticky;
            top: 0;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid var(--gray);
        }

        tr:nth-child(even) {
            background-color: #f4faff;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-deactivated {
            color: red;
            font-weight: bold;
        }

        td form {
            display: inline;
        }

        .footer {
            padding: 20px;
            text-align: center;
            font-size: 14px;
            color: #777;
        }

        /* Scrollbar Styling */
        .table-container::-webkit-scrollbar {
            width: 8px;
        }

        .table-container::-webkit-scrollbar-thumb {
            background-color: var(--accent);
            border-radius: 10px;
        }

        .table-container::-webkit-scrollbar-track {
            background-color: #e0eaf5;
        }
    </style>
</head>
<body>

<header>
    <h1>Admin Dashboard</h1>
</header>

<div class="container">

    <%
        InitialContext ctx = new InitialContext();

        CustomerService customerService = (CustomerService) ctx.lookup("lk.jiat.bank.core.service.CustomerService");
        AccountService accountService = (AccountService) ctx.lookup("lk.jiat.bank.core.service.AccountService");

        List<Customer> customerList = customerService.getAllUsers();

        int totalAccounts = accountService.getTotalAccountCount();
        double totalBalance = accountService.getTotalBalance();
        double monthlyBalance = accountService.getMonthlyCollection();

        List<BankAccount> accountList = accountService.getAllAccounts();
    %>

    <!-- Summary Cards -->
    <div class="card-container">
        <div class="card">
            <h3>Total Accounts</h3>
            <p><%= totalAccounts %></p>
        </div>
        <div class="card">
            <h3>Total Collection</h3>
            <p>Rs. <%= totalBalance %></p>
        </div>
        <div class="card">
            <h3>Monthly Collection</h3>
            <p>Rs. <%= monthlyBalance %></p>
        </div>
    </div>

    <!-- Buttons -->
    <div class="actions">
        <form action="admin_create_account.jsp" method="get">
            <button type="submit" class="btn">Create New Account</button>
        </form>
        <form action="customer_form.jsp" method="get">
            <button type="submit" class="btn">Register New Customer</button>
        </form>
    </div>

    <!-- Account List -->
    <h2 class="section-title">Account Details</h2>
    <div class="table-container">
        <table>
            <tr>
                <th>Account Number</th>
                <th>Customer Name</th>
                <th>Account Type</th>
                <th>Balance</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                for (BankAccount acc : accountList) {
            %>
            <tr>
                <td><%= acc.getAccountNumber() %></td>
                <td><%= acc.getCustomer().getFullName() %></td>
                <td><%= acc.getAccountType() %></td>
                <td>Rs. <%= acc.getBalance() %></td>
                <td class="<%= acc.isActive() ? "status-active" : "status-deactivated" %>">
                    <%= acc.isActive() ? "Active" : "Deactivated" %>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/toggleAccountStatus" method="post">
                        <input type="hidden" name="accountNumber" value="<%= acc.getAccountNumber() %>" />
                        <button type="submit" class="icon-btn" title="<%= acc.isActive() ? "Deactivate" : "Activate" %>">
                            <i class="fa-solid <%= acc.isActive() ? "fa-user-slash" : "fa-user-check" %>"></i>
                        </button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <!-- Customer List -->
    <h2 class="section-title">Customer List</h2>
    <div class="table-container">
        <table>
            <tr>
                <th>Full Name</th>
                <th>Mobile No</th>
                <th>Address</th>
            </tr>
            <%
                for (Customer customer : customerList) {
            %>
            <tr>
                <td><%= customer.getFullName() %></td>
                <td><%= customer.getPhone() %></td>
                <td><%= customer.getAddress() %></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>



</div>

<div class="footer">
    &copy; 2025 JIAT Bank. All rights reserved.
</div>

</body>
</html>
