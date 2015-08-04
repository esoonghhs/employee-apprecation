<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Hats Off</title>
</head>

<body>
<cfinclude template="header.cfm">
<br>
<form action="validate.cfm" method="post">
<table align="center" border="0" cellpadding="2" cellspacing="0" width="250">
	<tr>
		<td align="center">
			Please login
		</td>
	</tr>
	<tr>
		<td>
			Username: <input type="text" name="uname">
		</td>
	</tr>
	<tr>
		<td>
			Password: &nbsp;<input type="password" name="pword">
		</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
		<td align="center"><input type="Submit" value="Enter"></td>
	</tr>
</table>
</form>
<cfinclude template="footer.cfm">
</body>
</html>
