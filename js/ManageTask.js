function Validate() {   
    var summ = "";
    summ += Phno();
    summ += Email();
    summ += Name();
    summ += Designation();
    summ += UserID();
    summ += pwd();
    if (summ == "") {
        var msg = "";
        msg = 'Do you want to Save?';
        var result = confirm(msg, "Check");
        if (result) {
            document.getElementById('Content_CnfResult').value = "true";
            return true;
        }
        else {
            document.getElementById('Content_CnfResult').value = "false";
            return false;
        }
    }
    else {
        alert(summ);
        return false;
    }
}

function Name() {
    var Name = document.getElementById('<%=txtcontactname.ClientID%>').value;
    if (Name == "") {
        return "Please Enter Contact Name" + "\n";
    }
    else {
        return "";
    }
}
function Designation() {
    var Name = document.getElementById('<%=txtcontDesignation.ClientID%>').value;
    if (Name == "") {
        return "Please Enter Designation" + "\n";
    }
    else {
        return "";
    }
}
function UserID() {
    var Name = document.getElementById('<%=txtcontdepartment.ClientID%>').value;
    if (Name == "") {
        return "Please Enter Department" + "\n";
    }
    else {
        return "";
    }
}
function pwd() {
    var Name = document.getElementById('<%=txtcontlocation.ClientID%>').value;
    if (Name == "") {
        return "Please Enter Location" + "\n";
    }
    else {
        return "";
    }
}

function Phno() {
    var Name = document.getElementById('<%=txtcontmobileno.ClientID%>').value;
    var chk = /^[-+]?[0-9]+$/
    if (Name == "") {
        return "Please Enter Mobile No" + "\n";
    }
    else if (chk.test(Name)) {
        return "";
    }
    else {
        return "Please Enter Valid Mobile No" + "\n";
    }
}

function Email() {
    var Name = document.getElementById('<%=txtcontemailid.ClientID%>').value;
    var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
    if (Name == "") {
        return "Please Enter Email ID" + "\n";
    }
    else if (chk.test(Name)) {
        return "";
    }
    else {
        return "Please Enter Valid Email ID" + "\n";
    }
}

function ConfirmSave() {
    var msg = "";
    var val = document.getElementById('<%=txtInfo.ClientID%>').value;
    if (val == "") {
        alert("Please enter save time entry");
        return false;
    }
    else {
        msg = 'Do you want to save?';
        var result = confirm(msg, "Check");
        if (result) {
            return true;
        }
        else {
            return false;
        }
    }
}

function ConfirmSave() {
    var msg = "";
    var val = document.getElementById('<%=txtInfo.ClientID%>').value;
    if (val == "") {
        alert("Please enter save time entry");
        return false;
    }
    else {
        msg = 'Do you want to save?';
        var result = confirm(msg, "Check");
        if (result) {
            return true;
        }
        else {
            return false;
        }
    }
}

function ConfirmMsg() {
    var msg = "";
    msg = 'Do you want to save?';
    var result = confirm(msg, "Check");
    if (result) {
        //document.getElementById('Content_CnfResult').value = "true";
        return true;
    }
    else {
        //document.getElementById('Content_CnfResult').value = "false";
        return false;
    }
}

function ConfirmServiceMsg() {
    var msg = "";
    msg = 'Are you sure , you wish to add this Service for this customer?';
    var result = confirm(msg, "Check");
    if (result) {
        document.getElementById('Content_CnfResult').value = "true";
        return true;
    }
    else {
        document.getElementById('Content_CnfResult').value = "false";
        return false;
    }
}

function ServiceConfirmSave() {
    var msg = "";
    var val = document.getElementById('<%=txtservicevalue.ClientID%>').value;
    var chk = /^\d+\.\d{0,2}$/;
    if (val == "") {
        alert("Please enter Value");
        return false;
    } else if (chk.test(val)) {
        msg = 'Do you want to save?';
        var result = confirm(msg, "Check");
        if (result) {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        alert("Enter Valid value");
        return false;
    }
}

function checkEmail() {

    var email = document.getElementById('txtEml');
    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

    if (!filter.test(email.value)) {
        alert('Please provide a valid email address');
        email.focus;
        return false;
    }
}

function ConfirmStatusUpdateMsg() {
    var msg = "";
    msg = 'You are about to change the Status. Are you sure?  OK to continue';
    var result = confirm(msg, "Check");
    if (result) {
        document.getElementById('Content_CnfResult').value = "true";
        return true;
    }
    else {
        document.getElementById('Content_CnfResult').value = "false";
        return false;
    }
}

function ConfirmUpdateMsg() {
    var msg = "";
    msg = 'Do you want to Update?';
    var result = confirm(msg, "Check");
    if (result) {
        //document.getElementById('Content_CnfResult').value = "true";
        return true;
    }
    else {
        //document.getElementById('Content_CnfResult').value = "false";
        return false;
    }
}
function ConfirmDeleteMsg() {
    var msg = "";
    msg = 'Do you want to Delete?';
    var result = confirm(msg, "Check");
    if (result) {
        document.getElementById('Content_CnfResult').value = "true";
    }
    else {
        document.getElementById('Content_CnfResult').value = "false";
    }
}
function EnterEvent(e) {
    if (e.keyCode == 13) {
        document.getElementById("btnShowTarType").focus();
    }
}

function ConfirmMessage() {
    var result = confirm('Are you Sure?');
    if (result)
        document.getElementById('<%=btnSaveHidden.ClientID%>').click();
    else
        document.getElementById('<%=btnCancelHidden.ClientID %>').click();
}

