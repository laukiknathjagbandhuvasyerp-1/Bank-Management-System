<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Customer Profile</title>

<style>

body{
    font-family: Arial;
    background:#f4f6f8;
}

.container{
    width:600px;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}

h2{
    text-align:center;
}

.row{
    display:flex;
    justify-content:space-between;
    margin-bottom:15px;
}

.label{
    font-weight:bold;
}

.actions{
    margin-top:30px;
    display:flex;
    gap:10px;
    flex-wrap:wrap;
}

.btn{
    padding:10px 15px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    color:white;
}

.btn-delete{ background:#dc3545; }
.btn-edit{ background:#007bff; }
.btn-back{ background:#6c757d; }

</style>
</head>

<body>

<div class="container">

<h2>Customer Profile</h2>

<div class="row">
<div class="label">Customer ID</div>
<div>${customer.custId}</div>
</div>

<div class="row">
<div class="label">Name</div>
<div>${customer.custName}</div>
</div>

<div class="row">
<div class="label">Address</div>
<div>${customer.custAdd}</div>
</div>


<div class="actions">

<button class="btn btn-delete"
onclick="deleteCustomer(${customer.custId})">
Delete Customer
</button>

<button class="btn btn-edit"
onclick="editCustomer(${customer.custId})">
Update Customer
</button>

<button class="btn btn-back"
onclick="goHome()">
Back
</button>

</div>

</div>


<script>

function getToken(){
    return localStorage.getItem("jwt");
}


function deleteCustomer(id){

    const token = getToken();

    if(!token){
        alert("Session expired. Login again");
        window.location.href="/login";
        return;
    }

    fetch("/customer/delete/"+id,{
        method:"POST",
        headers:{
            "Authorization":"Bearer "+token
        }
    })
    .then(response=>{
        if(response.status===403){
            alert("Access Denied");
            return;
        }

        alert("Customer deleted");
        window.location.href="/";

    })
    .catch(err=>{
        console.log(err);
    });

}



function editCustomer(id){

    const token = getToken();

    if(!token){
        alert("Session expired");
        window.location.href="/login";
        return;
    }

    fetch("/customer/edit/"+id,{
        method:"GET",
        headers:{
            "Authorization":"Bearer "+token
        }
    })
    .then(response=>response.text())
    .then(html=>{
        document.open();
        document.write(html);
        document.close();
    })
    .catch(err=>{
        console.log(err);
    });

}


function goHome(){
    window.location.href="/";
}

</script>

</body>
</html>