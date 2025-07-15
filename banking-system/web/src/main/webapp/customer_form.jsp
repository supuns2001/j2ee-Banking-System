<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Register Customer</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
    :root {
      --primary: #113F67;
      --secondary: #34699A;
      --accent: #58A0C8;
      --highlight: #FDF5AA;
      --white: #ffffff;
      --gray-light: #f7f9fb;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: var(--gray-light);
      color: var(--primary);
      margin: 0;
      padding: 40px;
    }

    h2 {
      text-align: center;
      color: var(--secondary);
      margin-bottom: 30px;
    }

    form {
      max-width: 600px;
      margin: 0 auto;
      background: var(--white);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }

    .form-group {
      position: relative;
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 600;
    }

    .form-group i {
      position: absolute;
      left: 10px;
      top: 40px;
      color: var(--accent);
    }

    input {
      width: 100%;
      padding: 12px 12px 12px 35px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
    }

    button {
      margin-top: 25px;
      width: 100%;
      background: linear-gradient(to right, var(--accent), var(--secondary));
      color: var(--white);
      padding: 14px;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s ease, transform 0.2s ease;
    }

    button:hover {
      background: linear-gradient(to right, var(--secondary), var(--primary));
      transform: scale(1.03);
    }
  </style>
</head>
<body>

<h2><i class="fa-solid fa-user-plus"></i> Register New Customer</h2>

<form method="post" action="customers">
  <div class="form-group">
    <label for="name"><i class="fa-solid fa-user"></i> Full Name</label>
    <input type="text" name="name" id="name" required />
  </div>

  <div class="form-group">
    <label for="email"><i class="fa-solid fa-envelope"></i> Email</label>
    <input type="email" name="email" id="email" required />
  </div>

  <div class="form-group">
    <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
    <input type="password" name="password" id="password" required />
  </div>

  <div class="form-group">
    <label for="phone"><i class="fa-solid fa-phone"></i> Phone</label>
    <input type="text" name="phone" id="phone" required />
  </div>

  <div class="form-group">
    <label for="address"><i class="fa-solid fa-location-dot"></i> Address</label>
    <input type="text" name="address" id="address" required />
  </div>

  <button type="submit"><i class="fa-solid fa-user-plus"></i> Create Customer</button>
</form>

</body>
</html>
