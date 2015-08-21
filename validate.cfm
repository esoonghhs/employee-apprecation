

<CFIF uname IS "">
	<CFLOCATION URL="login.cfm">
</CFIF>
<CFIF pword IS "">
	<CFLOCATION URL="login.cfm">
</CFIF>


<CFIF IsDefined("form.Uname") and IsDefined("form.Pword")>
	
	  <cftry>
 
	   <cfldap action="QUERY"
	   name="AuthenticateUser"
	   attributes="givenname,samaccountname,dn,cn,mail"
	   start="dc=hhs,dc=local"
	   maxrows="1"
	   scope="subtree"
	   filter="(&(objectclass=user)(samaccountname=#form.uname#))"
	   server="134hhsdc1.hhs.local"
	   username="#form.uname#@hhs.local"
	   password="#form.pword#">
	 
	   <cfset LoginMessage = "User Authentication Passed">
	   <cfcatch type="any">
	   <cfset LoginMessage = "User Authentication Failed">
	   </cfcatch>
	  </cftry>
	  
	<cfif IsDefined('AuthenticateUser.recordcount')>
		<cfif AuthenticateUser.recordcount GT "0">
		  	<cfset vauth = "1">
		<cfelse>
			<cfset vauth = "0">
		</cfif>
	<cfelse>
		<cfset vauth = "0">
	</cfif>

	<cfif vauth is "1">
		<cfif form.uname IS "tmullen">
			<cfset session.username="jsinger">
		<cfelse>
			<cfset session.username="#form.uname#">
		</cfif>

		<cfquery name="getID" datasource="Hatsoff">
			Select emp_id
			From administration
			Where username = '#session.username#'
		</cfquery>

		<cfset session.emp_id = '#getID.emp_id#'>
		
		<cfif session.emp_id is "">
			<cfset session.emp_id = "#session.username#">
		</cfif>
        
        <cfif awardchoice is "1">
        	<cfset session.awardtype = "1">
        <cfelse>
        	<cfset session.awardtype = "2">
        </cfif>
        		
		<cflocation url="departments.cfm" addtoken="No">
		<cfabort>
	<cfelse>
		<cflocation url="login.cfm" addtoken="No">
		<cfabort>
	</cfif>

<CFELSE>
	<CFLOCATION URL="login.cfm" addtoken="No">
	<CFABORT>
</CFIF>


<CFABORT>


