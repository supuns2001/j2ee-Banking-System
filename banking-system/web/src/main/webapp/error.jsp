<%@ page isErrorPage="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Error Occurred</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <style>
    :root {
      --primary: #113F67;
      --secondary: #34699A;
      --accent: #58A0C8;
      --highlight: #FDF5AA;
      --glass: rgba(255, 255, 255, 0.08);
      --white: #ffffff;
    }

    body {
      margin: 0;
      padding: 0;
      background: linear-gradient(to right, var(--primary), var(--secondary));
      font-family: 'Segoe UI', sans-serif;
      color: var(--white);
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      background-attachment: fixed;
    }

    .error-box {
      background: var(--glass);
      padding: 35px 40px;
      border-radius: 16px;
      border: 1px solid var(--accent);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
      max-width: 600px;
      width: 90%;
      backdrop-filter: blur(12px);
    }

    .error-box h2 {
      color: var(--highlight);
      font-size: 26px;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
    }

    .error-box h2 i {
      margin-right: 12px;
      color: var(--highlight);
    }

    .error-box p {
      font-size: 15px;
      line-height: 1.6;
      margin: 10px 0;
    }

    .error-box p strong {
      color: var(--accent);
    }

    a {
      display: inline-block;
      margin-top: 20px;
      background: var(--highlight);
      color: var(--primary);
      padding: 10px 16px;
      border-radius: 8px;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s ease;
    }

    a:hover {
      background: var(--accent);
      color: var(--white);
    }
  </style>
</head>
<body>

<div class="error-box">
  <h2><i class="fa-solid fa-triangle-exclamation"></i> Oops! Something went wrong</h2>
  <p><strong>Error Message:</strong> ${jakarta.servlet.error.message}</p>
  <p><strong>Exception Type:</strong> ${jakarta.servlet.error.exceptionType}</p>
  <p><strong>Exception:</strong> ${jakarta.servlet.error.exception}</p>
  <p><strong>Requested URI:</strong> ${jakarta.servlet.error.request_uri}</p>
  <a href="<%= request.getContextPath() %>/index.jsp">
    <i class="fa-solid fa-house"></i> Back to Home
  </a>
</div>

</body>
</html>
