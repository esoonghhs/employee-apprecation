<cfquery name="getID" datasource="HatsOff">
	Select top 1 nom_id
	From awards
	Where nominee_uid = '#session.employee#'
	Order by nom_id desc
</cfquery>
<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', #getID.nom_id#, 'Submitted Award', #Now()#, '#session.employee#')
</cfquery>

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
<!--- From awardtype determine which logo to use --->
<cfif session.awardtype is 1>
	<cfinclude template="header-hatsoff.cfm">
<cfelse> 
	<cfinclude template="header-safety.cfm">
</cfif>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center">
			Your nomination submission was successful.
		</td>
	</tr>
</table>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center">
				<input type="button" class="btn btn-lg btn-primary" value="Make Another Nomination" onclick="window.location='nomination.cfm?dept=dept';">
        </td>
        <td>&nbsp;&nbsp;&nbsp;</td>
        <td align="center">
				<input type="button" class="btn btn-lg btn-primary" value="Make Another Nomination in Another Department" onclick="window.location='nomination.cfm?dept=All';">
        </td>
        <td>&nbsp;&nbsp;&nbsp;</td>
        <<td align="center">
			<input type="button" class="btn btn-lg btn-primary" value="    Return to Main Screen   " onclick="window.location='loginb.cfm';">
		</td>
	</tr>
</table>

<cfinclude template="footer.cfm">
</body>
</html>
