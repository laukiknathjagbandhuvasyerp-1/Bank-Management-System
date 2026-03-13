<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Add Account</title>
<style>
body {
    margin: 0; padding: 0;
    font-family: Arial;
    background: linear-gradient(to right, #667eea, #764ba2);
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.container {
    background: white;
    width: 420px;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

h2 { text-align: center; margin-bottom: 25px; }

.form-group { margin-bottom: 15px; }

label { display: block; margin-bottom: 6px; font-weight: bold; }

input, select {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

input:focus, select:focus { outline: none; border-color: #667eea; }

.btn {
    width: 100%;
    padding: 12px;
    background: #667eea;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 10px;
}

.btn:hover { background: #5a67d8; }

.back-link { text-align: center; margin-top: 15px; }

.back-link a { text-decoration: none; color: #667eea; cursor: pointer; }

.error-msg {
    color: #c33;
    background: #fee;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 15px;
    display: none;
}
</style>
</head>
<body>

<script>
(function() {
    const token = localStorage.getItem("jwt");
    if (!token) {
        alert("Please login to access this page.");
        window.location.href = "/login";
    }
})();
</script>

<div class="container">
    <h2>Add Account</h2>

    <div class="error-msg" id="errorMsg"></div>

    <div class="form-group">
        <label>Account Type</label>
        <select id="accType">
            <option value="">-- Select Type --</option>
            <option value="SAVINGS">Savings</option>
            <option value="CURRENT">Current</option>
        </select>
    </div>

    <div class="form-group">
        <label>Opening Balance (₹)</label>
        <input type="number" id="accBalance" placeholder="Enter opening balance" min="0">
    </div>

    <button class="btn" onclick="createAccount()">Create Account</button>

    <div class="back-link">
        <a onclick="goBack()">← Back to Accounts</a>
    </div>
</div>

<script>

const custId = "${custId}";

function getToken() { return localStorage.getItem("jwt"); }

function showError(msg) {
    const el = document.getElementById("errorMsg");
    el.textContent = msg;
    el.style.display = "block";
}

function handleResponse(res) {
    if (res.status === 401 || res.status === 403) {
        localStorage.removeItem("jwt");
        alert("Session expired. Please login again.");
        window.location.href = "/login";
        throw new Error("Unauthorized");
    }
    if (!res.ok) return res.json().then(e => { throw new Error(e.message || "Request failed"); });
    return res;
}

function createAccount() {
    const accType    = document.getElementById("accType").value;
    const accBalance = document.getElementById("accBalance").value;
    const token      = getToken();

    if (!token) { window.location.href = "/login"; return; }
    if (!accType)                      { showError("Please select an account type."); return; }
    if (!accBalance || accBalance < 0) { showError("Please enter a valid balance."); return; }

    fetch("/account/customer/" + custId, {
        method: "POST",
        headers: { "Content-Type": "application/json", "Authorization": "Bearer " + token },
        body: JSON.stringify({ accType: accType, accBalance: parseFloat(accBalance) })
    })
    .then(res => handleResponse(res))
    .then(res => res.json())
    .then(() => {
        alert("Account created successfully!");
        goBack();
    })
    .catch(err => { if (err.message !== "Unauthorized") showError(err.message); });
}

function goBack() {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/customer/accounts/" + custId;
}
</script>
</body>
</html>