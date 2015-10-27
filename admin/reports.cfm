<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Creating Report', #Now()#, '')
</cfquery>
<html>
<head>
	<title>Hats Off Admin</title>
</head>

<body>

<cfif session.admin is "0">
	<cflocation url="login.cfm">
	<cfabort>
</cfif>

<cfquery name="getDept" datasource="#ds.hatsoff#">
	Select [department name] as deptname From departments
	Group by [department name]
	Order by [department name] 
</cfquery>
<cfquery name="getSupDept" datasource="#ds.hatsoff#">
	SELECT     departments.[Department Name] as deptname, employees.emp_id
	FROM         employees INNER JOIN
                      departments ON employees.account_number = departments.account_number
	WHERE employees.emp_id = '#session.emp_id#'
</cfquery>
<cfquery name="getAch" datasource="#ds.hatsoff#">
	Select * From achievements
	Order by achievement
</cfquery>
<cfinclude template="../header-award.cfm">
<cfform action="excelreport.cfm" method="post">

<table align="center" border="0" cellpadding="0" cellspacing="0" width="200">
	<tr>
		<td align="center">Report Tool</td>
	</tr>
</table>
<br>
<table align="center" border="0" cellpadding="2" cellspacing="0" width="600">
	<tr>
		<td colspan="2">Enter the nomination creation date range:</td>
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
	<tr>
		<td></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
			Start ID:<br />
			<input type="text" name="startID">
		</td>
		<td>
			End ID:<br />
			<input type="text" name="endID">
		</td>
	</tr>
	<tr>
		<td></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Select which data to include:</td>
	</tr>
	<tr><td colspan="2">&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td>
			<select name="status">
				<option value="">-- choose a status --</option>
				<option value="Approved">approved nominations</option>
				<option value="Denied">rejected nominations</option>
				<option value="Pending">pending nominations</option>
				<option value="Printed">printed nominations</option>
				<option value="All">all nominations</option>
			</select>
		</td>
		<td>
			<select name="achievement">
				<option value="">-- choose achievement --</option>
				<cfoutput query="getAch">
					<option value="#achievement_id#">#achievement#</option>
				</cfoutput>
			</select>
			
		</td>
		
	</tr>	
	<tr><td colspan="2">&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td>
			<cfif session.superuser is "1">	
			<select name="department">
				<option value="">-- choose a department --</option>
				<cfoutput query="getDept">
					<option value="#deptname#">#deptname#</option>
				</cfoutput>
			</select>
			<cfelse>
				<cfoutput>
				<input type="hidden" name="department" value="#getSupDept.deptname#">
				</cfoutput>
			</cfif>		
		</td>
		<td>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="   Submit   ">
		</td>
	</tr>
</table>
</cfform>
<cfif session.username is "rgilbert" or session.username is "avasquez">
<hr>
<form action="ytdexcel.cfm" method="post">
<cfoutput>
<cfif session.username is "rgilbet">
	<input type="hidden" name="department" value="All">
<cfelse>
	<input type="hidden" name="department" value="#getSupDept.deptname#">
</cfif>
</cfoutput>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="600">
	<tr>
		<td align="center">
			Year To Date Report Tool
			<br>
		</td>
	</tr>
	<tr>
		<td align="center">
			<br>
			<input type="submit" value="  Submit  ">
		</td>
	</tr>
</table>
</form>
</cfif>
<hr>
<table align="center" cellpadding="0" cellspacing="0" border="0" width="200">
	<tr>
		<td>
			<input type="button" value="Back to Options" onclick="window.location='admin.cfm';">&nbsp;&nbsp;&nbsp;<input type="button" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
	</tr>
</table>
<cfinclude template="../footer.cfm">
</body>
</html>
