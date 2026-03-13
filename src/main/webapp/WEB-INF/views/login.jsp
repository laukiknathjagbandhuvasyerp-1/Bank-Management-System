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
        * { margin: 0; padding: 0; box-sizing: border-box; }

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
            from { opacity: 0; transform: translateY(-20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        h2 { text-align: center; margin-bottom: 30px; color: #333; font-size: 28px; font-weight: 600; }

        .form-group { margin-bottom: 20px; }

        input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s ease;
            outline: none;
        }

        input:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }

        input::placeholder { color: #999; }

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

        button:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        button:active { transform: translateY(0); }

        .error-msg {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #c33;
            font-size: 14px;
            display: none;
        }

        .footer { margin-top: 25px; text-align: center; font-size: 14px; color: #666; }

        .footer a { color: #667eea; text-decoration: none; font-weight: 600; }

        .footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<script>
// If already logged in, skip login page
(function() {
    const token = localStorage.getItem("jwt");
    if (token) {
        window.location.href = "/customer/view";
    }
})();
</script>

<div class="login-box">
    <h2>Welcome Back</h2>

    <div class="error-msg" id="errorMsg">Invalid username or password</div>

    <div class="form-group">
        <input type="text" id="username" placeholder="Username" required />
    </div>

    <div class="form-group">
        <input type="password" id="password" placeholder="Password" required />
    </div>

    <input type="hidden" id="redirectUrl" value="${param.redirect}">

    <button onclick="login()">Sign In</button>

    <div class="footer">
        <p>Don't have an account? <a href="/signup">Register here</a></p>
    </div>
</div>

<script>

function login() {
    const username    = document.getElementById("username").value.trim();
    const password    = document.getElementById("password").value;
    const errorMsg    = document.getElementById("errorMsg");
    errorMsg.style.display = "none";

    if (!username || !password) {
        errorMsg.textContent = "Please enter username and password.";
        errorMsg.style.display = "block";
        return;
    }

    fetch("/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: username, password: password })
    })
    .then(res => {
        if (!res.ok) throw new Error("Invalid credentials");
        return res.json();
    })
    .then(data => {
        localStorage.setItem("jwt", data.token);
        const redirectUrl = document.getElementById("redirectUrl").value;
        window.location.href = redirectUrl || "/customer/view";
    })
    .catch(() => {
        errorMsg.textContent = "Invalid username or password.";
        errorMsg.style.display = "block";
    });
}
</script>
</body>
</html>