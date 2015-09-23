<!--- Variables with values passed from summary.cfm
session.awardtype
session.department
session.employee
session.achievement
session.description
session.nominator
--->
			
<!--- <cfif awardTypeController eq 0> --->
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
<!--- </cfif> --->

<!--- <cfif awardTypeController eq 1>
<cfif awardtype is 1>
    <cfquery name="getAchievements" datasource="hatsoff">
        Select * From achievements
        Order by achievement_id
    </cfquery>
</cfif>

<cfif awardtype is 2>
<cfquery name="getAchievementsafety" datasource="hatsoff">
	Select * From achievementsafety
	Order by achievement_id
</cfquery>
</cfif>
</cfif> --->

<CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
	SELECT emp_full_name
	FROM employees
	WHERE emp_id = #session.empUID#
</CFQUERY>.
<cfset emp_full_name = getNominatorDept.emp_full_name>

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines --->
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<!--- <cfoutput>The award type is "#session.awardtype#"</cfoutput><br />
<cfoutput>The dept is "#dept#"</cfoutput><br />
<cfoutput>The nominator is #session.empUID#</cfoutput><br />
<cfoutput>The nominator is #emp_full_name#</cfoutput>
<cfoutput>The numNom is #numNom#</cfoutput> 
<cfoutput>The awardTypeController is #awardTypeController#</cfoutput><br /> --->
<cfoutput>#session.description#</cfoutput>

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

<body>
<!--- From awardtype determine which variable to use to determine logo --->
<!--- <cfif awardTypeController eq 0> --->
	<cfif session.awardtype is 1>
        <cfinclude template="header-hatsoff.cfm">
    <cfelse> 
        <cfinclude template="header-safety.cfm">
    </cfif><br />
<!--- </cfif> --->

<!--- <cfif awardTypeController eq 1>
	<cfif awardtype is 1>
        <cfinclude template="header-hatsoff.cfm">
    <cfelse> 
        <cfinclude template="header-safety.cfm">
    </cfif><br />
</cfif> 

<cfset session.dept = dept>
<cfset session.letter = "0">
<cfset session.ood = "0">
<cfset nominator = session.empUID> --->

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

<cfquery name="getDept" datasource="HatsOff">
        SELECT account_number, account_title
        FROM departments
		<cfif session.vdept is not "All" and session.vdept is not "Letter">
			WHERE departmentname = '#session.vdept#'  
		</cfif>
        ORDER BY account_title 
</cfquery>

<cfquery name="getEmployees" datasource="HatsOff">
        SELECT emp_id, emp_full_name
        FROM employees
        WHERE account_number = '#getDept.account_number#'
        ORDER BY emp_full_name
</cfquery>

<hr class="featurette-divider">

