<cfset startdate = createdatetime(year(now()),1,1,0,0,1)>
<cfset enddate = createdatetime(year(now()),12,31,23,59,59)>

<cfheader name="Content-Disposition" value="filename=awards_log.xls">
<cfcontent type="application/msexcel">
<cfquery name="getAcctNum" datasource="HatsOff">
	Select account_number, account_title
	From departments
	<cfif department is not "All">
	Where [department name] = '#department#'
	</cfif>
	Order by account_title
</cfquery>


<table align="center" border="1" cellpadding="0" cellspacing="0" width="800">
	<tr>
		<th>ACCOUNT TITLE</th>
		<th>TOTAL POSSIBLE AWARDS</th>
		<th>AWARDS TO DATE</th>
	</tr>
<cfloop query="getAcctNum">
	<cfoutput>
	<tr>
		<td>#account_title#</td>
		
		<cfquery name="getPA" datasource="HatsOff">
			Select (count(emp_id) * 3) as totPossAwards
			From employees
			Where account_number = '#getAcctNum.account_number#'
		</cfquery>
		<td align="center">#getPA.totPossAwards#</td>
		
		<cfquery name="getTA" datasource="HatsOff">
			Select count(employees.emp_id) AS totActlAwards
			From employees INNER JOIN
	                      awards ON employees.emp_id = awards.nominee_uid
			Where nomination_createdate >= #startdate#
				and nomination_createdate <= #enddate#
				and employees.account_number = '#getAcctNum.account_number#'
				and nomination_status = 'Printed'
		</cfquery>
		<td align="center">#getTA.totActlAwards#</td>
	</tr>
	</cfoutput>
</cfloop>
</table>