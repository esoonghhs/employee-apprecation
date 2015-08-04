<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<cfif not isdefined('achievement')>
	<cfoutput>
	<script language="javascript">
	var agree=alert("You must pick an Achievement. Please go back and make a selection.");
	if (agree)
	history.go(-1);
	else
	history.go(-1);
	</script>
	</cfoutput>
	<cfabort>
</cfif>

<cfif description is "">
	<cfoutput>
	<script language="javascript">
	var agree=alert("You must provide an Achievement Description. Please go back and fill out the text box.");
	if (agree)
	history.go(-1);
	else
	history.go(-1);
	</script>
	</cfoutput>
	<cfabort>
</cfif>

<cfif isdefined('description')>
	<cfset formlen = "#len(description)#">
	<cfif formlen gt "190">
		<cfoutput>
		<script language="javascript">
		var agree=alert("The length of the Achievement description cannot be more than 190 characters including spaces. Please go back and edit.");
		if (agree)
		history.go(-1);
		else
		history.go(-1);
		</script>
		</cfoutput>
		<cfabort>		
	</cfif>	
</cfif>

<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Picked Award', #Now()#, '#session.employee#')
</cfquery>
<html>
<head>
	<title>Hats Off</title>
</head>

<body onload="document.frmScan.nominator.focus();">
<cfinclude template="header.cfm">

<cfset session.achievement = achievement>
<cfset session.description = description>

<cfquery name="getEmps" datasource="HatsOff">
	Select emp_id, emp_full_name
	From employees inner join departments on employees.account_number = departments.account_number
	<cfif session.vdept is not "All" and session.vdept is not "Letter">
	Where departments.[department name] = '#session.vdept#'
	</cfif>
	Order by emp_full_name
</cfquery>
<form action="process.cfm" method="post" name="frmScan">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr>
		<td>
		5. Enter the Nominator's name:
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="nominator">
				<option value=""></option>
				<cfoutput query="getEmps">
					<option value="#emp_id#">#emp_full_name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		6. Enter the Supervisor's name:
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="supervisor">
				<option value=""></option>
				<cfoutput query="getEmps">
					<option value="#emp_id#">#emp_full_name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr align="center">
		<td>
			<input type="submit" value="  Next  ">
			<br><br>
			<input type="button" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
	</tr>
</table>
</form>
<cfinclude template="footer.cfm">
</body>
</html>
