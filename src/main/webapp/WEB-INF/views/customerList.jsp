<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Customer List</title>
<style>
body { font-family: Arial, sans-serif; background: #f4f6f8; }

.container {
    width: 900px;
    margin: 40px auto;
    background: white;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

table { width: 100%; border-collapse: collapse; }

th, td { padding: 12px; border-bottom: 1px solid #ddd; }

th { background: #007bff; color: white; }

tr:hover { background: #f1f1f1; }

.btn {
    padding: 6px 12px;
    border-radius: 5px;
    color: white;
    background: #28a745;
    border: none;
    cursor: pointer;
}

.logout { background: red; float: right; }

.pagination { margin-top: 20px; text-align: center; }

.pagination button {
    margin: 0 5px;
    padding: 6px 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.pagination button:disabled { opacity: 0.4; cursor: default; }

.pagination span { margin: 0 10px; font-weight: bold; }
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
    <button class="btn logout" onclick="logout()">Logout</button>
    <h2>Existing Customers</h2>

    <table>
        <thead>
            <tr><th>ID</th><th>Name</th><th>Address</th><th>Action</th></tr>
        </thead>
        <tbody id="customerTable"></tbody>
    </table>

    <div class="pagination">
        <button id="prevBtn" onclick="loadPage(currentPage - 1)">Previous</button>
        <span id="pageInfo"></span>
        <button id="nextBtn" onclick="loadPage(currentPage + 1)">Next</button>
    </div>

    <br>
    <a href="/" class="btn">Back</a>
</div>

<script>

let currentPage = 1;
let totalPages  = 1;

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

document.addEventListener("DOMContentLoaded", function() {
    loadPage(1);
});

function loadPage(page) {
    if (page < 1 || page > totalPages) return;

    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/customer/ajax/view?page=" + page, {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => handleResponse(res))
    .then(res => res.json())
    .then(data => {
        currentPage = data.currentPage;
        totalPages  = data.totalPages;

        const tbody = document.getElementById("customerTable");
        tbody.innerHTML = "";

        data.customers.forEach(customer => {
            tbody.innerHTML += `
                <tr>
                    <td>${customer.custId}</td>
                    <td>${customer.custName}</td>
                    <td>${customer.custAdd}</td>
                    <td><button class="btn" onclick="viewCustomer(${customer.custId})">View</button></td>
                </tr>`;
        });

        document.getElementById("pageInfo").innerText = "Page " + currentPage + " of " + totalPages;
        document.getElementById("prevBtn").disabled = currentPage === 1;
        document.getElementById("nextBtn").disabled = currentPage === totalPages;
    })
    .catch(err => {
        if (err.message !== "Unauthorized") alert("Error loading customers: " + err.message);
    });
}

function viewCustomer(id) {
    window.location.href = "/customer/profile/" + id;
}

function logout() {
    localStorage.removeItem("jwt");
    window.location.href = "/login";
}
</script>
</body>
</html>