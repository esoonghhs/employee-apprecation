<!--- <cfif nominator is "">
	<cfoutput>
	<script language="javascript">
	var agree=alert("You must pick a Nominator. Please go back and make a selection.");
	if (agree)
	history.go(-1);
	else
	history.go(-1);
	</script>
	</cfoutput>
	<cfabort>
</cfif>

<cfif supervisor is "">
	<cfoutput>
	<script language="javascript">
	var agree=alert("You must pick a Supervisor. Please go back and make a selection.");
	if (agree)
	history.go(-1);
	else
	history.go(-1);
	</script>
	</cfoutput>
	<cfabort>
</cfif> --->

<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Choose Nominator', #Now()#, '#session.employee#')
</cfquery>
<cfoutput>
	Department - #session.department#<br>
	Nominee - #session.employee#<br>
	Achievement - #session.achievement#<br>
	Description - #session.description#<br>
	Nominator - #session.nominator#<br>
	Supervisor - #session.supervisor#
</cfoutput>

<cfquery datasource="HatsOff">
	Insert into awards
	(nominee_location, nominee_uid, nominee_achievement, nominee_achievement_desc, nominator_uid, supervisor_uid, nomination_status, nomination_createdate, letter, ood)
	values
	('#session.department#', '#session.employee#', #session.achievement#, '#rereplace(session.description, "'","'","All")#', '#session.nominator#', '#session.supervisor#', 'Pending', #now()#, #session.letter#, #session.ood#)
</cfquery>

<cfquery name="getID" datasource="HatsOff">
	Select top 1 nom_id
	From awards
	Order by nom_id desc
</cfquery>

<cfquery name="getUID" datasource="HatsOff">
	Select emp_id
	From administration
	Where username = '#session.username#'
</cfquery>

<cfset userid = "#getUID.emp_id#">

<cfif userid is "">
	<cfset userid = "#session.emp_id#">
</cfif>

<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#userid#', #getID.nom_id#, 'Nomination', #now()#, '#session.employee#')
</cfquery>

<cflocation url="complete.cfm">
<cfabort>
