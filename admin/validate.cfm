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
	   attributes="givenname,samaccountname,dn,cn,mail,memberOf"
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
				<cfset session.username="vspivey">
			<cfelse>
				<cfset session.username="#form.uname#">
			</cfif>

		
			<cfset session.admin = "0">
			<cfset session.superuser = "0">
			
			<cfquery name="getAdmin" datasource="#ds.hatsoff#">
				Select admin, superuser, emp_id
				From administration
				Where username = '#session.username#'
					and emp_active = 1
			</cfquery>
			
			<cfset session.emp_id = "#getAdmin.emp_id#">

		
			<cfif getAdmin.admin is "1">
				<cfset session.admin = "1">
			</cfif>
		
			<cfif getAdmin.superuser is "1">
				<cfset session.superuser = "1">
			</cfif>
			
			<!---<cfdump var="#AuthenticateUser#" />
			<cfabort>--->
			
			<cflocation url="admin.cfm">
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