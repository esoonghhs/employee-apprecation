<CFAPPLICATION NAME="hatsoff" CLIENTMANAGEMENT="Yes" SESSIONMANAGEMENT="Yes" SESSIONTIMEOUT="20">

<cfset ds.hatsoff = "HatsOff">

<cfif (CF_TEMPLATE_PATH DOES NOT CONTAIN "admin\admin.cfm") 
	and (CF_TEMPLATE_PATH DOES NOT CONTAIN "admin\validate.cfm")
		and (CF_TEMPLATE_PATH DOES NOT CONTAIN "admin\login.cfm")>
	<cfif not isdefined('session.username') or not isdefined('session.emp_id')>
		<cflocation url="login.cfm">
		<cfabort>
	</cfif>
</cfif>