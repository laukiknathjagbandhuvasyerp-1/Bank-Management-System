<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Update Customer</title>

<style>

body{
    font-family: Arial;
    background:#f4f6f8;
}

.container{
    width:450px;
    margin:60px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
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
    font-weight:bold;
    margin-bottom:6px;
}

input{
    width:100%;
    padding:10px;
    border-radius:6px;
    border:1px solid #ccc;
}

.actions{
    margin-top:25px;
    display:flex;
    justify-content:space-between;
}

.btn{
    padding:10px 18px;
    border:none;
    border-radius:6px;
    color:white;
    cursor:pointer;
}

.btn-update{
    background:#007bff;
}

.btn-cancel{
    background:#6c757d;
    text-decoration:none;
    padding:10px 18px;
}

</style>
</head>


<body>

<div class="container">

<h2>Update Customer</h2>

<div class="form-group">
<label>Customer ID</label>
<input type="text" id="custId" value="${customer.custId}" disabled>
</div>

<div class="form-group">
<label>Name</label>
<input type="text" id="custName" value="${customer.custName}">
</div>

<div class="form-group">
<label>Address</label>
<input type="text" id="custAdd" value="${customer.custAdd}">
</div>

<div class="actions">
<button class="btn btn-update" onclick="updateCustomer()">Update</button>

<button class="btn btn-cancel" onclick="goToProfile()">
Cancel
</button>
</div>

</div>


<script>

function getToken(){
    return localStorage.getItem("jwt");
}

function updateCustomer(){

    const id = document.getElementById("custId").value;
    const name = document.getElementById("custName").value;
    const address = document.getElementById("custAdd").value;

    const token = getToken();

    if(!token){
        alert("Session expired. Please login again.");
        window.location.href="/login";
        return;
    }

    fetch("/customer/update/" + id,{
        method:"POST",
        headers:{
            "Content-Type":"application/json",
            "Authorization":"Bearer " + token
        },
        body: JSON.stringify({
            custName: name,
            custAdd: address
        })
    })
    .then(response=>{

        if(!response.ok){
            throw new Error("Update Failed or Access Denied");
        }

        return response.text();
    })
    .then(()=>{

        alert("Customer Updated Successfully");

        return fetch("/customer/profile/" + id,{
            headers:{
                "Authorization":"Bearer " + token
            }
        });

    })
    .then(response=>{

        if(!response.ok){
            throw new Error("Failed to load profile");
        }

        return response.text();
    })
    .then(html=>{
        document.body.innerHTML = html;
    })
    .catch(error=>{
        console.error(error);
        alert(error.message);
    });

}

function goToProfile(){
    const id = document.getElementById("custId").value;
    const token = getToken();

    if(!token){
        alert("Session expired. Please login again.");
        window.location.href="/login";
        return;
    }

    fetch("/customer/profile/" + id, {
        headers:{
            "Authorization":"Bearer " + token
        }
    })
    .then(response => {
        if(!response.ok) throw new Error("Access Denied");
        return response.text();
    })
    .then(html => {
        document.body.innerHTML = html;
    })
    .catch(error => {
        alert(error.message);
    });
}

</script>

</body>
</html>
