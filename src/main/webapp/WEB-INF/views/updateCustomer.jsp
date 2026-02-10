<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Customer</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 450px;
            margin: 60px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input[disabled] {
            background-color: #eee;
            cursor: not-allowed;
        }

        .actions {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 6px;
            border: none;
            font-size: 14px;
            cursor: pointer;
            color: white;
        }

        .btn-update {
            background: #007bff;
        }

        .btn-cancel {
            background: #6c757d;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
            color: white;
            display: inline-block;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Update Customer</h2>

    <form action="/customer/update/${customer.custId}" method="post">

        <!-- Visible but non-editable -->
        <div class="form-group">
            <label>Customer ID</label>
            <input type="text" value="${customer.custId}" disabled />
        </div>

        <!-- Hidden ID (actual value sent to controller) -->
        <input type="hidden" name="custId" value="${customer.custId}" />

        <div class="form-group">
            <label>Name</label>
            <input type="text" name="custName" value="${customer.custName}" required />
        </div>

        <div class="form-group">
            <label>Address</label>
            <input type="text" name="custAdd" value="${customer.custAdd}" required />
        </div>

        <div class="actions">
            <button type="submit" class="btn btn-update">Update</button>
            <a href="/customer/profile/${customer.custId}" class="btn-cancel">Cancel</a>
        </div>

    </form>
</div>

</body>
</html>
