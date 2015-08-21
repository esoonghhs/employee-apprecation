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
<cfoutput>Logged in person UID is #empid#</cfoutput><br />
<cfoutput>Time logged on is #logintime#</cfoutput>
<cfoutput>The award type is "#session.awardtype#"</cfoutput>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags --->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    
	<title>Hats Off</title>
    
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
			To begin making a Hats Off Nomination, select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
<cfelse> 
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Safety Nomination, select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
</cfif>

<!--- Match empid to emp_id in Table employees, then acct number to Table departments --->
<!--- sample from ca5a <CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
                SELECT e.emp_id, e.emp_full_name, e.emp_first. e.emp_last, d.Department_Name
                FROM employees AS e
                INNER JOIN departments AS d
                ON e.account_number=d.account_number
				WHERE e.emp_id = session.emp_id
            </CFQUERY> 
			
			once we know the nominator's dept name, then use if else decison to output the follow codes for the correct dept to appear 
--->

<CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
	SELECT e.emp_id, e.emp_full_name, e.emp_first. e.emp_last, d.Department_Name
	FROM employees AS e
	INNER JOIN departments AS d
	ON e.account_number=d.account_number
	WHERE e.emp_id = session.emp_id
</CFQUERY> 

<!--- troubleshoot lines --->
<cfoutput>The nominator's dept is "#getNominatorDept.Department_Name#"</cfoutput>

<table align="center" border="0" cellpadding="0" cellspacing="2" width="600">
	<tr>
		<td>
			<table align="center">
				<tr>
					<td><a href="nominee.cfm?dept=Conferences">Conferences, Catering & Marketing</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Dining">Dining Services</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=HHSAdmin">Housing Admin & HBO</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=HHSIT">Housing IT</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Housing">Housing Services</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Letter">Letter</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table align="center">
				<tr>
					<td><a href="nominee.cfm?dept=CampusService">Housing HR/Payroll</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Lake">LACC & BRUINWOODS</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=HousingProjects">Housing Projects</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Rooms">Rooms Division</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=UA">University Apartments</a></td>
				</tr>
                                  <tr>
					<td><a href="nominee.cfm?dept=LUSKIN CONFERENCE CENTER">Luskin Conference Center</a></td>
				</tr>
                <tr>
					<td><a href="nominee.cfm?dept=All">Out of Department</a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table align="center" border="0" cellpadding="0" cellspacing="2" width="600">
	<tr>
    	<cfif getNominatorDept.Department_Name is Conferences>
    		<td><a href="nominee.cfm?dept=Conferences">Conferences, Catering & Marketing</a></td>
        <cfelseif getNominatorDept.Department_Name is Dining>
            <td><a href="nominee.cfm?dept=Dining">Dining Services</a></td>
        <cfelseif getNominatorDept.Department_Name is HHSAdmin>
			<td><a href="nominee.cfm?dept=HHSAdmin">Housing Admin & HBO</a></td>
        <cfelseif getNominatorDept.Department_Name is HHSIT>
			<td><a href="nominee.cfm?dept=HHSIT">Housing IT</a></td>
        <cfelseif getNominatorDept.Department_Name is Housing>
			<td><a href="nominee.cfm?dept=Housing">Housing Services</a></td>
        <cfelseif getNominatorDept.Department_Name is Letter>
			<td><a href="nominee.cfm?dept=Letter">Letter</a></td>
    	<cfelseif getNominatorDept.Department_Name is CampusService>
			<td><a href="nominee.cfm?dept=CampusService">Housing HR/Payroll</a></td>
        <cfelseif getNominatorDept.Department_Name is Lake>
            <td><a href="nominee.cfm?dept=Lake">LACC & BRUINWOODS</a></td>
        <cfelseif getNominatorDept.Department_Name is HousingProjects>
            <td><a href="nominee.cfm?dept=HousingProjects">Housing Projects</a></td>
        <cfelseif getNominatorDept.Department_Name is Rooms>
            <td><a href="nominee.cfm?dept=Rooms">Rooms Division</a></td>
        <cfelseif getNominatorDept.Department_Name is UA>
           	<td><a href="nominee.cfm?dept=UA">University Apartments</a></td>
        <cfelseif getNominatorDept.Department_Name is LUSKIN CONFERENCE CENTER>
			<td><a href="nominee.cfm?dept=LUSKIN CONFERENCE CENTER">Luskin Conference Center</a></td>
        </cfif>
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
    
<cfdump var="#empid#"><br />
<cfdump var="#logintime#">
<cfdump var="#getNominatorDept.Department_Name#">
</body>
</html>
