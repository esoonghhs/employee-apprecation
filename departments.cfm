<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Logged In', #Now()#, '')
</cfquery>

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines --->
<cfset empid = #session.emp_id#>
<cfset logintime = #Now()#>
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<!--- <cfoutput>Logged in person session.empUID is #session.empUID#</cfoutput><br />
<cfoutput>Time logged on is #logintime#</cfoutput><br />
<cfoutput>The award type is #session.awardtype#</cfoutput><br />
<cfoutput>The session_emp_id is #session.emp_id#</cfoutput> --->

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
<!--- From awardtype determine which logo to use --->
<cfif session.awardtype is 1>
	<cfinclude template="header-hatsoff.cfm">
<cfelse> 
	<cfinclude template="header-safety.cfm">
</cfif>

<!--- From awardtype determine which statement to use following the logo --->
<cfif session.awardtype is 1>
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Hats Off Nomination, <br />select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
<cfelse> 
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Safety Nomination, <br />select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
</cfif>

<!--- Match empid to emp_id in Table employees, then acct number to Table departments --->
<CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
	SELECT e.emp_id, e.emp_full_name, e.emp_first, e.emp_last, d.DepartmentName
	FROM employees AS e
	INNER JOIN departments AS d
	ON e.account_number=d.account_number
	WHERE e.emp_id = <cfqueryparam value="#session.empUID#">
</CFQUERY>

<cfset session.Empfullname = #getNominatorDept.emp_full_name#>

<table align="center" border="0" cellpadding="0" cellspacing="2" width="300">
	<tr>
    	<td>
    	<cfif getNominatorDept.DepartmentName is "Conferences">
    		<cfoutput><a href="nomination.cfm?dept=Conferences">Conferences, Catering & Marketing</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "Dining">
            <cfoutput><a href="nomination.cfm?dept=Dining">Dining Services</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "HHSAdmin">
			<cfoutput><a href="nomination.cfm?dept=HHSAdmin">Housing Admin & HBO</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "HHS IT">
			<cfoutput><a href="nomination.cfm?dept=HHSIT">Housing IT</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "Housing">
			<cfoutput><a href="nomination.cfm?dept=Housing">Housing Services</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "Letter">
			<cfoutput><a href="nomination.cfm?dept=Letter">Letter</a></cfoutput>
    	<cfelseif getNominatorDept.DepartmentName is "CampusService">
			<cfoutput><a href="nomination.cfm?dept=CampusService">Housing HR/Payroll</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "Lake">
            <cfoutput><a href="nomination.cfm?dept=Lake">LACC & BRUINWOODS</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "HousingProjects">
            <cfoutput><a href="nomination.cfm?dept=HousingProjects">Housing Projects</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "Rooms">
            <cfoutput><a href="nomination.cfm?dept=Rooms">Rooms Division</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "UA">
           	<cfoutput><a href="nomination.cfm?dept=UA">University Apartments</a></cfoutput>
        <cfelseif getNominatorDept.DepartmentName is "LUSKIN_CONFERENCE_CENTER">
			<cfoutput><a href="nomination.cfm?dept=LUSKIN_CONFERENCE_CENTER">Luskin Conference Center</a></cfoutput>
        </cfif>
        </td>
        <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;</td>
        <td><a href="nomination.cfm?dept=All">Out of Department</a></td>
	</tr>
</table>

<cfinclude template="footer.cfm">

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/vendor/holder.min.js"></script> 
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
    
<cfdump var="#session.emp_id#"><br />
<cfdump var="#session.empUID#"><br />
<cfdump var="#logintime#"><br />
<cfdump var="#getNominatorDept.emp_id#"><br />
<cfdump var="#getNominatorDept.DepartmentName#">
</body>
</html>
