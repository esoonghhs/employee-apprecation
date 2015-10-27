<!--- BETA, testing, to replace the cfc bind method --->

<!--- Get sub-department(s) info --->
<cfquery name="qSubDept" datasource="HatsOff">
    SELECT account_number, account_title
    FROM departments
		<cfif session.vdept is not "All" and session.vdept is not "Letter">
        	WHERE [departmentname] = '#session.vdept#'  
        </cfif>
</cfquery>

<!--- Get employee from department info input --->
<cfquery name="qEmployee" datasource="HatsOff">
SELECT emp_id, emp_full_name
FROM employees
</cfquery>

<!--- Create employee list from subdept input value --->
<cfsavecontent variable="EmployeeList">
var EmployeeName = [ ]; 
var SelectedSubDept=SubDept.selectedItem.data;

<cfoutput query="qEmployee">
    var SubDeptID=#qSubDept.account_number#;
        if (SubDeptID == SelectedCountry)
            {
            var AddEmployee = {label:'#EmployeeName#', data:#qEmployee.emp_id#};
            EmployeeName.push(AddEmployee);
            }
</cfoutput>

Employee.dataProvider = EmployeeName;
</cfsavecontent>

<!DOCTYPE html>
<html lang="en">

<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags --->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    
	<title>Employee Appreciation  |  UCLA Housing and Hospitality Services</title>
    
    <!--- Bootstrap core CSS --->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/award-style.css" rel="stylesheet">
    <!--- Custom styles for this template --->
    <link href="assets/css/signin.css" rel="stylesheet">
    <link href="assets/css/carousel.css" rel="stylesheet">
</head>

<body>
<div align="center">
<cfform format="flash" width="300" height="200">
    <cfformgroup type="panel" label="Select SubDept and Employee">
        <cfselect label="SubDept" name="department" query="qSubDept" value="qSubDept.account_number" display="SubDeptName" required="yes" onchange="#EmployeeList#">
        </cfselect>
        <cfselect name="employee" label="employee">
        Select
        </cfselect>
    </cfformgroup>
</cfform>
</div>
</body>
</html>