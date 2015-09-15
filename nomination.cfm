<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Choose Department', #Now()#, '')
</cfquery>

<cfif session.awardtype is 1>
    <cfquery name="getAchievements" datasource="hatsoff">
        Select * From achievements
        Order by achievement_id
    </cfquery>
</cfif>

<cfif session.awardtype is 2>
<cfquery name="getAchievementsafety" datasource="hatsoff">
	Select * From achievementsafety
	Order by achievement_id
</cfquery>
</cfif>

<CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
	SELECT emp_full_name
	FROM employees
	WHERE emp_id = #session.empUID#
</CFQUERY>.
<cfset emp_full_name = getNominatorDept.emp_full_name>

<cfset session.numNom = #numNom#>

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines --->
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput>The award type is "#session.awardtype#"</cfoutput><br />
<cfoutput>The dept is "#dept#"</cfoutput><br />
<cfoutput>The nominator is #session.empUID#</cfoutput><br />
<cfoutput>The nominator is #emp_full_name#</cfoutput>
<cfoutput>The numNom is #numNom#</cfoutput>

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
<cfset nominator = session.empUID>

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

<hr class="featurette-divider">

<!--- if nomination is single, then do the follow cfform insert --->
<cfif session.numNom is 1>

<!--- pass nomination.getDept & nomination.getEm & achievement values to summary.cfm for confirmation --->
<cfform action="#URLSessionFormat("summary.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr>
		<td>
		<b>1. Select the location where your nominee works:</b>
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
		<b>2. Select the nominee from the list below</b>
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
		<b>3. Select the nominees achievement:</b>
		</td>
	</tr>
	<tr>
		<td>
        	<cfif session.awardtype is 1>
				<cfoutput query="getAchievements">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#"> #achievement#<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em><small>#achievement_descrip#</small></em><br /><br />
                </cfoutput>
            <cfelse>
            	<cfoutput query="getAchievementsafety">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#"> #achievement#<br /><br />
                </cfoutput>
            </cfif>
		</td>	
	</tr>
	<tr><td>&nbsp;</td></tr>

	<tr>
		<td>
		<b>4. In the space provided, describe the nominee's achievement (190 Character Limit):</b> <strong><SPAN id=myCounter1>190</SPAN></strong> remaining</font>
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
		<b>5. Enter the Nominator's name:</b>
		</td>
	</tr>
    <tr><td>&nbsp;</td></tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;
        	<cfoutput>#emp_full_name#</cfoutput><br />
            <cfinput type="hidden" id="nominator" value="#nominator#" name="nominator">
		</td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>
        <td>
        	<cfoutput>If you are assisting someone to do the nomination, please select their name from this menu</cfoutput>                 
        </td>
        <td>>&nbsp;&nbsp;&nbsp;</td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="nominator">
				<option value=""></option>
				<cfoutput query="getEmps">
					<option value="#emp_id#">#emp_full_name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		<b>6. Enter the Supervisor's name:</b>
		</td>
	</tr>
    <tr><td>&nbsp;</td></tr>
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
    <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
	<tr>
		<td>
        	<input type="hidden" name="session.numNom" value ="#session.numNom#">
			<input type="submit" class="btn btn-lg btn-primary" value="  Next  ">
		</td>
    
        <td>
			<input type="button" class="btn btn-lg btn-primary" value="    Log Off   " onclick="window.location='logoff.cfm';">
		</td>
        <td></td>
        <td>
        	<input type="button" class="btn btn-lg btn-primary" value="    Return to Main Screen   " onclick="window.location='loginb.cfm';">
        </td>
	</tr>
</table>
</cfform>
</cfif>

<hr class="featurette-divider">

<!--- if nomination is multiple, then do the follow cfform insert --->
<cfif numNom gt 1>

<!--- pass nomination.getDept & nomination.getEm & achievement values to summary.cfm for confirmation --->
<cfform action="#URLSessionFormat("summary.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
<tr>
		<td>
		1. Enter the Nominator's name:
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<cfoutput>#emp_full_name#</cfoutput><br />
            <cfinput type="hidden" id="nominator" value="#nominator#" name="nominator">
		</td>
        <td>
        	<cfoutput>If you are assisting someone to do the nomination, please select their name from this menu</cfoutput>                
        </td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="nominator">
				<option value=""></option>
				<cfoutput query="getEmps">
					<option value="#emp_id#">#emp_full_name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		2. Enter the Supervisor's name:
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
    <tr>
		<td>
		3. Select the nominees achievement:
		</td>
	</tr>
	<tr>
		<td>
        	<cfif session.awardtype is 1>
				<cfoutput query="getAchievements">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#" tooltip="#achievement_descrip#"> #achievement#<br>
                </cfoutput>
            <cfelse>
            	<cfoutput query="getAchievementsafety">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#"> #achievement#<br>
                </cfoutput>
            </cfif>
		</td>	
	</tr>
</table>

<table align="center" border="1" border-collapse='collapse' cellpadding="0" cellspacing="4" width="400">
	<tr>
        <th>Location Where Nominee Works</th>
        <th>Nominee Name</th>
        <th>Describe Nominee's Achievement (190 Character Limit)</th>
        <th></th>
	</tr>
    <cfloop index="i" from="1" to="#numNom#">
  	<tr>
        <td><cfselect name="department[i]" bind="cfc:nomination.getDept ()" bindonload="true" /></td>
        <td><cfselect name="employee[i]" bind="cfc:nomination.getEmp ({department})" /></td> 
        <td><textarea name="Description[i]" cols="50" rows="6" id="Description"  onkeypress="return LimitThis()" onkeyup="return CountThis(myCounter[i])" onmouseover="return CountThis(myCounter1)" wrap=physical maxLength="190"></textarea></td>
        <td><strong><SPAN id=myCounter[i]>190</SPAN></strong> remaining</font></td>
  	</tr>
    </cfloop>
</table>
<table align="center" border="1" border-collapse='collapse' cellpadding="0" cellspacing="4" width="400">
	<tr align="center">
		<td>
			<input type="submit" class="btn btn-lg btn-primary" value="  Next  ">
			
		</td>
        <td>
        	<input type="button" class="btn btn-lg btn-primary" value="    Log Off   " onclick="window.location='logoff.cfm';">
        </td>
        <td>
        	<input type="button" class="btn btn-lg btn-primary" value="    Return to Main Screen   " onclick="window.location='loginb.cfm';">
        </td>
	</tr>
</table>
</cfform>
</cfif>

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
<cfdump var="#nominator#">

</body>
</html>

<!---
Variables must be passed to summary.cfm
SINGLE NOMINATION
Department - #session.department#<
Nominee - #session.employee#
Achievement - #session.achievement#<
Description - #session.description#
Nominator - #session.nominator#
Supervisor - #supervisor#
numNom = 1
BULK NOMINATION
Department[i] - #session.department#<
Nominee[i] - #session.employee#
Achievement - #session.achievement#<
Description[i] - #session.description#
Nominator - #session.nominator#
Supervisor - #supervisor#
numNom > 1
--->

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