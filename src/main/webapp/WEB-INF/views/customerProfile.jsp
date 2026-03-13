<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Customer Profile</title>
<style>
body { font-family: Arial; background: #f4f6f8; }

.container {
    width: 600px;
    margin: 50px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

h2 { text-align: center; margin-bottom: 25px; }

.row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.label { font-weight: bold; color: #444; }

.section-title {
    font-size: 14px;
    font-weight: bold;
    color: #667eea;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin: 25px 0 12px;
}

.actions { display: flex; gap: 10px; flex-wrap: wrap; }

.btn { padding: 10px 15px; border: none; border-radius: 6px; cursor: pointer; color: white; font-size: 14px; }

.btn-delete   { background: #dc3545; }
.btn-edit     { background: #007bff; }
.btn-back     { background: #6c757d; }
.btn-accounts { background: #28a745; }
.btn-loans    { background: #fd7e14; }
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
    <h2>Customer Profile</h2>

    <div class="row">
        <div class="label">Customer ID</div>
        <div>${customer.custId}</div>
    </div>
    <div class="row">
        <div class="label">Name</div>
        <div>${customer.custName}</div>
    </div>
    <div class="row">
        <div class="label">Address</div>
        <div>${customer.custAdd}</div>
    </div>

    <div class="section-title">Actions</div>

    <div class="actions">
        <button class="btn btn-edit"     onclick="editCustomer(${customer.custId})">✏️ Update</button>
        <button class="btn btn-delete"   onclick="deleteCustomer(${customer.custId})">🗑️ Delete</button>
        <button class="btn btn-accounts" onclick="viewAccounts(${customer.custId})">🏦 Accounts</button>
        <button class="btn btn-loans"    onclick="viewLoans(${customer.custId})">💳 Loans</button>
        <button class="btn btn-back"     onclick="goHome()">← Home</button>
    </div>
</div>

<script>

function getToken() { return localStorage.getItem("jwt"); }

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

function fetchPage(url) {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch(url, { headers: { "Authorization": "Bearer " + token } })
    .then(res => handleResponse(res))
    .then(res => res.text())
    .then(html => { document.open(); document.write(html); document.close(); })
    .catch(err => { if (err.message !== "Unauthorized") alert("Failed to load page: " + err.message); });
}

function deleteCustomer(id) {
    if (!confirm("Are you sure you want to delete this customer?")) return;

    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/customer/delete/" + id, {
        method: "POST",
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => handleResponse(res))
    .then(() => {
        alert("Customer deleted successfully.");
        window.location.href = "/";
    })
    .catch(err => { if (err.message !== "Unauthorized") alert("Delete failed: " + err.message); });
}

function editCustomer(id)  { window.location.href = "/customer/edit/"     + id; }
function viewAccounts(id)  { window.location.href = "/customer/accounts/" + id; }
function viewLoans(id)     { window.location.href = "/customer/loans/"    + id; }
function goHome()          { window.location.href = "/"; }
</script>
</body>
</html>