<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            text-align: left;
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
            text-decoration: none;
            background: #007bff;
            color: white;
            border-radius: 4px;
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
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Action</th>
        </tr>

        <c:forEach var="customer" items="${customerList}">
            <tr>
                <td>${customer.custId}</td>
                <td>${customer.custName}</td>
                <td>${customer.custAdd}</td>
                <td>
                    <a href="/customer/profile/${customer.custId}" class="btn">
                        View
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- PAGINATION -->
    <div class="pagination">

        <c:if test="${currentPage > 1}">
            <a href="/customer/view?page=${currentPage - 1}">Previous</a>
        </c:if>

        <span>Page ${currentPage} of ${totalPage}</span>

        <c:if test="${currentPage < totalPage}">
            <a href="/customer/view?page=${currentPage + 1}">Next</a>
        </c:if>

    </div>
</div>

</body>
</html>
