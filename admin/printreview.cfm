<!---<cfdump var="#form#" />
<cfabort>--->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<cfif not isdefined('Aprint')>
	<cfset Aprint = "0">
</cfif>

<cfif Aprint is "0">
	<cfquery datasource="HatsOff">
		Insert into audit
		(admin_uid, nom_id, action, action_date, nominee_uid)
		values
		('#session.emp_id#', 0, 'Print Review', #Now()#, '')
	</cfquery>
</cfif>

<html>
<head>
	<title>Hats Off Admin</title>
</head>

<body>
<cfset startdate = createdatetime(year(now()),1,1,0,0,1)>
<cfset enddate = createdatetime(year(now()),12,31,23,59,59)>
<!--- SELECT     awards.nom_id, awards.nominee_location, awards.nominee_uid, awards.nominee_achievement, awards.nominee_achievement_desc, 
                      achievements.achievement, administration.emp_full_name AS sup_name, administration.username
FROM         awards INNER JOIN
                      achievements ON awards.nominee_achievement = achievements.achievement_id INNER JOIN
                      administration ON awards.supervisor_uid = administration.emp_id --->
<body>
<cfinclude template="../header-award.cfm">
<cfquery name="getAwards" datasource="#ds.hatsoff#">

					  
SELECT     awards.nom_id, awards.nominee_location, awards.nominee_uid, awards.nominee_achievement, awards.nominee_achievement_desc, 
                      achievements.achievement
FROM         awards INNER JOIN
                      achievements ON awards.nominee_achievement = achievements.achievement_id					  
WHERE  nomination_status = 'Approved'
	<cfif session.superuser is "0">
	administration.username = '#session.username#'
	</cfif>
	and nomination_createdate >= #startdate#
	and nomination_createdate <= #enddate#
	<cfif structKeyExists(form, "award")>
	AND awards.nom_id = '#form.award#'
	</cfif>
Order by awards.nom_id
</cfquery>


<table align="center" border="0" cellpadding="1" cellspacing="0" width="90%">
	<tr>
		<td align="center">Review and Print Awards Cards</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
</table>
<form action="printreview.cfm" method="post">
<input type="hidden" name="Aprint" value="1">
<cfif getAwards.recordcount gt "0">
<table align="center" border="0" cellpadding="1" cellspacing="0" width="50%">
	<tr>
		<td align="center">
			Enter nomination #: 
				<cfif getAwards.recordcount gt "0">
				<select name="Award">
					<cfoutput query="getAwards">
						<cfquery name="getName" datasource="#ds.hatsoff#">
							Select emp_full_name
							From employees
							Where emp_id = '#getAwards.nominee_uid#'
						</cfquery>
						<option value="#nom_id#">#nom_id# #getName.emp_full_name#</option>
					</cfoutput>
				</select>
				</cfif>
		</td>
		<td>
			<input type="submit" value="Submit">
		</td>
	</tr>
</table>
<cfelse>
<table align="center" border="0" cellpadding="1" cellspacing="0" width="50%">
	<tr>
		<td align="center">
			No awards to print at this time.
		</td>
	</tr>
</table>
</cfif>

</form>
<cfif Aprint is "1">
<form action="print.cfm" method="post">
<cfquery name="getHat" datasource="#ds.hatsoff#">
	Select nom_id, nominee_uid, nominee_achievement_desc, nomination_createdate, letter
	From awards
	Where nom_id = #Award#
</cfquery>
<cfquery name="getNom" datasource="#ds.hatsoff#">
	Select top 1 emp_full_name
	From employees
	Where emp_id = '#getHat.nominee_uid#'
</cfquery>
<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.username#', 0, 'Print Review', #Now()#, '#getHat.nominee_uid#')
</cfquery>
<cfoutput>
<input type="hidden" name="nom" value="#getHat.nom_id#">
</cfoutput>
<table align="center" border="0" cellpadding="2" cellspacing="0" width="60%">
	<tr>
		<td>Review/Edit:</td>
		<td></td>
	</tr>
	<cfoutput>
	<tr>
		<td width="50%">
			Nom ###getHat.nom_id#
			<cfif getHat.letter is "1">L</cfif>
		</td>
		<td align="right" width="50%">#getNom.emp_full_name# #dateformat(getHat.nomination_createdate, 'm/d/yy')#</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center" colspan="2">
			<textarea cols="100" rows="2" name="theHat" style="font-family:Arial, sans serif;">#getHat.nominee_achievement_desc#
				
			</textarea>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="   Print Card   ">
		</td>
	</tr>
	</cfoutput>
</table>
</form>
</cfif>
<table align="center" border="0" cellpadding="2" cellspacing="0" width="60%">
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center">
			<input type="button" value="Back to Options" onclick="window.location='admin.cfm';">
			<br><br>
			<input type="button" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
	</tr>
</table>

<cfinclude template="../footer.cfm">
</body>
</html>
