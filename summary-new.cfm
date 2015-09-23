<!---
Variables must be passed from nomination.cfm
SINGLE NOMINATION
Department - #session.department#<
Nominee - #employee#
Achievement - #achievement#<
Description - #description#
Nominator - #session.nominator#
numNom = 1
BULK NOMINATION
Department[i] - #session.department#
Nominee[i] - #session.employee#
Achievement - #session.achievement#
Description[i] - #session.description#
Nominator - #session.nominator#
numNom > 1
--->



<cfif achievement is ''>
	<cfoutput><b>You did not select an achievement. Please do so. Please click <Edit> button below to go back to nomination form to make an achievement selection.</b></cfoutput>
</cfif>

<!--- Find selected nominee name --->
<CFQUERY NAME="getNomineeName" DATASOURCE="hatsoff">
	SELECT emp_full_name
	FROM employees
	WHERE emp_id = #employee#
</CFQUERY>.
<cfset nomineeName = getNomineeName.emp_full_name>

<!--- Find selected department name --->
<CFQUERY NAME="getDeptName" DATASOURCE="hatsoff">
	SELECT DepartmentName
	FROM departments
	WHERE account_number = #department#
</CFQUERY>.
<cfset deptName = getDeptName.DepartmentName>

<!--- Find selected achievement description --->
<CFQUERY NAME="getAchievement1" DATASOURCE="hatsoff">
	SELECT achievement
	FROM achievements
	WHERE achievement_id = #achievement#
</CFQUERY>.
<cfset achievDesc1 = getAchievement1.achievement>

<!--- Find selected achievementsafety description --->
<CFQUERY NAME="getAchievement2" DATASOURCE="hatsoff">
	SELECT achievement
	FROM achievementsafety
	WHERE achievement_id = #achievement#
</CFQUERY>.
<cfset achievDesc2 = getAchievement2.achievement>

<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />

