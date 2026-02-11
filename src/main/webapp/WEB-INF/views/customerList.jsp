<%@ page contentType="text/html;charset=UTF-8" %>

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
        .pagination a {
            margin: 0 5px;
            padding: 6px 12px;
            background: #007bff;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Existing Customers</h2>

    <table id ="customerTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Action</th>
        </tr>
        </thead>

        <tbody id="customerTableBody">
            <!-- AJAX WILL FILL DATA -->
        </tbody>
    </table>

    <div class="pagination" id="pagination">
        <!-- AJAX WILL FILL PAGINATION -->
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    /* ==========================
       DOCUMENT READY
    ========================== */
    $(document).ready(function () {
        loadPage(1);   // initial load
    });

    /* ==========================
       AJAX CALL
    ========================== */
    function loadPage(page) {
        $.ajax({
            url: "/customer/ajax/view",
            type: "GET",
            data: { page: page },
            dataType: "json",
            success: function (data) {
                populateTable("#customerTable", data.customers);
                populatePagination(data.currentPage, data.totalPages);
            },
            error: function () {
                console.error("Failed to fetch customers");
            }
        });
    }

    /* ==========================
       TABLE POPULATION
       (NO STRING APPEND)
    ========================== */
    function populateTable(tableId, customers) {
        const $tbody = $(tableId + " tbody");
        $tbody.empty();

        $.each(customers, function (index, customer) {

            const $tr = $("<tr>");

            $("<td>").text(customer.custId).appendTo($tr);
            $("<td>").text(customer.custName).appendTo($tr);
            $("<td>").text(customer.custAdd).appendTo($tr);

            const $actionTd = $("<td>");
            $("<a>")
                .attr("href", "/customer/profile/" + customer.custId)
                .addClass("btn")
                .text("View")
                .appendTo($actionTd);

            $actionTd.appendTo($tr);

            $tbody.append($tr);
        });
    }

    /* ==========================
       PAGINATION
    ========================== */
    function populatePagination(currentPage, totalPages) {
        const $pagination = $("#pagination");
        $pagination.empty();

        if (currentPage > 1) {
            $("<a>")
                .text("Previous")
                .on("click", function () {
                    loadPage(currentPage - 1);
                })
                .appendTo($pagination);
        }

        $("<span>")
            .text(" Page " + currentPage + " of " + totalPages + " ")
            .appendTo($pagination);

        if (currentPage < totalPages) {
            $("<a>")
                .text("Next")
                .on("click", function () {
                    loadPage(currentPage + 1);
                })
                .appendTo($pagination);
        }
    }
</script>


</body>
</html>
