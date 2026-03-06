<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>

<title>Add New Customer</title>

<style>

body{
    margin:0;
    padding:0;
    font-family:Arial;
    background:linear-gradient(to right,#667eea,#764ba2);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.container{
    background:white;
    width:420px;
    padding:30px;
    border-radius:10px;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    margin-bottom:25px;
}

.form-group{
    margin-bottom:15px;
}

label{
    display:block;
    margin-bottom:6px;
    font-weight:bold;
}

input{
    width:100%;
    padding:10px;
    border-radius:6px;
    border:1px solid #ccc;
}

input:focus{
    outline:none;
    border-color:#667eea;
}

.btn{
    width:100%;
    padding:12px;
    background:#667eea;
    color:white;
    border:none;
    border-radius:6px;
    font-size:16px;
    cursor:pointer;
    margin-top:10px;
}

.btn:hover{
    background:#5a67d8;
}

.back-link{
    text-align:center;
    margin-top:15px;
}

.back-link a{
    text-decoration:none;
    color:#667eea;
}

</style>

</head>

<body>

<div class="container">

<h2>Add New Customer</h2>

<div class="form-group">
<label>Customer Name</label>
<input type="text" id="custName" placeholder="Enter customer name">
</div>

<div class="form-group">
<label>Address</label>
<input type="text" id="custAdd" placeholder="Enter customer address">
</div>

<button class="btn" onclick="createCustomer()">
Create Customer
</button>

<div class="back-link">
<a href="/">← Back to Home Page</a>
</div>

</div>


<script>

function getToken(){
    return localStorage.getItem("jwt");
}

function createCustomer(){

    const name = document.getElementById("custName").value;
    const address = document.getElementById("custAdd").value;

    const token = getToken();

    if(!token){
        alert("Session expired. Please login again.");
        window.location.href="/login";
        return;
    }

    fetch("/customer/add",{
        method:"POST",
        headers:{
            "Content-Type":"application/json",
            "Authorization":"Bearer " + token
        },
        body:JSON.stringify({
            custName:name,
            custAdd:address
        })
    })
    .then(response=>{

        if(response.status===403){
            alert("Access Denied");
            return;
        }

        return response.text();
    })
    .then(()=>{
        alert("Customer Created Successfully");
        window.location.href="/customer/view";
    })
    .catch(error=>{
        console.error(error);
        alert("Failed to create customer");
    });

}

</script>

</body>
</html>