<!--- Set the desired nominator --->
<cfoutput>Nominator is #nominator#</cfoutput><br />
<cfoutput>The replacement nominator is #nominatorAnother#</cfoutput><br />
<cfif len(#nominatorAnother#) eq 0>
	<cfset nominator = #nominator#>
<cfelse>
	<cfset nominator = #nominatorAnother#>
</cfif>
<cfoutput>Nominator is #nominator#</cfoutput><br />

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines 
<cfoutput>The award type is "#session.awardtype#"</cfoutput><br />
<cfoutput>The session.dept is "#session.dept#"</cfoutput><br />
<cfoutput>#employee#</cfoutput><br />
<cfoutput>#achievement#</cfoutput><br />
<cfoutput>#description#</cfoutput><br />
<cfoutput>The session numNom is #session.numNom#</cfoutput> --->


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
    <link href="assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <!--- Custom styles for this template --->
    <link href="assets/css/signin.css" rel="stylesheet">
    <link href="assets/css/carousel.css" rel="stylesheet">
    <link href="assets/css/theme.css" rel="stylesheet">
</head>

<body onload="document.frmScan.nomination.focus();">
<!--- From awardtype determine which variable to use to determine logo --->
<cfif session.awardtypeController eq 0>
	<cfif session.awardtype is 1>
        <cfinclude template="header-hatsoff.cfm">
    <cfelse> 
        <cfinclude template="header-safety.cfm">
    </cfif>
</cfif>

<cfif session.awardtypeController eq 1>
	<cfif awardtype is 1>
        <cfinclude template="header-hatsoff.cfm">
    <cfelse> 
        <cfinclude template="header-safety.cfm">
    </cfif>
</cfif>

<cfif session.numNom is 1>
<div class="container">
<div class="page-header">
        <h1 class="text-center">Summary of Your Nomination</h1>
      </div>
      <div class="row">
        <div class="col-md-12">
          <table class="table">
            <thead>
              <tr>
                <th>Department</th>
                <th>Nominee</th>
                <th>Achievement</th>
                <th>Description</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><cfoutput>#deptName#</cfoutput></td>
                <td><cfoutput>#nomineeName#</cfoutput></td>
                <td>
                 	<cfif session.awardtypeController eq 0>
						<cfif session.awardtype is 1>
							<cfoutput>#achievement#&nbsp;&nbsp;&nbsp;#achievDesc1#</cfoutput>
                        <cfelse>
                    		<cfoutput>#achievement#&nbsp;&nbsp;&nbsp;#achievDesc2#</cfoutput>
                        </cfif>
                    </cfif>
                    <cfif session.awardtypeController eq 1>
						<cfif awardtype is 1>
							<cfoutput>#achievement#&nbsp;&nbsp;&nbsp;#achievDesc1#</cfoutput>
                        <cfelse>
                    		<cfoutput>#achievement#&nbsp;&nbsp;&nbsp;#achievDesc2#</cfoutput>
                        </cfif>
                    </cfif>
                </td>
                <td><cfoutput>#Description#</cfoutput></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
</div>
</cfif>

<cfif session.numNom GT 1>
<div class="container">
	<div class="page-header">
        <h1 class="text-center">Summary of Your Nomination</h1>
	</div>
      <div class="row">
        <div class="col-md-12">
          <table class="table">
            <tbody>
              <tr>
                <td>Achievement</td>
                <td><cfoutput>#achievement#</cfoutput></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <table class="table">
            <thead>
              <tr>
                <th>Department</th>
                <th>Nominee</th>
                <th>Description</th>
              </tr>
            </thead>
            <tbody>
            <cfloop index="i" from="1" to="#numNom#">
              <tr>
                <td><cfoutput>#department[i]#</cfoutput></td>
                <td><cfoutput>#employee[i]#</cfoutput></td>
                <td><cfoutput>#Description[i]#</cfoutput></td>
              </tr>
            </cfloop>
            </tbody>
          </table>
        </div>
      </div>
</div>
</cfif>

<hr>

<!--- Need to set session variables if numNom is 1, if great than 1 use loop --->

<cfif session.numNom is 1>
	<cfset session.department = #department#>
    <cfset session.employee = #employee#>
    <cfset session.achievement = #achievement#>
    <cfset session.description = #Description#>
    <cfset session.nominator = #nominator#>
</cfif>

<cfif session.numNom GT 1>
	<cfset session.nominator = #nominator#>
    <cfset session.achievement = #achievement#>
    <cfloop index="i" from="1" to="#numNom#">
		<cfset session.department[i] = #department[i]#>
        <cfset session.employee[i] = #employee[i]#>
        <cfset session.description[i] = #Description[i]#>
	</cfloop>
</cfif>

<table align="center" border="0" cellpadding="0" cellspacing="4" width="425">
	<tr align="center">
		<td>
        	<div class="alert alert-warning" role="alert">
            


                <p class="text-left"><small>Press <b>Edit</b> if you would like to change the information.</small></p>
                <p class="text-left"><small>Press <b>Submit</b> if no changes are required.</small></p>
                <p class="text-left"><small>Press <b>Cancel</b> to return to the main page without submitting.</small></p>
            </div>
        </td>
	</tr>
</table>

<!--- pass nomination.getDept & nomination.getEm & achievement values to summary.cfm for confirmation --->
<cfif session.numNom is 1>
<cfform action="#URLSessionFormat("nomination-edit.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr align="center">
		<td>
            <!--- <cfinput type="button" value="    Edit   " onclick="history.go(-1);return true;"> --->
            <cfinput type="hidden" id="session.awardtype" name="session.awardtype" value="#session.awardtype#">
            <cfinput type="hidden" id="session.department" name="session.department" value="#session.department#">
            <cfinput type="hidden" id="session.employee" name="session.employee" value="#session.employee#">
            <cfinput type="hidden" id="session.achievement" name="session.achievement" value="#session.achievement#">
            <cfinput type="hidden" id="session.description" name="session.description" value="#session.description#">
            <cfinput type="hidden" id="session.nominator" name="session.nominator" value="#session.nominator#">
            <input type="submit" class="btn btn-lg btn-primary" value="  Edit  " >
		</td>
    </tr>
</table>
</cfform>
<cfform action="#URLSessionFormat("process.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
    <tr align="center">
         <td>
        	<cfinput type="hidden" id="session.awardtype" name="session.awardtype" value="#session.awardtype#">
            <cfinput type="hidden" id="session.department" name="session.department" value="#session.department#">
            <cfinput type="hidden" id="session.employee" name="session.employee" value="#session.employee#">
            <cfinput type="hidden" id="session.achievement" name="session.achievement" value="#session.achievement#">
            <cfinput type="hidden" id="session.description" name="session.description" value="#session.description#">
            <cfinput type="hidden" id="session.nominator" name="session.nominator" value="#session.nominator#">
            <input type="submit" class="btn btn-lg btn-primary" value="  Submit  " onClick="alert('Your nomination submission was successful.')">
        </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr align="center">
        <td>
        	<input type="button" class="btn btn-lg btn-primary" value="    Cancel   " onclick="window.location='logiin.cfm';">
        </td>
    </tr>
</table>
</cfform>
</cfif>

<cfif session.numNom GT 1>
<cfform action="#URLSessionFormat("process.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr align="center">
		<td>
            <!--- <cfinput type="button" value="    Edit   " onclick="history.go(-1);return true;"> --->
            <input type="button" class="btn btn-lg btn-primary" value="    Edit   " onclick="history.go(-1);">
		</td>
    </tr>
        <tr align="center">
        <td>
        	<cfinput type="hidden" id="session.awardtype" name="session.awardtype" value="#session.awardtype#">
            <cfinput type="hidden" id="session.department" name="session.department" value="#session.department#">
            <cfinput type="hidden" id="session.nominator" name="session.nominator" value="#session.nominator#">
        	<cfloop index="i" from="1" to="#numNom#">
                <cfinput type="hidden" id="session.employee[i]" name="session.employee[i]" value="#session.employee[i]#">
                <cfinput type="hidden" id="session.achievement[i]" name="session.achievement[i]" value="#session.achievement[i]#">
                <cfinput type="hidden" id="session.description[i]" name="session.description[i]" value="#session.description[i]#">
            </cfloop>
            <input type="submit" value="  Submit  ">
        </td>
	</tr>
    <tr align="center">
        <td>
        	<input type="button" value="    Cancel   " onclick="window.location='logiin.cfm';">
        </td>
    </tr>
</table>
</cfform>
</cfif>

<cfinclude template="footer.cfm">

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
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