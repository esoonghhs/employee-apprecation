<!---
Variables passed from validate.cfm
session.emp_id (nominator)
session.awardtype
--->

<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Logged In', #Now()#, '')
</cfquery>

<cfset numNom = '1'>
<cfset awardTypeController = "0">
<cfif StructKeyExists(form, "awardtype")>
	<<cfset awardTypeController = "1">
</cfif>

<!DOCTYPE html>
<html lang="en">

<!--- troubleshoot lines
<cfset empid = #session.emp_id#>
<cfset logintime = #Now()#>  --->
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<cfoutput></cfoutput><br />
<!--- <cfoutput>Logged in person session.empUID is #session.empUID#</cfoutput><br />
<cfoutput>Time logged on is #logintime#</cfoutput><br />
<cfoutput>The award type is #session.awardtype#</cfoutput><br />
<cfoutput>The session_emp_id is #session.emp_id#</cfoutput> --->

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
<cfif awardTypeController eq 0>
	<cfif session.awardtype is 1>
        <cfinclude template="header-hatsoff.cfm">
    <cfelse> 
        <cfinclude template="header-safety.cfm">
    </cfif><br />
</cfif>

<cfif awardTypeController eq 1>
	<cfif awardtype is 1>
        <cfinclude template="header-hatsoff.cfm">
    <cfelse> 
        <cfinclude template="header-safety.cfm">
    </cfif><br />
</cfif>

<!--- From awardtype determine which statement to use following the logo --->
<cfif awardTypeController eq 0>
<cfif session.awardtype is 1>
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Hats Off Nomination, <br />select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
<cfelse> 
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Safety Nomination, <br />select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
</cfif>
</cfif>

<cfif awardTypeController eq 1>
<cfif awardtype is 1>
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Hats Off Nomination, <br />select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
<cfelse> 
	<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Safety Nomination, <br />select your department from the list below.
		</td>
	</tr>
</table>
<br><br>
</cfif>
</cfif>

<!--- Match empid to emp_id in Table employees, then acct number to Table departments --->
<CFQUERY NAME="getNominatorDept" DATASOURCE="hatsoff">
	SELECT e.emp_id, e.emp_full_name, e.emp_first, e.emp_last, d.DepartmentName
	FROM employees AS e
	INNER JOIN departments AS d
	ON e.account_number=d.account_number
	WHERE e.emp_id = <cfqueryparam value="#session.empUID#">
</CFQUERY>

<!--- Convert SQL SELECT results to array --->
        <cfloop index="i" from="1" to="#getNominatorDept.RecordCount#">
            <cfset result[i]=getNominatorDept.DepartmentName[i]>
        </cfloop>

<cfset session.Empfullname = #getNominatorDept.emp_full_name#>

<!--- Single Nomination --->
<div class="container">
    <div class="container marketing">
        <div class="row">
            <div class="col-lg-4">
            </div>
            <div class="col-lg-4">
            <h1><span class="label label-primary">Single Nomination</span></h1><br />
    <cfform action="#URLSessionFormat("nomination.cfm")#" method="POST">
    <table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
        <cfloop index="i" from="1" to="#getNominatorDept.RecordCount#">
        <tr>
            <td>
                <cfif result[i] is "Conferences">
                    <cfinput type="radio" name="dept" value="Conferences" checked="yes">  Conferences, Catering & Marketing
                <cfelseif result[i] is "Dining">
                    <cfinput type="radio" name="dept" value="Dining" checked="yes">  Dining Services
                <cfelseif result[i] is "HHSAdmin">
                    <cfinput type="radio" name="dept" value="HHSAdmin" checked="yes">  Housing Admin & HBO
                <cfelseif result[i] is "HHS IT">
                    <cfinput type="radio" name="dept" value="HHSIT" checked="yes">  Housing IT
                <cfelseif result[i] is "Housing">
                    <cfinput type="radio" name="dept" value="Housing" checked="yes">  Housing Services
                <cfelseif result[i] is "Letter">
                    <cfinput type="radio" name="dept" value="Letter" checked="yes">  Letter
                <cfelseif result[i] is "CampusService">
                    <cfinput type="radio" name="dept" value="CampusService" checked="yes">  Housing HR/Payroll
                <cfelseif result[i] is "Lake">
                    <cfinput type="radio" name="dept" value="Lake" checked="yes">  LACC & BRUINWOODS
                <cfelseif result[i] is "HousingProjects">
                    <cfinput type="radio" name="dept" value="HousingProjects">  Dining Services
                <cfelseif result[i] is "Rooms">
                    <cfinput type="radio" name="dept" value="Rooms" checked="yes">  Rooms Division
                <cfelseif result[i] is "UA">
                    <cfinput type="radio" name="dept" value="UA" checked="yes">  University Apartments
                <cfelseif result[i] is "LUSKIN_CONFERENCE_CENTER">
                    <cfinput type="radio" name="dept" value="LUSKIN_CONFERENCE_CENTER" checked="yes">  Luskin Conference Center
                <cfelseif result[i] is "Dining">
                    <cfinput type="radio" name="dept" value="Dining" checked="yes">  Dining Services
                </cfif>
            </td>
        </tr>
        
        </cfloop>
        <tr>
            <td><cfinput type="radio" name="dept" value="All">  Out of Department</td>
        </tr>
        <tr>
            <td>
                <cfinput type="Hidden" name="numNom" value="1">
                <cfinput type="Hidden" name="awardtypeController" value="#awardtypeController#">
                <cfif StructKeyExists(form, "awardtype")>
                	<cfinput type="Hidden" name="awardtype" value="#awardtype#">
                </cfif>
            </td>
        </tr>
        <tr>
        <td>&nbsp;&nbsp;&nbsp;</td> 
        <tr>
            <td>
                <input type="Submit" class="btn btn-lg btn-primary" value="Next">
            </td>
        </tr>
    </table>
    </cfform>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
    </div>
