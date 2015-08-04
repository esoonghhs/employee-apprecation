<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Generated Report', #Now()#, '')
</cfquery>

<cfif startdate is not "">
	<cfset startdate = "#dateformat(startdate, 'yyyy-mm-dd')# 00:00:01">
</cfif>
<cfif enddate is not "">
	<cfset enddate = "#dateformat(enddate, 'yyyy-mm-dd')# 23:59:59">
</cfif>

<cfheader name="Content-Disposition" value="filename=awards_log.xls">
<cfcontent type="application/msexcel">   

<cfquery name="getAwards" datasource="#ds.hatsoff#">
SELECT     awards.nom_id, awards.nominee_location, awards.nominee_uid, awards.nominee_achievement_desc, awards.nominator_uid, awards.supervisor_uid, 
                      awards.nomination_status, awards.nomination_createdate, awards.nomination_updatedate, awards.nomination_printdate, awards.letter, 
                      employees.emp_full_name, employees.account_number, employees.fund_number, employees.account_title, achievements.achievement, 
                      departments.[Department Name] as deptname
FROM         awards LEFT JOIN
                      employees ON awards.nominee_uid = employees.emp_id AND awards.nominee_location = employees.account_number INNER JOIN
                      achievements ON awards.nominee_achievement = achievements.achievement_id INNER JOIN
                      departments ON awards.nominee_location = departments.account_number
WHERE 0=0
<cfif isdefined('startdate')>
	<cfif startdate is not "">
		and nomination_createdate >= '#startdate#'
	</cfif>
</cfif>
<cfif (structKeyExists(form, "startID") AND len(form.startID)) AND (structKeyExists(form, "endID") AND len(form.endID))>
	AND awards.nom_ID BETWEEN '#form.startID#' AND '#form.endID#'
</cfif>				  
<cfif isdefined('enddate')>
	<cfif enddate is not "">
		and nomination_createdate <= '#enddate#'
	</cfif>
</cfif>
<cfif isdefined('status')>
	<cfif status is not "" and status is not "All">
		and nomination_status = '#status#'
	</cfif>
</cfif>
<cfif isdefined('department')>
	<cfif department is not "">
		and departments.[department name] = '#department#'
	</cfif>
</cfif>
<cfif isdefined('achievement')>
	<cfif achievement is not "">
		and achievement_id = #achievement# 
	</cfif>
</cfif>
ORDER BY awards.nom_id
</cfquery>



<html xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http:www.w3.org/TR/REC-html40">
<table border="1" cellpadding="2" width="100%">
	<tr>
		<th>Award ID</th>
		<th>UID</th>
		<th>Nominee</th>
		<th>Department Name</th>
		<th>Account Title</th>
		<th>Achievement</th>
		<th>Achievement Description</th>
		<th>Nomination Date</th>
		<th>Nominator</th>
		<th>Supervisor</th>
		<th>Nomination Status</th>
		<th>Award Type</th>
		<th>Approval Date</th>
		<th>Printed Date</th>
	</tr>
	<cfoutput query="getAwards">
	
	<tr>
		<td>#nom_id#<cfif letter is "1">L</cfif></td>
		<td x:str="#nominee_uid#">#nominee_uid#</td>
		<td>#emp_full_name#</td>
		<td>#deptname#</td>
		<td>#account_title#</td>
		<td>#achievement#</td>
		<td>#nominee_achievement_desc#</td>
		<td>#dateformat(nomination_createdate, 'mm/dd/yyyy')#</td>
		<td>
		<cfquery name="getNom" datasource="#ds.hatsoff#">
			Select top 1 emp_full_name
			From employees
			where emp_id = '#nominator_uid#'
		</cfquery>
		#getNom.emp_full_name#
		</td>
		<td>
		<cfquery name="getSup" datasource="#ds.hatsoff#">
			Select top 1 emp_full_name
			From employees
			Where emp_id = '#supervisor_uid#'
		</cfquery>
		#getSup.emp_full_name#
		</td>		
		<td>#nomination_status#</td>
		<td>
			<cfif letter is "1">
				Letter only
			<cfelse>
				Gift Card
			</cfif>
		</td>
		<td>#dateFormat(nomination_updatedate, "mm/dd/yyyy")#</td>
		<td>#dateFormat(nomination_printdate, "mm/dd/yyyy")#</td>
	</tr>

	</cfoutput>
</table>
</html>	
