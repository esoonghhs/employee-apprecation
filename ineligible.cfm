<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>
<cfquery name="getEmp" datasource="HatsOff">
	Select top 1 emp_full_name
	From employees
	Where emp_id = '#session.employee#'
</cfquery>
<body>
<cfinclude template="header-award.cfm">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr>
		<td>
			Employee #session.employee# #getEmp.emp_full_name# is ineligible for a Hats Off award as they have already have 3 to date.
		</td>
	</tr>
</table>
<cfinclude template="footer.cfm">
</body>
</html>
