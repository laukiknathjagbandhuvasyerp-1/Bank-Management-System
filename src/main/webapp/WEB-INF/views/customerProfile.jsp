<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Profile</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .label {
            font-weight: bold;
            color: #555;
        }

        .value {
            color: #222;
        }

        .actions {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 6px;
            text-decoration: none;
            color: #fff;
            font-size: 14px;
        }

        .btn-account { background: #28a745; }
        .btn-loan { background: #007bff; }
        .btn-back { background: #6c757d; }
    </style>
</head>

<body>

<div class="container">
    <h2>Customer Profile</h2>

    <div class="row">
        <div class="label">Customer ID</div>
        <div class="value">${customer.custId}</div>
    </div>

    <div class="row">
        <div class="label">Name</div>
        <div class="value">${customer.custName}</div>
    </div>

    <div class="row">
        <div class="label">Address</div>
        <div class="value">${customer.custAdd}</div>
    </div>

    <div class="actions">
         <form action="/customer/delete/${customer.custId}" method="post">
         <button type="submit" class="btn btn-back">Delete Customer </button>
         </form>
         <form action="/customer/edit/${customer.custId}" method="get">
                 <button type="submit" class="btn btn-loan">
                     Update Customer
                 </button>
             </form>
        <a href="" class="btn btn-account">Open Account</a>
        <a href="" class="btn btn-loan">Apply Loan</a>
        <a href="/" class="btn btn-back">Back</a>
    </div>
</div>

</body>
</html>
