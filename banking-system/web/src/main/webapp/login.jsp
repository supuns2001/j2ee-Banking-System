<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login - MyBank</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F4EBD3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #DED3C4;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 16px rgba(85, 88, 121, 0.2);
            width: 360px;
        }

        .login-container h1 {
            text-align: center;
            color: #555879;
            margin-bottom: 24px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #555879;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #98A1BC;
            border-radius: 8px;
            background-color: #F4EBD3;
            color: #555879;
            font-size: 14px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #555879;
            color: #F4EBD3;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #3e405b;
        }

        .footer {
            text-align: center;
            margin-top: 16px;
            font-size: 12px;
            color: #98A1BC;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h1>Customer Login</h1>
    <form method="POST" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" placeholder="Enter your email">
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password">
        </div>
        <input type="submit" value="Login">
    </form>
    <div class="footer">
        © 2025 MyBank. All rights reserved.
    </div>
</div>
</body>
</html>
