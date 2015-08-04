<cfloop index="j" from="1" to="#count#">
	<cfset formlen = "#len(trim(evaluate('desc' & j)))#">
	<cfif formlen gt "190">
		<cfoutput>
		<script language="javascript">
		var agree=alert("The length of the Achievement description cannot be more than 190 characters including spaces. Please go back and edit.");
		if (agree)
		history.go(-1);
		else
		history.go(-1);
		</script>
		</cfoutput>
		<cfabort>		
	</cfif>	
</cfloop>

<cfloop index="i" from="1" to="#count#">
	<cfswitch expression="#evaluate('confirm' & i)#">
		<cfcase value="2">
			<cfset status = "Pending">
		</cfcase>
		<cfcase value="1">
			<cfset status = "Approved">
		</cfcase>
		<cfcase value="0">
			<cfset status = "Denied">
		</cfcase>
	</cfswitch>
	
	<cfif status is not "Pending">
		<cfquery datasource="#ds.hatsoff#">
			update awards
			set  nomination_status = '#status#',
				nomination_updatedate = getdate(),
				nominee_achievement_desc = '#trim(rereplace(evaluate('desc' & i), "'", "''", "all"))#'
			where nom_id = '#evaluate('nom' & i)#'
		</cfquery>
	</cfif>	
	
		<cfquery name="getNom" datasource="#ds.hatsoff#">
			select nominee_uid
			from awards
			where nom_id = '#evaluate('nom' & i)#'
		</cfquery>
		
		<cfquery datasource="#ds.hatsoff#">
			insert into audit
			(admin_uid, nom_id, action, action_date, nominee_uid)
			values
			('#session.emp_id#', '#evaluate('nom' & i)#', '#status# Nominee', #now()#, '#getNom.nominee_uid#')
		</cfquery>
</cfloop>

<cflocation url="review.cfm">
<cfabort>
