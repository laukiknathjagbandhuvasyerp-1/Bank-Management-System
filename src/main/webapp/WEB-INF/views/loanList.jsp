<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Loans</title>
<style>
body { font-family: Arial; background: #f4f6f8; }

.container {
    width: 750px;
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

.btn { padding: 7px 12px; border: none; border-radius: 5px; color: white; cursor: pointer; font-size: 13px; }

.btn-emi    { background: #17a2b8; }
.btn-delete { background: #dc3545; }
.btn-add    { background: #28a745; padding: 10px 18px; font-size: 14px; }
.btn-back   { background: #6c757d; padding: 10px 18px; font-size: 14px; }

.actions { margin-top: 25px; display: flex; gap: 10px; }

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
    <h2>💳 Loans</h2>
    <div id="content">Loading...</div>

    <div class="actions">
        <button class="btn btn-add"  onclick="goToAddLoan()">+ Apply Loan</button>
        <button class="btn btn-back" onclick="goBack()">← Back to Profile</button>
    </div>
</div>

<script>

const custId = "${custId}";
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

function loadLoans(page) {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/loan/details/" + custId + "?page=" + page, {
        method: "POST",
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
                '<div class="error-msg">Failed to load loans: ' + err.message + '</div>';
        }
    });
}

function renderTable(loans) {
    if (!loans || loans.length === 0) {
        document.getElementById("content").innerHTML =
            '<div class="empty">No loans found for this customer.</div>';
        return;
    }

    let html = '<table><thead><tr>' +
        '<th>Loan ID</th><th>Amount</th><th>Rate (%)</th><th>Tenure (months)</th><th>Actions</th>' +
        '</tr></thead><tbody>';

    loans.forEach(l => {
        html += '<tr>' +
            '<td>' + l.loanId + '</td>' +
            '<td>₹' + Number(l.loanAmount).toLocaleString() + '</td>' +
            '<td>' + l.loanRate + '%</td>' +
            '<td>' + l.loanTenure + '</td>' +
            '<td>' +
                '<button class="btn btn-emi"    onclick="viewEmi(' + l.loanId + ')">View EMI</button> ' +
                '<button class="btn btn-delete" onclick="deleteLoan(' + l.loanId + ')">Delete</button>' +
            '</td>' +
        '</tr>';
    });

    html += '</tbody></table>';
    document.getElementById("content").innerHTML = html;
}

function renderPagination() {
    const existing = document.getElementById("pagination");
    if (existing) existing.remove();
    if (totalPages <= 1) return;

    let html = '<div class="pagination" id="pagination">';
    html += '<button class="page-btn" onclick="loadLoans(' + (currentPage - 1) + ')"' +
            (currentPage === 1 ? ' disabled' : '') + '>← Prev</button>';
    for (let i = 1; i <= totalPages; i++) {
        html += '<button class="page-btn ' + (i === currentPage ? 'active' : '') +
                '" onclick="loadLoans(' + i + ')">' + i + '</button>';
    }
    html += '<button class="page-btn" onclick="loadLoans(' + (currentPage + 1) + ')"' +
            (currentPage === totalPages ? ' disabled' : '') + '>Next →</button>';
    html += '</div>';
    document.querySelector(".container").insertAdjacentHTML("beforeend", html);
}

function viewEmi(loanId) {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    sessionStorage.setItem("currentCustId", custId);
    window.location.href = "/loan/emi/view/" + loanId;
}

function deleteLoan(loanId) {
    if (!confirm("Are you sure you want to delete this loan?")) return;

    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/loan/delete/" + loanId, {
        method: "POST",
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => handleResponse(res))
    .then(() => {
        alert("Loan deleted successfully.");
        loadLoans(currentPage);
    })
    .catch(err => { if (err.message !== "Unauthorized") alert("Error: " + err.message); });
}

function goToAddLoan() {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/loan/new/"          + custId;
}

function goBack() {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    window.location.href = "/customer/profile/"  + custId;
}

loadLoans(1);
</script>
</body>
</html>