<%@ page import="javax.naming.InitialContext" %>
<%@ page import="lk.jiat.bank.core.service.CustomerService" %>
<%@ page import="lk.jiat.bank.core.entities.Customer" %>
<%@ page import="java.util.List" %>
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
</style>

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
</body>
</html>