<cfset department = "760416">
<cfset employee = "203348153">

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
			<cfselect name="department" required="yes">
				<cfoutput query="getDept">
					<option value="#account_number#" <cfif #session.department# eq #account_number#>selected="selected"</cfif> >#account_title#</option>
				</cfoutput>
			</cfselect>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		<b>2. Select the nominee from the list below</b>
		</td>
	</tr>
    	<td>
			<cfselect name="employee" required="yes">
				<cfoutput query="getEmployees">
					<option value="#emp_id#" <cfif #session.employee# eq #emp_id#>selected="selected"</cfif>>#emp_full_name#</option>
				</cfoutput>
			</cfselect>
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
			<!--- <cfif awardTypeController eq 0> --->
				<cfif session.awardtype is 1>
                    <cfoutput query="getAchievements">
                     <dl><input type="radio" name="achievement" value="#achievement_id#" <cfif #session.achievement# eq #achievement_id#>checked="checked"</cfif>><dt>#achievement#</dt><em><small><dd>#achievement_descrip#</dd></dl></small></em>
                    </cfoutput>
                <cfelse>
                    <cfoutput query="getAchievementsafety">
                    <input type="radio" name="achievement" value="#achievement_id#" <cfif #session.achievement# eq #achievement_id#>checked="checked"</cfif>> #achievement#<br /><br />
                    </cfoutput>
                </cfif>
            <!--- </cfif> --->
            
            <!---  <cfif awardTypeController eq 1>
				<cfif awardtype is 1>
                    <cfoutput query="getAchievements">
                     <dl><cfinput type="radio" name="achievement" value="#achievement_id#" <cfif #session.achievement# eq #achievement_id#>checked="checked"</cfif>><dt>#achievement#</dt><em><small><dd>#achievement_descrip#</dd></dl></small></em>
                    </cfoutput>
                <cfelse>
                    <cfoutput query="getAchievementsafety">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#" <cfif #session.achievement# eq #achievement_id#>checked="checked"</cfif>> #achievement#<br /><br />
                    </cfoutput>
                </cfif>
            </cfif> --->
		</td>	
	</tr>
	<tr><td>&nbsp;</td></tr>

	<tr>
		<td>
		<b>4. In the space provided, describe the nominee's<br />&nbsp;&nbsp;&nbsp;&nbsp;achievement:</b> <strong><SPAN id=myCounter1>190</SPAN></strong> Characters Remaining</td>
	</tr>
	<tr>
		<td>
			<textarea name="description" cols="50" rows="6" id="Description"  placeholder="Achievement description" onkeypress="return LimitThis()" onkeyup="return CountThis(myCounter1)" onmouseover="return CountThis(myCounter1)" wrap=physical maxLength="190" style="font-family:arial,helvetica, sans-serif;"><cfoutput>#session.description#</cfoutput></textarea>
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
            <cfinput type="hidden" id="nominator" value="#session.nominator#" name="session.nominator">
		</td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>
        <td>
        	<cfoutput>&nbsp;&nbsp;&nbsp;&nbsp;If you are assisting someone to do the nomination,<br />&nbsp;&nbsp;&nbsp;&nbsp;please select their name from this menu</cfoutput>                 
        </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="nominatorAnother">
				<option value=""></option>
				<cfoutput query="getEmps">
					<option value="#emp_id#" <cfif #session.nominator# eq #emp_id#>selected="selected"</cfif>>#emp_full_name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
	<tr>
        <td>
        	<!--- <cfset session.awardtypeController = #awardtypeController#> --->
        	<input type="hidden" name="session.numNom" value ="#session.numNom#">
            <cfinput type="Hidden" name="session.awardtypeController" value="#session.awardtypeController#">
            <cfif StructKeyExists(form, "awardtype")>
				<cfinput type="Hidden" name="awardtype" value="#awardtype#">
            </cfif>
			<input align="center" type="submit" class="btn btn-lg btn-primary" value="  Next  ">
		</td>
	</tr>
</table>
</cfform>
</cfif>

<hr class="featurette-divider">

<!--- if nomination is multiple, then do the follow cfform insert --->
<cfif session.numNom gt 1>








<!--- pass nomination.getDept & nomination.getEm & achievement values to summary.cfm for confirmation --->
<cfform action="#URLSessionFormat("summary.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		<b>1. Enter the Nominator's name:</b>
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
        	<cfoutput>&nbsp;&nbsp;&nbsp;&nbsp;If you are assisting someone to do the nomination,<br />&nbsp;&nbsp;&nbsp;&nbsp;please select their name from this menu</cfoutput>                 
        </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="nominatorAnother">
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
		2. Select the location where your nominee works: 
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
		<b>3. Select the nominees achievement:</b>
		</td>
	</tr>
	<tr>
		<td>
			<cfif awardTypeController eq 0>
				<cfif session.awardtype is 1>
                    <cfoutput query="getAchievements">
                     <dl><cfinput type="radio" name="achievement" value="#achievement_id#" checked=#checked#><dt>#achievement#</dt><em><small><dd>#achievement_descrip#</dd></dl></small></em>
                    </cfoutput>
                <cfelse>
                    <cfoutput query="getAchievementsafety">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#" checked="#checked#"> #achievement#<br /><br />
                    </cfoutput>
                </cfif>
            </cfif>
            
            <cfif awardTypeController eq 1>
				<cfif awardtype is 1>
                    <cfoutput query="getAchievements">
                     <dl><cfinput type="radio" name="achievement" value="#achievement_id#" checked=#checked#><dt>#achievement#</dt><em><small><dd>#achievement_descrip#</dd></dl></small></em>
                    </cfoutput>
                <cfelse>
                    <cfoutput query="getAchievementsafety">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="radio" name="achievement" value="#achievement_id#" checked="#checked#"> #achievement#<br /><br />
                    </cfoutput>
                </cfif>
            </cfif>
		</td>	

</table>

<table align="center" border="1" border-collapse='collapse' cellpadding="0" cellspacing="4" width="400">
	<tr>
        <th>Nominee Names</th>
        <th>In the space provided, describe the nominee's achievement</th>
        <th></th>
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
<cfdump var="#getDept#"><br />--->
<cfdump var="#getDept.account_title#"><br />
<cfdump var="#getEmployees.emp_full_name#"><br />
<cfdump var="#getDept#"><br />
<cfdump var="#getEmployees#"><br />

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