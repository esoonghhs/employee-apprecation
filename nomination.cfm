<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Choose Department', #Now()#, '')
</cfquery>

<cfquery name="getAchievements" datasource="hatsoff">
	Select * From achievements
	Order by achievement_id
</cfquery>

<CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
	SELECT emp_full_name
	FROM employees
	WHERE emp_id = #session.emp_id#
</CFQUERY>.
<cfset emp_full_name = getNominatorDept.emp_full_name>

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines --->
<cfoutput>The award type is "#session.awardtype#"</cfoutput><br />
<cfoutput>The dept is "#dept#"</cfoutput><br />
<cfoutput>The nominator is #session.emp_id#</cfoutput><br />
<cfoutput>The nominator is #emp_full_name#</cfoutput>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags --->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    
	<title>Employee Appreciation  |  UCLA Housing and Hospitality Services</title>
    
    <!--- Bootstrap core CSS --->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/award-style.css" rel="stylesheet">
    <!--- Custom styles for this template --->
    <link href="assets/css/signin.css" rel="stylesheet">
    <link href="assets/css/carousel.css" rel="stylesheet">
</head>

<body onload="document.frmScan.department.focus();">
<!--- From awardtype determine which logo to use --->
<cfif session.awardtype is 1>
	<cfinclude template="header-hatsoff.cfm">
<cfelse> 
	<cfinclude template="header-safety.cfm">
</cfif>

<cfset session.dept = dept>
<cfset session.letter = "0">
<cfset session.ood = "0">

<!--- set session.vdept value --->
<cfif session.dept is "Conferences">
	<cfset session.vdept = "CCMC">
</cfif>
<cfif session.dept is "Dining">
	<cfset session.vdept = "Dining Services">
</cfif>
<cfif session.dept is "HHSAdmin">
	<cfset session.vdept = "HHS Admin">
</cfif>
<cfif session.dept is "HHSIT">
	<cfset session.vdept = "HHS IT">
</cfif>
<cfif session.dept is "Housing">
	<cfset session.vdept = "Housing Services">
</cfif>
<cfif session.dept is "HousingProjects">
	<cfset session.vdept = "Project Management">
</cfif>
<cfif session.dept is "CampusService">
	<cfset session.vdept = "HR and Payroll Center, Admin -North">
</cfif>
<cfif session.dept is "Lake">
	<cfset session.vdept = "Lake Arrowhead">
</cfif>
<cfif session.dept is "Rooms">
	<cfset session.vdept = "Rooms Operations">
</cfif>
<cfif session.dept is "UA">
	<cfset session.vdept = "UA">
</cfif>
<cfif session.dept is "LUSKIN CONFERENCE CENTER">
	<cfset session.vdept = "LUSKIN CONFERENCE CENTER">
</cfif>
<cfif session.dept is "Letter">
	<cfset session.vdept = "Letter">
	<cfset session.letter = "1">
</cfif>

<cfif session.dept is "All">
	<cfset session.vdept = "All">
	<cfset session.ood = "1">
</cfif>

<cfquery name="getEmps" datasource="HatsOff">
	Select emp_id, emp_full_name
	From employees inner join departments on employees.account_number = departments.account_number
	<cfif session.vdept is not "All" and session.vdept is not "Letter">
	Where departments.[departmentname] = '#session.vdept#'
	</cfif>
	Order by emp_full_name
</cfquery>

<!--- pass nomination.getDept & nomination.getEm & achievement values to summary.cfm for confirmation --->
<cfform action="#URLSessionFormat("summary.cfm")#" method="POST" name="frmScan">
<hr class="featurette-divider">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr>
		<td>
		1. Select the location where your nominee works: 
		</td>
	</tr>
	<tr>
		<td>
			<cfselect name="department" bind="cfc:nomination.getDept ()" bindonload="true" />
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		2. Select the nominee from the list below
		</td>
	</tr>
	<tr>
		<td>
			<cfselect name="employee" bind="cfc:nomination.getEmp ({department})" />
		</td>
	</tr>
    <tr><td>&nbsp;</td></tr>

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
    
	<tr>
		<td>
		5. Enter the Nominator's name:
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<cfoutput>#emp_full_name#</cfoutput>
            <input type="hidden" id="nominator" name="nominator" value="#session.emp_id#">
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		6. Enter the Supervisor's name:
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="supervisor">
				<option value=""></option>
				<cfoutput query="getEmps">
					<option value="#emp_id#">#emp_full_name#</option>
				</cfoutput>
			</select>
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
</cfform>

<hr class="featurette-divider">

<cfinclude template="footer.cfm">

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
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
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/vendor/holder.min.js"></script> 
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

<!---  
<cfdump var="#getDept#"><br />
<cfdump var="#getEmp#">
--->

</body>
</html>

<!---
================================================== -->
      <!-- START THE FEATURETTES -->

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7 col-md-push-5">
          <h2 class="featurette-heading">Bulk Nomination <span class="text-muted"></span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5 col-md-pull-7">
          <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <!-- /END THE FEATURETTES -->
    </div><!-- /.container --->