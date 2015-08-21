

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<html>
<head>
	<title>Hats Off</title>
</head>

<body>
<cfinclude template="header-award.cfm">

<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center">
			Your nomination submission was successful.
		</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center">
			<cfif structKeyExists(session, "ood") AND session.ood IS 1>
				<input type="button" value="Make Another Nomination" onclick="window.location='departments.cfm';">
			<cfelse>
				<input type="button" value="Make Another Nomination in this Department" onclick="window.location='nominee.cfm?dept=#dept#';">
			</cfif>
			<br><br>
			<input type="button" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
	</tr>
</table>

<cfinclude template="footer.cfm">
</body>
</html>
