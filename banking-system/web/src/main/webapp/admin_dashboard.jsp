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
</head>
<body>
<h1> Admin Dashboard</h1>

<%
    InitialContext ctx = new InitialContext();
    CustomerService customerService = (CustomerService) ctx.lookup("lk.jiat.bank.core.service.CustomerService");
    List<Customer> customerList = customerService.getAllUsers();
%>

<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        border: 1px solid #333;
        padding: 8px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    form {
        margin-top: 30px;
    }

    label {
        display: block;
        margin-top: 10px;
        font-weight: bold;
    }

    input, select {
        padding: 6px;
        width: 300px;
    }

    button {
        margin-top: 15px;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }
</style>

<div style="display: flex; gap: 20px; margin-bottom: 20px;">
    <form action="admin_create_account.jsp" method="get">
        <button type="submit">Create Customer New Account</button>
    </form>

    <form action="customer_form.jsp" method="get">
        <button type="submit">Register New Customer</button>
    </form>
</div>

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

<%
    // Lookup AccountService
    AccountService accountService = (AccountService) ctx.lookup("lk.jiat.bank.core.service.AccountService");
    List<BankAccount> accountList = accountService.getAllAccounts();
%>

<h2>Account Details</h2>
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
        <td><%= acc.getBalance() %></td>
        <td><%= acc.isActive() ? "Active" : "Deactivated" %></td>
        <td>
            <form action="${pageContext.request.contextPath}/toggleAccountStatus" method="post" style="display:inline;">
            <input type="hidden" name="accountNumber" value="<%= acc.getAccountNumber() %>" />
                <button type="submit">
                    <%= acc.isActive() ? "Deactivate" : "Activate" %>
                </button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>


</body>
</html>
