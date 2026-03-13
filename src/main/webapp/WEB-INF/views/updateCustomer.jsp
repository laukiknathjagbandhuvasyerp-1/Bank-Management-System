<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Update Customer</title>
<style>
body { font-family: Arial; background: #f4f6f8; }

.container {
    width: 450px;
    margin: 60px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

h2 { text-align: center; margin-bottom: 25px; }

.form-group { margin-bottom: 15px; }

label { display: block; font-weight: bold; margin-bottom: 6px; }

input {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

input:focus { outline: none; border-color: #667eea; }

input:disabled { background: #f5f5f5; color: #888; }

.actions { margin-top: 25px; display: flex; justify-content: space-between; }

.btn { padding: 10px 18px; border: none; border-radius: 6px; color: white; cursor: pointer; font-size: 14px; }

.btn-update { background: #007bff; }
.btn-cancel { background: #6c757d; }

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
    <h2>Update Customer</h2>

    <div class="error-msg" id="errorMsg"></div>

    <div class="form-group">
        <label>Customer ID</label>
        <input type="text" id="custId" value="${customer.custId}" disabled>
    </div>

    <div class="form-group">
        <label>Name</label>
        <input type="text" id="custName" value="${customer.custName}">
    </div>

    <div class="form-group">
        <label>Address</label>
        <input type="text" id="custAdd" value="${customer.custAdd}">
    </div>

    <div class="actions">
        <button class="btn btn-update" onclick="updateCustomer()">Update</button>
        <button class="btn btn-cancel" onclick="goToProfile()">Cancel</button>
    </div>
</div>

<script>

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

function updateCustomer() {
    const id      = document.getElementById("custId").value;
    const name    = document.getElementById("custName").value.trim();
    const address = document.getElementById("custAdd").value.trim();
    const token   = getToken();

    if (!token) { window.location.href = "/login"; return; }
    if (!name)    { showError("Please enter a customer name."); return; }
    if (!address) { showError("Please enter an address."); return; }

    fetch("/customer/update/" + id, {
        method: "POST",
        headers: { "Content-Type": "application/json", "Authorization": "Bearer " + token },
        body: JSON.stringify({ custName: name, custAdd: address })
    })
    .then(res => handleResponse(res))
    .then(() => {
        alert("Customer updated successfully!");
        goToProfile();
    })
    .catch(err => { if (err.message !== "Unauthorized") showError(err.message); });
}

function goToProfile() {
    const id    = document.getElementById("custId").value;
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/customer/profile/" + id;

}
</script>
</body>
</html>