<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Hats Off Admin</title>
</head>

<body>
<cfquery name="getUID" datasource="HatsOff">
	SELECT     administration.emp_full_name, audit.admin_uid
	FROM         administration INNER JOIN
	                      audit ON administration.emp_id = audit.admin_uid
	GROUP by emp_full_name, admin_uid  
</cfquery>
<cfinclude template="../header-award.cfm">
<br>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="200">
	<tr>
		<td align="center">Audit Tool</td>
	</tr>
</table>
<br><br>

<form action="searchemp.cfm" method="post">
<table align="center" border="0" cellpadding="2" cellspacing="0" width="400">
	<tr>
		<td align="center">
			Name: <input type="text" name="name" size="12">
		</td>
		<td align="center">
			UID: <input type="text" name="uid" size="12">
		</td>
	</tr>	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="Search Employees">
		</td>
	</tr>
</table>
</form>


<cfform action="auditexcel.cfm" method="post">
<table align="center" border="0" cellpadding="2" cellspacing="0" width="600">
	<tr>
		<td colspan="2">Enter the audit date range:</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td>
			Start Date:
			<cfinput type="datefield" name="startDate">
		</td>
		<td>
			End Date:
			<cfinput type="datefield" name="endDate">
		</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td>
			Supervisor:<br>
			<select name="name">
				<option value=""></option>
				<cfoutput query="getUID">
				<option value="#admin_uid#">#emp_full_name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center" colspan="2">
			<input type="button" value="Back to Options" onclick="window.location='admin.cfm';">&nbsp;&nbsp;&nbsp;<input type="submit" value="   Submit   ">
			<br><br>
			<input type="button" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
	</tr>
</table>
</cfform>
<cfinclude template="../footer.cfm">
</body>
</html>
