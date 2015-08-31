<!---
Variables must be passed from nomination.cfm
Department - #session.department#<
Nominee - #session.employee#
Achievement - #session.achievement#<
Description - #session.description#
Nominator - #nominator#
Supervisor - #supervisor#
--->

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines --->
<cfoutput>The award type is "#session.awardtype#"</cfoutput><br />
<cfoutput>The session.dept is "#session.dept#"</cfoutput>

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
<!--- From awardtype determine which logo to use --->
<cfif session.awardtype is 1>
	<cfinclude template="header-hatsoff.cfm">
<cfelse> 
	<cfinclude template="header-safety.cfm">
</cfif>

<div class="page-header">
        <h1>Summary of your nomination</h1>
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
                <td><cfoutput>#department#</cfoutput></td>
                <td><cfoutput>#employee#</cfoutput></td>
                <td><cfoutput>#achievement#</cfoutput></td>
                <td><cfoutput>#Description#</cfoutput></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

<cfset session.department = #department#>
<cfset session.employee = #employee#>
<cfset session.achievement = #achievement#>
<cfset session.description = #Description#>
<cfset session.nominator = #nominator#>
<cfset session.supervisor = #supervisor#>

<!--- pass nomination.getDept & nomination.getEm & achievement values to summary.cfm for confirmation --->
<cfform action="#URLSessionFormat("process.cfm")#" method="POST" name="frmScan">
<hr class="featurette-divider">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr align="center">
		<td>
        	<input type="button" value="    Cancel   " onclick="window.location='logoff.cfm';">
        </td>
        <td>
        	<input type="hidden" id="session.department" name="session.department" value="#session.department#">
            <input type="hidden" id="session.employee" name="session.employee" value="#session.employee#">
            <input type="hidden" id="session.achievement" name="session.achievement" value="#session.achievement#">
            <input type="hidden" id="session.description" name="session.description" value="#session.description#">
            <input type="hidden" id="session.nominator" name="session.nominator" value="#session.nominator#">
            <input type="hidden" id="session.supervisor" name="session.supervisor" value="#session.supervisor#">
            <input type="submit" onmouseover="hover();" value="  Submit  ">
        </td>
        <td>
            <input type="button" value="    Edit   " onclick="window.location='nomination.cfm?dept=#dept#';">
		</td>
	</tr>
</table>
</cfform>

<hr class="featurette-divider">

<cfinclude template="footer.cfm">

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript">
    function hover() {
       if (confirm('Please make sure all information is correct before clicking the submit button!')) {
           formelement.submit();
       } else {
           return false;
       }
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