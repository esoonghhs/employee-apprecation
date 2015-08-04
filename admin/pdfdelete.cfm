<cfdirectory action="LIST" directory="e:\Inetpub\Secure\HatsOff\hats" name="theList">

<cfquery name="thePDFs" dbtype="query">
	Select name, datelastmodified
	From theList
</cfquery>

<cfset lastMonth = Now() - 30>

<cfoutput query="thePDFs">
	<cfif datelastmodified lt lastmonth>
		<cffile action="DELETE" file="e:\Inetpub\Secure\HatsOff\hats\#thePDFs.name#f"> 
	</cfif>
</cfoutput>


