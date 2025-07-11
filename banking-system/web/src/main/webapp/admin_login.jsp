<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 7/11/2025
  Time: 12:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin login</title>
</head>
<body>

<h1>Admin login</h1>

<form method="POST" action="${pageContext.request.contextPath}/admin_login">
    <table>
        <tr>
            <th>Email</th>
            <td>
                <input type="text" name="email"/>
            </td>
        </tr>
        <tr>
            <th>Password</th>
            <td>
                <input type="password" name="password"/>
            </td>
        </tr>
        <tr>
            <td><input type="submit" value="Login"></td>
        </tr>
    </table>
</form>


</body>
</html>
