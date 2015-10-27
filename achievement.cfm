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
	('#session.emp_id#', 0, 'Choose Nominee', #Now()#, '#employee#')
</cfquery>
<html>
<head>
	<title>Hats Off</title>
</head>

<cfif len(employee) is "6">
	<cfset employee = "000" & employee>
</cfif>
<cfif len(employee) is "7">
	<cfset employee = "00" & employee>
</cfif>
<cfif len(employee) is "8">
	<cfset employee = "0" & employee>
</cfif>

<cfset session.department = department>
<cfset session.employee = employee>

<cfset startdate = createdatetime(year(now()), 1, 1, 00, 00, 01)>
<cfset enddate = createdatetime(year(now()), 12, 31, 23, 59, 59)>

<cfquery name="getEmp" datasource="hatsoff">
	Select emp_full_name
	From employees
	Where emp_id = '#session.employee#'
</cfquery>

<cfquery name="chkApproved" datasource="hatsoff">
	Select count(nom_id) as Acount
	From awards
	Where nominee_uid = '#session.employee#'
		and (nomination_status = 'Approved'
			or nomination_status = 'Printed')
		and nomination_updatedate > #startdate#
		and nomination_updatedate < #enddate#
</cfquery>

<cfif chkApproved.Acount gte "3">
	<cfset session.letter = "1">
</cfif>

<cfquery name="chkPending" datasource="hatsoff">
	Select count(nom_id) as Pcount
	From awards
	Where nominee_uid = '#session.employee#'
		and nomination_status = 'Pending'
		and nomination_createdate > #startdate#
		and nomination_createdate < #enddate#
</cfquery>

<cfquery name="getAchievements" datasource="hatsoff">
	Select * From achievements
	Order by achievement_id
</cfquery>

<body>
<cfinclude template="header-award.cfm">
<form action="nominator.cfm" name="myform" method="post">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr>
		<td>
				<cfoutput>#getEmp.emp_full_name# has #chkApproved.Acount# approved nominations this calendar year and #chkPending.Pcount# pending nominations. </cfoutput>
		</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td>
		3. Select the nominees achievement:
		</td>
	</tr>
	<tr>
		<td>
			<cfoutput query="getAchievements">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="achievement" value="#achievement_id#"> #achievement#<br>
			</cfoutput>
		</td>	
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		4. In the space provided, describe the nominee's achievement (190 Character Limit): <strong><SPAN id=myCounter1>190</SPAN></strong> remaining</font>
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<textarea name="Description" cols="50" rows="6" id="Description"  onkeypress="return LimitThis()" onkeyup="return CountThis(myCounter1)" onmouseover="return CountThis(myCounter1)" wrap=physical maxLength="190" style="font-family:arial,helvetica, sans-serif;"></textarea>
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
