<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Secure App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-box {
            width: 100%;
            max-width: 400px;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 28px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 12px 15px;
            margin: 0;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s ease;
            outline: none;
        }

        input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        input::placeholder {
            color: #999;
        }

        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        .error {
            background-color: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #c33;
            font-size: 14px;
            animation: shake 0.5s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .error:before {
            content: "✕";
            font-weight: bold;
            font-size: 16px;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .msg {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #2e7d32;
            font-size: 14px;
            animation: slideDown 0.5s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .msg:before {
            content: "✓";
            font-weight: bold;
            font-size: 16px;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .footer {
            margin-top: 25px;
            text-align: center;
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

        /* Responsive design */
        @media (max-width: 480px) {
            .login-box {
                padding: 30px 20px;
            }

            h2 {
                font-size: 24px;
            }

            input, button {
                padding: 10px;
            }
        }

        /* Remove spinner from number inputs */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Welcome Back</h2>

    <!-- Login error message -->
    <c:if test="${param.error != null}">
        <div class="error">Invalid username or password</div>
    </c:if>

    <!-- Logout success message -->
    <c:if test="${param.logout != null}">
        <div class="msg">Logged out successfully</div>
    </c:if>

    <form method="post" action="/login">
        <div class="form-group">
            <input type="text" name="username" placeholder="Username" required />
        </div>

        <div class="form-group">
            <input type="password" name="password" placeholder="Password" required />
        </div>

        <input type="hidden" name="redirect" value="${param.redirect}" >

        <button type="submit">Sign In</button>
    </form>

    <div class="footer">
        <p> Not have account ?<a href="/signup">Register here</a> </p>
    </div>
</div>

</body>
</html>