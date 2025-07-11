<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 7/9/2025
  Time: 2:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Add New Customer</h2>
<form method="post" action="customers">
  Name: <input type="text" name="name"/><br/>
  Email: <input type="text" name="email"/><br/>
  Email: <input type="password" name="password"/><br/>
  Phone: <input type="text" name="phone"/><br/>
  Address: <input type="text" name="address"/><br/>
  <input type="submit" value="Create Customer"/>
</form>


</body>
</html>
