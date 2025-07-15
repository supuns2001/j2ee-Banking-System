<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root {
            --primary: #113F67;
            --secondary: #34699A;
            --accent: #58A0C8;
            --highlight: #FDF5AA;
            --white: #ffffff;
            --glass: rgba(255, 255, 255, 0.08);
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            /*background-color: var(--primary);*/
            /*background-image: linear-gradient(135deg, #113F67, #34699A);*/
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--white);
        }

        .login-wrapper {
            /*background: var(--glass);*/
            background-color: var(--primary);
            border-radius: 18px;
            padding: 50px 40px;
            width: 100%;
            max-width: 420px;
            backdrop-filter: blur(12px);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header i {
            font-size: 48px;
            color: var(--highlight);
            margin-bottom: 12px;
        }

        .login-header h1 {
            font-size: 24px;
            color: var(--highlight);
            margin: 10px 0 6px;
        }

        .login-header p {
            font-size: 14px;
            color: #d4e4f0;
        }

        .form-group {
            margin-bottom: 22px;
            position: relative;
        }

        .form-group i {
            position: absolute;
            top: 50%;
            left: 14px;
            transform: translateY(-50%);
            color: var(--accent);
        }

        .form-group input {
            width: 100%;
            padding: 12px 12px 12px 42px;
            border-radius: 10px;
            border: 1px solid var(--accent);
            font-size: 15px;
            background: #1d2b4e;
            color: var(--white);
        }

        .form-group input::placeholder {
            color: #b0c4de;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--highlight);
            background: #22335c;
        }

        .login-btn {
            background: var(--highlight);
            color: var(--primary);
            font-weight: bold;
            border: none;
            padding: 13px;
            width: 100%;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .login-btn i {
            margin-right: 8px;
        }

        .login-btn:hover {
            background: var(--accent);
            color: var(--white);
        }

        .credit {
            text-align: center;
            margin-top: 25px;
            font-size: 12px;
            color: #bcd9f3;
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="login-header">
        <i class="fa-solid fa-building-columns"></i>
        <h1>Admin Login</h1>
        <p>Access your banking admin dashboard</p>
    </div>

    <form method="POST" action="${pageContext.request.contextPath}/admin_login">
        <div class="form-group">
            <i class="fa-solid fa-envelope"></i>
            <input type="text" name="email" placeholder="Email Address" required />
        </div>
        <div class="form-group">
            <i class="fa-solid fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required />
        </div>
        <button type="submit" class="login-btn">
            <i class="fa-solid fa-right-to-bracket"></i> Login
        </button>
    </form>

    <div class="credit">
        &copy; 2025 SmartBank Admin Portal
    </div>
</div>

</body>
</html>
