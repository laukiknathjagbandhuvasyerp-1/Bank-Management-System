<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bank Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 400px;
        }

        h1 {
            margin-bottom: 10px;
        }

        p {
            color: #555;
        }

        .btn {
            display: block;
            width: 100%;
            margin: 15px 0;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn.secondary {
            background: #28a745;
        }

        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Bank Management System</h1>
    <p>Manage Customers, Accounts & Loans Easily</p>

    <form method="get" action="/customer/new">
        <button type="submit" class="btn">I am a New Customer</button>
    </form>

    <form method="get" action="/customer/view">
        <button type="submit" class="btn secondary">I am an Existing Customer</button>
    </form>

</div>

</body>
</html>
