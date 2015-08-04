
<cfquery name="chkEmps" datasource="HatsOff">
	Select *
	From employees
	Where 0 = 0
	<cfif isdefined('name')>
		<cfif name is not "">
			and emp_full_name like '%#name#%'
		</cfif>
	</cfif>
	<cfif isdefined('uid')>
		<cfif uid is not "">
			and emp_id like '%#uid#%'
		</cfif>
	</cfif>
</cfquery>

<table border="0" cellpadding="2" width="100%">
	<tr>
		<td align="center" colspan="5">
			<input type="button" value="Back to the Audit Tool" onclick="window.location='audit.cfm';">
		</td>
	</tr>
	<tr>
		<th>UID</th>
		<th>Full Name</th>
		<th>Account Number</th>
		<th>Fund Number</th>
		<th>Account Title</th>
	</tr>
	<cfoutput query="chkEmps">
	<tr>
		<td align="center">#emp_id#</td>
		<td align="center">#emp_full_name#</td>
		<td align="center">#account_number#</td>
		<td align="center">#fund_number#</td>
		<td align="center">#account_title#</td>
	</tr>
	</cfoutput>
</table>