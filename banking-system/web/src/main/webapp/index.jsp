<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to MyBank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --bg-light: #F3F3E0;
            --primary: #133E87;
            --accent: #608BC1;
            --soft-blue: #CBDCEB;
            --white: #fff;
            --button-hover: #102f6a;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: var(--bg-light);
            color: var(--primary);
            line-height: 1.6;
        }

        header {
            background-color: var(--primary);
            color: var(--white);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            font-size: 26px;
        }

        header a {
            background-color: var(--accent);
            color: var(--white);
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        header a:hover {
            background-color: var(--button-hover);
        }

        .hero {
            background-color: var(--soft-blue);
            padding: 60px 20px;
            text-align: center;
        }

        .hero h2 {
            font-size: 36px;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .hero p {
            font-size: 18px;
            color: #333;
            margin-bottom: 25px;
        }

        .hero .cta-button {
            background-color: var(--primary);
            color: var(--white);
            padding: 14px 30px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .hero .cta-button:hover {
            background-color: var(--button-hover);
        }

        .news-section {
            max-width: 900px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .news-section h3 {
            font-size: 24px;
            color: var(--primary);
            border-left: 6px solid var(--accent);
            padding-left: 10px;
            margin-bottom: 20px;
        }

        .news-item {
            background-color: var(--white);
            padding: 20px;
            margin-bottom: 16px;
            border-left: 4px solid var(--primary);
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        .news-item i {
            margin-right: 10px;
            color: var(--accent);
        }

        footer {
            text-align: center;
            padding: 20px;
            background-color: var(--primary);
            color: var(--white);
            margin-top: 60px;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .hero h2 {
                font-size: 28px;
            }

            .hero p {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<header>
    <h1><i class="fa-solid fa-building-columns"></i> MyBank</h1>
    <a href="login.jsp"><i class="fa-solid fa-user"></i> Customer Login</a>
</header>

<section class="hero">
    <h2>Welcome to MyBank</h2>
    <p>Your trusted partner in digital banking and financial security.</p>
    <a href="login.jsp" class="cta-button"><i class="fa-solid fa-right-to-bracket"></i> Login to Your Account</a>
</section>

<section class="news-section">
    <h3><i class="fa-solid fa-bullhorn"></i> Bank News & Announcements</h3>

    <div class="news-item">
        <i class="fa-solid fa-star"></i>
        <strong>New Mobile App Launched!</strong> Download our upgraded mobile app for faster transactions and live notifications.
    </div>

    <div class="news-item">
        <i class="fa-solid fa-gear"></i>
        <strong>Scheduled Maintenance:</strong> Our systems will be offline on July 15 from 10:00 PM to 2:00 AM.
    </div>

    <div class="news-item">
        <i class="fa-solid fa-percent"></i>
        <strong>New Interest Rates:</strong> Fixed deposit rates have been revised. Visit your profile to check eligibility.
    </div>

</section>

<footer>
    &copy; 2025 MyBank. All rights reserved. | support@mybank.com | 011-1234567
</footer>

</body>
</html>
