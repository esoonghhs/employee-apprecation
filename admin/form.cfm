<cfquery name="getAward" datasource="#ds.hatsoff#">
	Select nominee_uid, nominee_achievement_desc, nominator_uid
	From awards
	Where nom_id = #nom#
</cfquery>
<cfquery name="getNom" datasource="#ds.hatsoff#">
SELECT     top 1 employees.emp_id, employees.emp_full_name, departments.[Department Name] as department_name
FROM         employees INNER JOIN
                      departments ON employees.account_number = departments.account_number
WHERE 	emp_id = '#getAward.nominee_uid#'				  
</cfquery>
<cfquery name="getNom2" datasource="#ds.hatsoff#">
SELECT     top 1 employees.emp_id, employees.emp_full_name, departments.[Department Name] as department_name
FROM         employees INNER JOIN
                      departments ON employees.account_number = departments.account_number
WHERE emp_id = '#getAward.nominator_uid#'					  
</cfquery>
<body>


<cfoutput>
<div align="center" style="position:absolute;top:0;left:70;">
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="center">#getNom.emp_full_name#<br>
			#getNom.department_name#<br>
		</td>
	</tr>
	<tr><td height="490">&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center" style="font-style:italic;">
			"#getAward.nominee_achievement_desc#"<br>
		</td>
	</tr>
	<tr>
		<td align="center" height="200" valign="top">
			<br>
			- #getNom2.emp_full_name# #getNom2.department_name#
		</td>
	</tr>
</table>
</div>
<!--- <div align="center" style="position:relative;top:0;">
#getNom.emp_full_name#<br>
#getNom.department_name#<br>
</div>
<br>
<div align="center" style="position:relative;top:470;font-style:italic;">
"#getAward.nominee_achievement_desc#"<br>
</div>
<br>
<div align="center" style="position:relative;top:500;">
- #getNom2.emp_full_name# #getNom2.department_name#
</div> --->
</cfoutput>

</body>
</html>
