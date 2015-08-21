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
<cfinclude template="header-award.cfm">
<br>
<div class="container">
<!--- Two columns of thumbnails --->
    <div class="container marketing">
      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-6">
			<!-- HatsOff award logo -->
			<img src="http://placehold.it/140x140&text=HATSOFF LOGO" class="img-circle" alt="HatsOff Logo" width="140" height="140" title="HatsOff Logo">
            <h2><button type="button" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#hatsoffModal">Nominate</h2><br />
			<h4>Qualifications</h4>
			<p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. 
            <a http="#" data-toggle="modal" data-target="#hatsoffDetailsModal">View details &raquo;</a></p>
        </div><!-- /.col-lg-6 -->
        <div class="col-lg-6">
        	<!-- Safety award logo -->
            <img src="http://placehold.it/140x140&text=SAFETY LOGO" class="img-circle" alt="Safety Logo" width="140" height="140" title="Safety Logo">
          	<!-- Trigger the login modal with a button -->
			<h2><button type="button" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#safetyModal">Nominate</h2><br />
            <h4>Qualifications</h4>
			<p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur. 
            <a http="#" data-toggle="modal" data-target="#safetyDetailsModal">View details &raquo;</a></p>
        </div><!-- /.col-lg-6 -->
      </div><!-- /.row -->
      
      <!--- Login Modal --->
			<div class="modal fade" id="hatsoffModal" role="dialog">
				<div class="modal-dialog">
					<!--- Login Modal content --->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button><br />
						</div> <!--- modal-header --->
                        <!--- Form to submit logon information --->
						<form action="validate.cfm" method="post"> <!--- Submit hatsoff login form information to validate.cfm --->
						<div class="form-signin">	
                            <b>HatsOff Logon</b>
                            <h2 class="form-signin-heading">Please log in</h2>
                            <input type="hidden" id="awardchoice" name="awardchoice" value="1"> <!--- pass awardchoice value, 1 is HatsOff, to validate.cfm , control logo appearance & award needed items on pages --->
                          	<label for="inputText" class="sr-only">Email ID</label>
                            <input type="text" id="uname" name="uname" class="form-control" placeholder="Email ID" required autofocus>
                            <label for="inputPassword" class="sr-only">Email Password</label>
                            <input type="password" id="pword" name="pword" class="form-control" placeholder="Email Password" required><br />
                            <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
                        </div> <!--- form-signin --->
                        </form>
                        <div class="modal-footer">
          					<p>Employee Appreciation | UCLA Housing and Hospitality Services &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
						</div>
					</div> <!--- modal-content --->
				</div> <!--- modal-dialog --->
			</div> <!--- modal fade --->
            
			<!--- Login Modal --->
			<div class="modal fade" id="safetyModal" role="dialog">
				<div class="modal-dialog">
					<!--- Login Modal content --->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button><br />
						</div> <!--- modal-header --->
                        <!--- Form to submit logon information --->
						<form action="validate.cfm" method="post"> <!--- Submit safety login form information to validate.cfm --->
						<div class="form-signin">	
                            <b>Safety Logon</b>
                            <h2 class="form-signin-heading">Please log in</h2>
                            <input type="hidden" id="awardchoice" name="awardchoice" value="2"> <!--- pass awardchoice value, 2 is Safety, to validate.cfm , control logo appearance & award needed items on pages --->
                            <label for="inputText" class="sr-only">Email ID</label>
                            <input type="text" id="emailid" name="uname" class="form-control" placeholder="Email ID" required autofocus>
                            <label for="inputPassword" class="sr-only">Email Password</label>
                            <input type="password" id="inputPassword" name="pword" class="form-control" placeholder="Email Password" required><br />
                            <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
                        </div> <!--- form-signin --->
                        </form>
                        <div class="modal-footer">
          					<p>Employee Appreciation | UCLA Housing and Hospitality Services &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
						</div>
					</div> <!--- modal-content --->
				</div> <!--- modal-dialog --->
			</div> <!--- modal fade --->
            
            <!--- HatsOff Qualification Details Modal --->
              <div class="modal fade" id="hatsoffDetailsModal" role="dialog">
                <div class="modal-dialog">
                
                  <!--- Modal content --->
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Qualifications for HatsOff Nomination</h4>
                    </div> <!--- modal-header --->
                    <div class="modal-body">
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. </p>

<p>Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. </p>

<p>Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit. Sed lectus. </p>
                    </div> <!--- modal-body --->
                  </div> <!--- modal-content --->
                  
                </div> <!--- modal-dialog --->
              </div> <!--- modal fade --->
              
              <!--- Safety Qualification Details Modal --->
              <div class="modal fade" id="safetyDetailsModal" role="dialog">
                <div class="modal-dialog">
                
                  <!--- Modal content --->
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Qualifications for Safety Nomination</h4>
                    </div> <!--- modal-header --->
                    <div class="modal-body">
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. </p>

<p>Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. </p>
                    </div> <!--- modal-body --->
                  </div> <!--- modal-content --->
                  
                </div> <!--- modal-dialog --->
              </div> <!--- modal fade --->
      
      <!--- FOOTER --->

</div><!--- /.container --->
    </div><!--- /.container --->
    
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