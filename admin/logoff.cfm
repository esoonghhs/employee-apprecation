<cfquery datasource="HatsOff">
	Insert into audit
	(admin_uid, nom_id, action, action_date, nominee_uid)
	values
	('#session.emp_id#', 0, 'Logged Off Admin', #Now()#, '')
</cfquery>
<cfset delete_session=structClear(session)>
<cflocation url="login.cfm">
<cfabort>