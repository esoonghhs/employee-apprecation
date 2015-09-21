<CFAPPLICATION NAME="hatsoff" CLIENTMANAGEMENT="Yes" SESSIONMANAGEMENT="Yes" SESSIONTIMEOUT="20">
<!---<cfif cgi.REMOTE_ADDR IS NOT "149.142.52.253" >
Thank you for supporting the H&HS Hats Off program. As part of the holiday black-out we will not be accepting Hats Off nominations at this time. If you have any nominations, you may submit them starting January 1, 2014.
<cfabort>
</cfif>--->

<cfif (CF_TEMPLATE_PATH DOES NOT CONTAIN "hatsoff\login.cfm") and (CF_TEMPLATE_PATH DOES NOT CONTAIN "hatsoff\validate.cfm")>
	<cfif not isdefined('session.username')>
		<cflocation url="login.cfm">
	</cfif>
</cfif>
