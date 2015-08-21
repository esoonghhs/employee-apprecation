<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<script language = "Javascript">

function LimitThis() {
	var myObject=event.srcElement;
	if (myObject.value.length==myObject.maxLength*1) return false;
}

function CountThis(visCnt) { 
	var myObject=event.srcElement;
	if (myObject.value.length>myObject.maxLength*1) myObject.value=myObject.value.substring(0,myObject.maxLength*1);
	if (visCnt) visCnt.innerText=myObject.maxLength-myObject.value.length;
	
}
</script>
<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Reviewed Nominations', #Now()#, '')
</cfquery>
<html>
<head>
	<title>Hats Off Admin</title>
</head>

<cfset startdate = createdatetime(year(now()),1,1,0,0,1)>
<cfset enddate = createdatetime(year(now()),12,31,23,59,59)>

<body>
<cfinclude template="../header-award.cfm">

<cfquery name="getDept" datasource="#ds.hatsoff#">
SELECT     employees.emp_id, employees.emp_full_name, employees.account_number, employees.fund_number, employees.account_title, 
                      departments.[Department Name] as deptname
FROM         employees INNER JOIN
                      departments ON employees.account_number = departments.account_number
WHERE employees.emp_id = '#session.emp_id#'					  
</cfquery>

<cfquery name="getAwards" datasource="#ds.hatsoff#">
SELECT     awards.nom_id, employees.emp_id, employees.emp_full_name, employees.account_number, employees.fund_number, employees.account_title, 
                      departments.[Department Name], awards.nominee_uid, awards.nominee_achievement_desc, awards.nominator_uid, achievements.achievement
FROM         employees INNER JOIN
                      departments ON employees.account_number = departments.account_number INNER JOIN
                      awards ON employees.emp_id = awards.nominee_uid AND employees.account_number = awards.nominee_location INNER JOIN
                      achievements ON awards.nominee_achievement = achievements.achievement_id
WHERE  nomination_status = 'Pending'
	<cfif session.superuser is "0">
	and [department name] = '#getDept.deptname#'
	</cfif>
	<!---change this for people who only want to see out of department--->
	<cfif session.emp_id IS "903263305">
	and awards.ood = 1
	<cfelse>
	and awards.ood = 0
	</cfif>
	and nomination_createdate >= #startdate#
	and nomination_createdate <= #enddate#
Order by awards.nom_id
</cfquery>

<form action="submit.cfm" method="post" name="myform">
<cfoutput>
<input type="hidden" name="count" value="#getAwards.recordcount#">
</cfoutput>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
	<tr>
		<td>Nomination Review</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
</table>
<table width="90%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolor="#0000FF">
	<tr>
		<th bgcolor="#0000ff"><font color="white">yes</font></th>
		<th bgcolor="#0000ff"><font color="white">no</font></th>
		<th bgcolor="#0000ff"><font color="white">pending</font></th>
		<th bgcolor="#0000ff"><font color="white">Nominee</font></th>
		<th bgcolor="#0000ff"><font color="white">Nominator</font></th>
		<th bgcolor="#0000ff"><font color="white">Award</font></th>
		<th bgcolor="#0000ff"><font color="white">Description</font></th>
	</tr>
	<cfif getAwards.recordcount is "0">
	<tr>
		<td align="center" colspan="6">
			<br>
			There are no awards to approve at this time.<br>
			<input type="button" value="Back to Options" onclick="window.location='admin.cfm';">
			<br>
		</td>
	</tr>
	</cfif>
	<cfif getAwards.recordcount gt "0">
	<cfoutput query="getAwards">
	<cfquery name="getNames" datasource="#ds.hatsoff#">
		Select emp_full_name
		From employees
		Where emp_id = #nominee_uid#
	</cfquery>
	<cfquery name="Nominator" datasource="#ds.hatsoff#">
		Select emp_full_name
		From employees
		Where emp_id = #nominator_uid#
	</cfquery>
	<tr>
		<td align="center" width="5%"><input type="radio" name="confirm#currentrow#" value="1"><input type="hidden" name="nom#currentrow#" value="#nom_id#"></td>
		<td align="center" width="5%"><input type="radio" name="confirm#currentrow#" value="0"></td>
		<td align="center" width="5%"><input type="radio" name="confirm#currentrow#" value="2" checked></td>
		<td width="15%" style="font-size:12px;" nowrap>#getNames.emp_full_name#</td>
		<td width="15%" style="font-size:12px;" nowrap>#nominator.emp_full_name#</td>
		<td width="20%" style="font-size:12px;" nowrap>#achievement#</td>
		<td width="40%" style="font-size:12px;">
			<textarea name="desc#currentrow#"  id="Description"  onkeypress="return LimitThis()" onkeyup="return CountThis(myCounter1)" onmouseover="return CountThis(myCounter1)" wrap="physical" maxLength="190" cols="70" rows="2" maxlength="190" style="FONT-FAMILY: Arial, Helvetica, sans-serif;">#nominee_achievement_desc#
			</textarea>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td align="center" colspan="6">
			<input type="button" value="Back to Options" onclick="window.location='admin.cfm';">&nbsp;&nbsp;&nbsp;<input type="submit" value="Submit Awards">
		</td>
	</tr>
	</cfif>
</table>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="50%">
	<tr>
		<td align="center">
			<br><br>
			<input type="button" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
	</tr>
</table>
</form>
<cfinclude template="../footer.cfm">
</body>
</html>
