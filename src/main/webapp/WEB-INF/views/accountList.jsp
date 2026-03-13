<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Accounts</title>
<style>
body { font-family: Arial; background: #f4f6f8; }

.container {
    width: 700px;
    margin: 50px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

h2 { text-align: center; margin-bottom: 25px; }

table { width: 100%; border-collapse: collapse; }

th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #eee; }

th { background: #667eea; color: white; }

tr:hover { background: #f9f9f9; }

.actions { margin-top: 25px; display: flex; gap: 10px; }

.btn { padding: 10px 18px; border: none; border-radius: 6px; color: white; cursor: pointer; font-size: 14px; }

.btn-add  { background: #28a745; }
.btn-back { background: #6c757d; }

.empty { text-align: center; color: #888; padding: 30px; }

.pagination { margin-top: 20px; display: flex; justify-content: center; gap: 10px; }

.page-btn {
    padding: 7px 13px;
    border: 1px solid #667eea;
    border-radius: 5px;
    background: white;
    color: #667eea;
    cursor: pointer;
}

.page-btn.active { background: #667eea; color: white; }
.page-btn:disabled { opacity: 0.4; cursor: default; }

.error-msg { color: #c33; text-align: center; padding: 20px; }
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
    <h2>🏦 Accounts</h2>
    <div id="content">Loading...</div>

    <div class="actions">
        <button class="btn btn-add"  onclick="goToAddAccount()">+ Add Account</button>
        <button class="btn btn-back" onclick="goBack()">← Back to Profile</button>
    </div>
</div>

<script>

const custId = "${custId}";
let currentPage = 1;
let totalPages  = 1;

function getToken() {
    return localStorage.getItem("jwt");
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

function loadAccounts(page) {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/account/customer/view/" + custId + "?page=" + page, {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => handleResponse(res))
    .then(res => res.json())
    .then(data => {
        totalPages  = data.totalPages;
        currentPage = page;
        renderTable(data.content);
        renderPagination();
    })
    .catch(err => {
        if (err.message !== "Unauthorized") {
            document.getElementById("content").innerHTML =
                '<div class="error-msg">Failed to load accounts: ' + err.message + '</div>';
        }
    });
}

function renderTable(accounts) {
    if (!accounts || accounts.length === 0) {
        document.getElementById("content").innerHTML =
            '<div class="empty">No accounts found for this customer.</div>';
        return;
    }

    let html = '<table><thead><tr><th>Account No</th><th>Type</th><th>Balance</th></tr></thead><tbody>';
    accounts.forEach(a => {
        html += '<tr><td>' + a.accNo + '</td><td>' + a.accType + '</td><td>₹' +
                Number(a.accBalance).toLocaleString() + '</td></tr>';
    });
    html += '</tbody></table>';
    document.getElementById("content").innerHTML = html;
}

function renderPagination() {
    const existing = document.getElementById("pagination");
    if (existing) existing.remove();
    if (totalPages <= 1) return;

    let html = '<div class="pagination" id="pagination">';
    html += '<button class="page-btn" onclick="loadAccounts(' + (currentPage - 1) + ')"' +
            (currentPage === 1 ? ' disabled' : '') + '>← Prev</button>';
    for (let i = 1; i <= totalPages; i++) {
        html += '<button class="page-btn ' + (i === currentPage ? 'active' : '') +
                '" onclick="loadAccounts(' + i + ')">' + i + '</button>';
    }
    html += '<button class="page-btn" onclick="loadAccounts(' + (currentPage + 1) + ')"' +
            (currentPage === totalPages ? ' disabled' : '') + '>Next →</button>';
    html += '</div>';
    document.querySelector(".container").insertAdjacentHTML("beforeend", html);
}

function goToAddAccount() {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/account/new/"+ custId;
}

function goBack() {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/customer/profile/"  + custId;
}

loadAccounts(1);
</script>
</body>
</html>