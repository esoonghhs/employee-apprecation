<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />

<!DOCTYPE html>
<html lang="en">
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
<!--- From awardtype determine which logo to use --->
<cfif session.awardtype is 1>
	<cfinclude template="header-hatsoff.cfm">
<cfelse> 
	<cfinclude template="header-safety.cfm">
</cfif><br />
<br>

    <div class="container">
    
    <table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr align="center">
		<td>
        	<div class="alert alert-warning" role="alert">
                <h4 class="text-center"><small><b>LOGIN HAS FAILED</b><br />Make sure your credentials are typed in correctly.<br />Please try again.</small></h4>
            </div>
        </td>
	</tr>
</table>
<cfif session.awardtype is 1>
      <div class="modal-dialog">
					<!--- Login Modal content --->
					<div class="modal-content">
                        <!--- Form to submit logon information --->
						<form action="validate.cfm" method="post"> <!--- Submit hatsoff login form information to validate.cfm --->
						<div class="form-signin">	
                            <b>HatsOff Logon</b>
                            <h2 class="form-signin-heading">Please log in</h2>
                            <input type="hidden" id="awardchoice" name="awardchoice" value="1"> <!--- pass awardchoice value, 1 is HatsOff, to validate.cfm , control logo appearance & award needed items on pages --->
                          	<label for="inputText" class="sr-only">HHS Network ID (same as PC login)</label>
                            <input type="text" id="uname" name="uname" class="form-control" placeholder="HHS Network ID (same as PC login)" required autofocus>
                            <label for="inputPassword" class="sr-only">HHS Network Password</label>
                            <input type="password" id="pword" name="pword" class="form-control" placeholder="HHS Network Password" required><br />
                            <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
                        </div> <!--- form-signin --->
                        </form>
                        <div class="modal-footer">
          					<p>Employee Appreciation | UCLA Housing and Hospitality Services
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
						</div>
					</div> <!--- modal-content --->
				</div> <!--- modal-dialog --->
    </div> <!--- /container --->

<cfelse> 
				<div class="modal-dialog">
					<!--- Login Modal content --->
					<div class="modal-content">
                        <!--- Form to submit logon information --->
						<form action="validate.cfm" method="post"> <!--- Submit safety login form information to validate.cfm --->
						<div class="form-signin">	
                            <b>Safety Logon</b>
                            <h2 class="form-signin-heading">Please log in</h2>
                             <input type="hidden" id="awardchoice" name="awardchoice" value="2"> <!--- pass awardchoice value, 2 is Safety, to validate.cfm , control logo appearance & award needed items on pages --->
                            <label for="inputText" class="sr-only">HHS Network ID (same as PC login)</label>
                            <input type="text" id="emailid" name="uname" class="form-control" placeholder="HHS Network ID (same as PC login)" required autofocus>
                            <label for="inputPassword" class="sr-only">HHS Network Password</label>
                            <input type="password" id="inputPassword" name="pword" class="form-control" placeholder="HHS Network Password" required><br />
                            <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
                        </div> <!--- form-signin --->
                        </form>
                        <div class="modal-footer">
          					<p>Employee Appreciation | UCLA Housing and Hospitality Services
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
						</div>
					</div> <!--- modal-content --->
				</div> <!--- modal-dialog --->
			</div> <!--- modal fade --->
            </div><!--- /.container --->
</cfif> --->

    
<cfinclude template="footer.cfm">


	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/vendor/holder.min.js"></script> 
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>