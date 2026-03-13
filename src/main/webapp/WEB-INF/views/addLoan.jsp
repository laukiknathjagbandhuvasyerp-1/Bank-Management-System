<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Apply for Loan</title>
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

input {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

input:focus { outline: none; border-color: #667eea; }

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
    <h2>Apply for Loan</h2>

    <div class="error-msg" id="errorMsg"></div>

    <div class="form-group">
        <label>Loan Amount (₹)</label>
        <input type="number" id="loanAmount" placeholder="Enter loan amount" min="1">
    </div>

    <div class="form-group">
        <label>Interest Rate (%)</label>
        <input type="number" id="loanRate" placeholder="e.g. 8.5" step="0.1" min="0">
    </div>

    <div class="form-group">
        <label>Tenure (months)</label>
        <input type="number" id="loanTenure" placeholder="e.g. 12" min="1">
    </div>

    <button class="btn" onclick="applyLoan()">Apply Loan</button>

    <div class="back-link">
        <a onclick="goBack()">← Back to Loans</a>
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

function applyLoan() {
    const loanAmount = document.getElementById("loanAmount").value;
    const loanRate   = document.getElementById("loanRate").value;
    const loanTenure = document.getElementById("loanTenure").value;
    const token      = getToken();

    if (!token) { window.location.href = "/login"; return; }
    if (!loanAmount || loanAmount <= 0) { showError("Please enter a valid loan amount."); return; }
    if (!loanRate   || loanRate < 0)    { showError("Please enter a valid interest rate."); return; }
    if (!loanTenure || loanTenure < 1)  { showError("Please enter a valid tenure."); return; }

    fetch("/loan/customer/" + custId, {
        method: "POST",
        headers: { "Content-Type": "application/json", "Authorization": "Bearer " + token },
        body: JSON.stringify({
            loanAmount: parseInt(loanAmount),
            loanRate:   parseFloat(loanRate),
            loanTenure: parseInt(loanTenure)
        })
    })
    .then(res => handleResponse(res))
    .then(res => res.json())
    .then(() => {
        alert("Loan applied successfully! EMIs have been generated.");
        goBack();
    })
    .catch(err => { if (err.message !== "Unauthorized") showError(err.message); });
}

function goBack() {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/customer/loans/"    + custId;
}
</script>
</body>
</html>