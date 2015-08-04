<cfif startdate is not "">
	<cfset startdate = "#dateformat(startdate, 'yyyy-mm-dd')# 00:00:01">
</cfif>
<cfif enddate is not "">
	<cfset enddate = "#dateformat(enddate, 'yyyy-mm-dd')# 23:59:59">
</cfif>

<cfheader name="Content-Disposition" value="filename=awards_log.xls">
<cfcontent type="application/msexcel">  
<cfquery name="getAudit" datasource="HatsOff">
SELECT     audit.admin_uid, audit.audit_id, audit.nom_id, audit.action, audit.action_date, employees.emp_full_name AS nominee
FROM         audit LEFT OUTER JOIN
                      employees ON audit.nominee_uid = employees.emp_id
WHERE 		0 = 0
<cfif isdefined('startdate')>
	<cfif startdate is not "">
		and action_date >= '#startdate#'
	</cfif>
</cfif>					  
<cfif isdefined('enddate')>
	<cfif enddate is not "">
		and action_date <= '#enddate#'
	</cfif>
</cfif>
<cfif isdefined('name')>
	<cfif name is not "">
		and admin_uid = '#name#'
	</cfif>
</cfif>		
Order by audit_id desc			  
</cfquery>

<html xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http:www.w3.org/TR/REC-html40">
<table border="1" cellpadding="2" width="100%">
	<tr>
		<th>Audit ID</th>
		<th>Supervisor UID</th>
		<!--- <th>Supervisor</th> --->
		<th>Action</th>
		<th>Action Date</th>
		<th>Nomination ID</th>
		<th>Nominee</th>
	</tr>
	<cfoutput query="getAudit">
	<tr>
		<td>#audit_id#</td>
		<td x:str="#admin_uid#">#admin_uid#</td>
		<!--- <td>#getname.emp_full_name#</td> --->
		<td>#action#</td>
		<td>#dateformat(action_date, 'mm/dd/yyyy')# #timeformat(action_date, 'hh:mm tt')#</td>
		<td>#nom_id#</td>
		<td>#nominee#</td>
	</tr>
	</cfoutput>
</table>