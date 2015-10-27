<cfquery datasource="#ds.hatsoff#">
	update awards
	set  nomination_status = 'Printed',
		nomination_printdate = getdate(),
		nominee_achievement_desc = '#trim(theHat)#'
	where nom_id = '#nom#'
</cfquery>

<cfquery name="getAward" datasource="#ds.hatsoff#">
	Select nominee_uid, nominee_achievement_desc, nominator_uid, nom_id, letter
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

<cfquery datasource="#ds.hatsoff#">
	insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', #nom#, 'Printed', #now()#, '#getAward.nominee_uid#')
</cfquery>

<!---<cfoutput>#getAward.nom_id#</cfoutput>
<cfabort>--->

<cfdocument
format = "PDF"
filename = "e:\Inetpub\secure\hatsoff\hats\hat#getAward.nominee_uid#-#getAward.nom_id#.pdf"
overwrite = "yes"
src = "https://#cgi.server_name#/hatsoff\hats\hat#getAward.nominee_uid#-#getAward.nom_id#.pdf"
margintop = ".75"
marginleft = "1"
marginbottom = "1"
marginright = "1"
unit="cm"
>
<cfoutput>
<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr><td height="80">&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center"><font  style="font-size:16px;font-weight:bold;">#getNom.emp_full_name#</font><br>
			<font  style="font-size:14px;">#getNom.department_name#</font><br>
			<font  style="font-size:14px;">#getAward.nom_id#<cfif getAward.letter> - L</cfif></font><br>
		</td>
	</tr>
	<tr><td height="460">&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center" style="font-style:italic;font-size:14px;font-family:cambria;">
			"#getAward.nominee_achievement_desc#"<br>
		</td>
	</tr>
	<tr>
		<td align="center" height="200" valign="top" style="font-style:italic;font-size:14px;">
			<br>
			<br>
			- #getNom2.emp_full_name#, #getNom2.department_name#
		</td>
	</tr>
</table>
</cfoutput>
</cfdocument>

<cfoutput>
<script language="JavaScript">
	function poponLoad()
	{
	window.open("../hats/hat#getAward.nominee_uid#-#getAward.nom_id#.pdf", "", "width=400,height=900,resizable=yes,scrollbars=yes,toolbar=yes");
	
	}
</script>
</cfoutput>

<!--- window.location.href='printreview.cfm'; --->
<cfinclude template="../header-award.cfm">
 <body onLoad="javascript: poponLoad()">
<form action="print.cfm" method="post">
<cfoutput>
<input type="hidden" name="nom" value="#nom#">
<input type="hidden" name="thehat" value="#thehat#">
</cfoutput>
 <table align="center" border="0" cellpadding="0" cellspacing="0" width="50%">
 	<tr>
		<td align="center">
			Did the Hat Award print successfully?
		</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center">
			<input type="submit" value="  Reprint  ">&nbsp;&nbsp;&nbsp;<input type="button" value="  Next Award  " onClick="window.location='printreview.cfm';">
		</td>
	</tr>
 </table>
</form>
</body>
<cfinclude template="../footer.cfm">