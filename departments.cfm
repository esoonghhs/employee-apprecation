<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Logged In', #Now()#, '')
</cfquery>
<html>
<head>
	<title>Hats Off</title>
</head>

<body>
<cfinclude template="header.cfm">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td align="center">
			To begin making a Hats Off Nomination, select your department from the list below.
		</td>
	</tr>
</table>
<br><br>

<table align="center" border="0" cellpadding="0" cellspacing="2" width="600">
	<tr>
		<td>
			<table align="center">
				<tr>
					<td><a href="nominee.cfm?dept=Conferences">Conferences, Catering & Marketing</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Dining">Dining Services</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=HHSAdmin">Housing Admin & HBO</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=HHSIT">Housing IT</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Housing">Housing Services</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Letter">Letter</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table align="center">
				<tr>
					<td><a href="nominee.cfm?dept=CampusService">Housing HR/Payroll</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Lake">LACC & BRUINWOODS</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=HousingProjects">Housing Projects</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=Rooms">Rooms Division</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=UA">University Apartments</a></td>
				</tr>
                                  <tr>
					<td><a href="nominee.cfm?dept=LUSKIN CONFERENCE CENTER">Luskin Conference Center</a></td>
				</tr>
				<tr>
					<td><a href="nominee.cfm?dept=All">Out of Department</a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>



<cfinclude template="footer.cfm">

</body>
</html>