</div>

<br />
<hr>

<!--- Bulk Nomination --->
<div class="container">
<div class="container marketing">
      <div class="row">
      <div class="col-lg-4">
      </div>
        <div class="col-lg-4">
<h1><span class="label label-primary">Multiple Nomination</span></h1><br />
<cfform action="#URLSessionFormat("nomination.cfm")#" method="POST">
<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
	<tr>
    	<td>
            Number of nominations   <select name="numNom" id="numNom" value="">
                  <option selected>2</option>
                  <option>3</option>
                  <option>4</option>
                  <option>5</option>
                  <option>6</option>
                  <option>7</option>
                  <option>8</option>
                  <option>9</option>
                  <option>10</option>
            </select>
       	</td>
    </tr>
	<cfloop index="i" from="1" to="#getNominatorDept.RecordCount#">
    <tr>
    	<td>
			<cfif result[i] is "Conferences">
                <cfinput type="radio" name="dept" value="Conferences" checked="yes">  Conferences, Catering & Marketing
            <cfelseif result[i] is "Dining">
                <cfinput type="radio" name="dept" value="Dining" checked="yes">  Dining Services
            <cfelseif result[i] is "HHSAdmin">
                <cfinput type="radio" name="dept" value="HHSAdmin" checked="yes">  Housing Admin & HBO
            <cfelseif result[i] is "HHS IT">
                <cfinput type="radio" name="dept" value="HHSIT" checked="yes">  Housing IT
            <cfelseif result[i] is "Housing">
                <cfinput type="radio" name="dept" value="Housing" checked="yes">  Housing Services
            <cfelseif result[i] is "Letter">
                <cfinput type="radio" name="dept" value="Letter" checked="yes">  Letter
            <cfelseif result[i] is "CampusService">
                <cfinput type="radio" name="dept" value="CampusService" checked="yes">  Housing HR/Payroll
            <cfelseif result[i] is "Lake">
                <cfinput type="radio" name="dept" value="Lake" checked="yes">  LACC & BRUINWOODS
            <cfelseif result[i] is "HousingProjects">
                <cfinput type="radio" name="dept" value="HousingProjects" checked="yes">  Dining Services
            <cfelseif result[i] is "Rooms">
                <cfinput type="radio" name="dept" value="Rooms" checked="yes">  Rooms Division
            <cfelseif result[i] is "UA">
                <cfinput type="radio" name="dept" value="UA" checked="yes">  University Apartments
            <cfelseif result[i] is "LUSKIN_CONFERENCE_CENTER">
                <cfinput type="radio" name="dept" value="LUSKIN_CONFERENCE_CENTER" checked="yes">  Luskin Conference Center
            <cfelseif result[i] is "Dining">
                <cfinput type="radio" name="dept" value="Dining" checked="yes">  Dining Services
            </cfif>
        </td>
    </tr>
    </cfloop>
    <tr>
        <td><cfinput type="radio" name="dept" value="All">  Out of Department</td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;</td>
    </tr>
    <tr>
            <td>
                <cfinput type="Hidden" name="awardtypeController" value="#awardtypeController#">
                <cfif StructKeyExists(form, "awardtype")>
                	<cfinput type="Hidden" name="awardtype" value="#awardtype#">
                </cfif>
            </td>
        </tr>
    <tr>
    	<td>
            <input type="Submit" class="btn btn-lg btn-primary" value="Next">
        </td>
    </tr>
</table>
</cfform>
</div>
</div>
</div>
<div class="col-lg-4">
</div>
</div>

<cfinclude template="footer.cfm">

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/vendor/holder.min.js"></script> 
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
<!---  
<cfdump var="#session.emp_id#"><br />
<cfdump var="#session.empUID#"><br />
<cfdump var="#logintime#"><br />
<cfdump var="#getNominatorDept.emp_id#"><br />
<cfdump var="#getNominatorDept.DepartmentName#"><br />
<cfdump var="#getNominatorDept.RecordCount#"><br />
<cfdump var="#result#"> --->
</body>
</html>

<!---
Variables passed to nomination.cfm
SINGLE NOMINATION
dept
numNom
awardtypeController
awardtype*
BULK NOMINATION
dept
numNom
awardtypeController
awardtype*
--->