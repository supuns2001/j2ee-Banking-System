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
</head>
<body>

<h1>Create New Bank Account</h1>

<form action="CreateAccountServlet" method="post">
    <label for="customerId">Select Customer:</label>
    <select name="customerId" id="customerId" required>
        <option value="">-- Select Customer --</option>
        <%
            for (Customer customer : customerList) {
        %>
        <option value="<%= customer.getId() %>"><%= customer.getFullName() %> (<%= customer.getEmail() %>)</option>
        <%
            }
        %>
    </select>
    <br><br>

    <label for="accountNumber">Account Number:</label>
    <input type="text" name="accountNumber" id="accountNumber" required />
    <br><br>

    <label for="accountType">Account Type:</label>
    <select name="accountType" id="accountType" required>
        <option value="">-- Select Type --</option>
        <option value="SAVINGS">Savings</option>
        <option value="CURRENT">Current</option>
        <option value="FIXED">Current</option>
    </select>
    <br><br>

    <label for="balance">Initial Balance:</label>
    <input type="number" step="0.01" name="balance" id="balance" required />
    <br><br>
    <label for="interestRate">Annual Interest Rate (%):</label>
    <input type="number" step="0.01" name="interestRate" id="interestRate" required />
    <br><br>

    <button type="submit">Create Account</button>
</form>

</body>
</html>
