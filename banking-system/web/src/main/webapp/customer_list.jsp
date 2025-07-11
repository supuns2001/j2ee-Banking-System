<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="lk.jiat.bank.core.entities.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="lk.jiat.bank.core.service.CustomerService" %>
<%@ page import="javax.naming.NamingException" %>

<html>
<body>
<h2>Customer List</h2>

<%
    try {
        InitialContext ic = new InitialContext();
        CustomerService customerservice = (CustomerService) ic.lookup("lk.jiat.bank.core.service.CustomerService");
        List<Customer> customers = customerservice.getAllCustomers();
        pageContext.setAttribute("customers", customers); // Fixed: changed "cus" to "customers"
    } catch (NamingException e) {
        throw new RuntimeException(e);
    }
%>

<table>
    <tr>
        <th>Full name</th>
        <th>Mobile Number</th>
        <th>Address</th>
    </tr>
    <c:forEach var="customer" items="${customers}"> <!-- Fixed: changed var name to "customer" -->
        <tr>
            <td>${customer.fullName}</td>     <!-- Fixed: use proper customer properties -->
            <td>${customer.phone}</td>
            <td>${customer.address}</td>
        </tr>
    </c:forEach>
</table>

<a href="customer_form.jsp">Add New Customer</a>
</body>
</html>