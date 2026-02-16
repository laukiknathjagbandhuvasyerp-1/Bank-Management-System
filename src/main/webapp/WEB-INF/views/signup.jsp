<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .signup-box {
            background: #fff;
            width: 100%;
            max-width: 420px;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-15px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            border: 2px solid #ddd;
            font-size: 15px;
            transition: 0.3s;
        }

        input:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(102,126,234,0.4);
        }

        .footer {
            text-align: center;
            margin-top: 18px;
            font-size: 14px;
            color: #666;
        }

        .footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="signup-box">
    <h2>Create Account</h2>

    <form action="/signup" method="post">

        <div class="form-group">
            <label>Username</label>
            <input type="text" name="userName" placeholder="Enter username" required />
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required />
        </div>

        <button type="submit">Sign Up</button>
    </form>

    <div class="footer">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Login</a>
    </div>
</div>

</body>
</html>
