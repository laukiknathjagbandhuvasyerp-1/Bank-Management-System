<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }
        .container {
            width: 900px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .btn {
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            background: #28a745;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination button {
            margin: 0 5px;
            padding: 6px 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .pagination span {
            margin: 0 10px;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Existing Customers</h2>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody id="customerTable"></tbody>
    </table>

    <div class="pagination">
        <button onclick="loadPage(currentPage - 1)">Previous</button>
        <span id="pageInfo"></span>
        <button onclick="loadPage(currentPage + 1)">Next</button>
    </div>

            <a href="/" class="btn">Back</a>

</div>

<script>
    let currentPage = 1;
    let totalPages = 1;

    document.addEventListener("DOMContentLoaded", function () {
        loadPage(1);
    });

    function loadPage(page) {

        if (page < 1 || page > totalPages) return;

        fetch(`/customer/ajax/view?page=${page}`)
            .then(res => {
                if (!res.ok) throw new Error("HTTP " + res.status);
                return res.json();
            })
            .then(data => {

                console.log("AJAX DATA:", data);

                currentPage = data.currentPage;
                totalPages = data.totalPages;

                const tbody = document.getElementById("customerTable");
                tbody.innerHTML = "";

                if (data.customers.length === 0) {
                    tbody.innerHTML = "<tr><td colspan='4'>No customers</td></tr>";
                    return;
                }

                data.customers.forEach(c => {
                    tbody.innerHTML += `
                        <tr>
                            <td>${c.custId}</td>
                            <td>${c.custName}</td>
                            <td>${c.custAdd}</td>
                            <td>
                                <a href="/customer/profile/${c.custId}" class="btn">View</a>
                            </td>
                        </tr>
                    `;
                });

                document.getElementById("pageInfo")
                    .innerText = `Page ${currentPage} of ${totalPages}`;
            })
            .catch(err => {
                console.error("AJAX ERROR:", err);
                alert("Failed to load customers");
            });
    }
</script>

</body>
</html>
