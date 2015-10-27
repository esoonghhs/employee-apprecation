<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfset startdate = createdatetime(year(now()),1,1,0,0,1)>
<cfset enddate = createdatetime(year(now()),12,31,23,59,59)>

<body>
<cfinclude template="../header-award.cfm">
<cfquery name="getAwards" datasource="#ds.hatsoff#">
SELECT     awards.nom_id, awards.nominee_location, awards.nominee_uid, awards.nominee_achievement, awards.nominee_achievement_desc, 
                      achievements.achievement, administration.emp_full_name AS sup_name, administration.username
FROM         awards INNER JOIN
                      achievements ON awards.nominee_achievement = achievements.achievement_id INNER JOIN
                      administration ON awards.supervisor_uid = administration.emp_id
WHERE  nomination_status = 'Approved'
	<cfif session.superuser is "0">
	administration.username = '#session.username#'
	</cfif>
	and nomination_createdate >= #startdate#
	and nomination_createdate <= #enddate#
Order by awards.nom_id
</cfquery>

<form action="print.cfm" method="post">
<cfoutput>
<input type="hidden" name="count" value="#getAwards.recordcount#">
</cfoutput>
<table align="center" border="0" cellpadding="1" cellspacing="0" width="90%">
	<tr>
		<td align="center">Review and Print Awards Cards</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
</table>
<table width="90%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="#0000FF">
	<tr>
		<th bgcolor="#0000ff"><font color="white">yes</font></th>
		<th bgcolor="#0000ff"><font color="white">no</font></th>
		<th bgcolor="#0000ff"><font color="white">Name</font></th>
		<th bgcolor="#0000ff"><font color="white">Award</font></th>
		<th bgcolor="#0000ff"><font color="white">Description</font></th>
	</tr>
	<cfif getAwards.recordcount is "0">
	<tr>
		<td align="center" colspan="5">
			<br>
			There are no awards to print at this time.<br>
			<input type="button" value="Back" onclick="window.location='admin.cfm';">
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
	<tr>
		<td align="center" width="5%"><input type="radio" name="confirm#currentrow#" value="1" checked><input type="hidden" name="nom#currentrow#" value="#nom_id#"></td>
		<td align="center" width="5%"><input type="radio" name="confirm#currentrow#" value="0"></td>
		<td width="25%" nowrap>#getNames.emp_full_name#</td>
		<td width="25%" nowrap>#achievement#</td>
		<td width="40%">
			<textarea cols="30" rows="2" name="desc#currentrow#" style="font-family:arial;">#nominee_achievement_desc#
			</textarea>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td align="center" colspan="5"><input type="submit" value="Submit Awards"></td>
	</tr>
	</cfif>
</table>
</form>

<cfinclude template="../footer.cfm">
</body>
</html>
