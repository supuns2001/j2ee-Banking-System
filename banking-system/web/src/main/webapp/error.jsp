<!-- File: error.jsp -->
<%@ page isErrorPage="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Error Page</title>
  <style>
    body { font-family: Arial; background: #ffe6e6; padding: 30px; }
    .error-box { background: #fff; border: 1px solid #cc0000; padding: 20px; border-radius: 5px; }
    h2 { color: #cc0000; }
  </style>
</head>
<body>
<div class="error-box">
  <h2>Oops! Something went wrong</h2>
  <p><strong>Error Message:</strong> ${jakarta.servlet.error.message}</p>
  <p><strong>Exception Type:</strong> ${jakarta.servlet.error.exceptionType}</p>
  <p><strong>Exception:</strong> ${jakarta.servlet.error.exception}</p>
  <p><strong>Requested URI:</strong> ${jakarta.servlet.error.request_uri}</p>
  <p><a href="<%= request.getContextPath() %>/index.jsp">Go back to home</a></p>
</div>
</body>
</html>
