

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Logged In Admin', #Now()#, '')
</cfquery>
<style type="text/css">
	input{ width:250px; }
</style>

<html>
<head>
	<title>Hats Off Admin</title>
</head>

<body>
<cfinclude template="../header-award.cfm">
<form action="login.cfm" method="post">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			Welcome to the Hats Off administration tab.<br>
		</td>
	</tr>
</table>
<table align="center" border="0" cellpadding="2" cellspacing="0" width="400">
	<tr>
		<td align="center">
			<input type="button" name="login" value="review pending nominations" onclick="window.location='review.cfm';"><br>
			<input type="button" name="login" value="run nomination reports" onclick="window.location='reports.cfm';"><br>
			<cfif session.superuser is "1">
				<input type="button" name="login" value="review/print award cards" onclick="window.location='printreview.cfm';">
			</cfif>
			<cfif session.username is "rgilbert" or session.username is "tmullen" or session.username is "lkim" or session.username is "jerridge" or session.username is "lmartinez" or session.username is "alungo" OR session.username IS "ccaughlin">
				<input type="button" name="audit" value="generate audit report" onclick="window.location='audit.cfm';">
			</cfif>
		</td>
	</tr>
</table>		
</form>
<cfinclude template="../footer.cfm">
</body>
</html>
