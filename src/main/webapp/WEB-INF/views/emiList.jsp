<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>EMI Schedule</title>
<style>
body { font-family: Arial; background: #f4f6f8; }

.container {
    width: 800px;
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

.badge { padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }

.badge-paid   { background: #d4edda; color: #155724; }
.badge-unpaid { background: #f8d7da; color: #721c24; }

.btn { padding: 6px 12px; border: none; border-radius: 5px; color: white; cursor: pointer; font-size: 13px; }

.btn-pay  { background: #28a745; }
.btn-back { background: #6c757d; padding: 10px 18px; }

.actions { margin-top: 25px; }

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
    <h2>📅 EMI Schedule</h2>
    <div id="content">Loading...</div>

    <div class="actions">
        <button class="btn btn-back" onclick="goBack()">← Back to Loans</button>
    </div>
</div>

<script>

const loanId = "${loanId}";
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

function loadEmis(page) {
    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/loan/emi/loan/" + loanId + "?page=" + page, {
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
                '<div class="error-msg">Failed to load EMIs: ' + err.message + '</div>';
        }
    });
}

function renderTable(emis) {
    if (!emis || emis.length === 0) {
        document.getElementById("content").innerHTML =
            '<div class="empty">No EMIs found for this loan.</div>';
        return;
    }

    let html = '<table><thead><tr>' +
        '<th>EMI ID</th><th>Amount</th><th>Due Date</th><th>Paid Date</th><th>Status</th><th>Action</th>' +
        '</tr></thead><tbody>';

    emis.forEach(e => {
        const badge  = e.paid
            ? '<span class="badge badge-paid">✓ Paid</span>'
            : '<span class="badge badge-unpaid">Unpaid</span>';
        const payBtn = !e.paid
            ? '<button class="btn btn-pay" onclick="payEmi(' + e.emiId + ')">Pay</button>'
            : '—';

        html += '<tr>' +
            '<td>' + e.emiId + '</td>' +
            '<td>₹' + Number(e.emiAmount).toLocaleString() + '</td>' +
            '<td>' + e.emiDueDate + '</td>' +
            '<td>' + (e.emiPaidDate || '—') + '</td>' +
            '<td>' + badge + '</td>' +
            '<td>' + payBtn + '</td>' +
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
    html += '<button class="page-btn" onclick="loadEmis(' + (currentPage - 1) + ')"' +
            (currentPage === 1 ? ' disabled' : '') + '>← Prev</button>';
    for (let i = 1; i <= totalPages; i++) {
        html += '<button class="page-btn ' + (i === currentPage ? 'active' : '') +
                '" onclick="loadEmis(' + i + ')">' + i + '</button>';
    }
    html += '<button class="page-btn" onclick="loadEmis(' + (currentPage + 1) + ')"' +
            (currentPage === totalPages ? ' disabled' : '') + '>Next →</button>';
    html += '</div>';
    document.querySelector(".container").insertAdjacentHTML("beforeend", html);
}

function payEmi(emiId) {
    if (!confirm("Confirm EMI payment?")) return;

    const token = getToken();
    if (!token) { window.location.href = "/login"; return; }

    fetch("/loan/emi/pay/" + emiId, {
        method: "POST",
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => handleResponse(res))
    .then(res => res.text())
    .then(msg => {
        alert(msg || "EMI paid successfully!");
        loadEmis(currentPage);
    })
    .catch(err => { if (err.message !== "Unauthorized") alert("Payment failed: " + err.message); });
}

function goBack() {
    const token    = getToken();
    if (!token) { window.location.href = "/login"; return; }

    const custId = sessionStorage.getItem("currentCustId");
    window.location.href = custId ? "/customer/loans/" + custId : "/";

}

loadEmis(1);
</script>
</body>
</html>