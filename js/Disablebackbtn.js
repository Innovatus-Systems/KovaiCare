function SMReports() {
    history.pushState(null, null, 'SMReports.aspx');
    window.addEventListener('popstate', function (event) {
        //alert('Please use return button to go back');
        history.pushState(null, null, 'SMReports.aspx');       
    });
}
function Admin() {
    history.pushState(null, null, 'Admin.aspx');
    window.addEventListener('popstate', function (event) {
        //alert('Please use return button to go back');
        history.pushState(null, null, 'Admin.aspx');
    });
}
function TaskLIst() {
    history.pushState(null, null, 'ManageNTaskList.aspx');
    window.addEventListener('popstate', function (event) {
        //alert('Please use signout button to exit');
        history.pushState(null, null, 'ManageNTaskList.aspx');
    });
}

function MyTasksblock() {
    history.pushState(null, null, 'Mytasks.aspx');
    window.addEventListener('popstate', function (event) {
        //alert('Please use signout button to exit');
        history.pushState(null, null, 'MyTasks.aspx');
    });
}
function ByMeblock() {
    history.pushState(null, null, 'ByMe.aspx');
    window.addEventListener('popstate', function (event) {
        //alert('Please use signout button to exit');
        history.pushState(null, null, 'ByMe.aspx');
    });
}
function Customersblock() {
    history.pushState(null, null, 'Customers.aspx');
    window.addEventListener('popstate', function (event) {
        //alert('Please use signout button to exit');
        history.pushState(null, null, 'Customers.aspx');
    });
}
function HomeBlock() {
    history.pushState(null, null, "Home.aspx");
    window.addEventListener('popstate', function (event) {
        history.pushState(null, null, "Home.aspx");
    });
}

