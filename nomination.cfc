<cfcomponent output="false">


    <!--- Get array of media types --->
    <cffunction name="getDept" access="remote" returnType="array">
		
        <!--- Define variables --->
        <cfset var data="">
        <cfset var result=ArrayNew(2)>
        <cfset var i=0>		

        <!--- Get data --->
        <cfquery name="data" datasource="HatsOff">
        SELECT account_number, account_title
        FROM departments
		<cfif session.vdept is not "All" and session.vdept is not "Letter">
		WHERE [departmentname] = '#session.vdept#'  
		</cfif>
        ORDER BY account_title
        </cfquery>

        <!--- Convert results to array --->
        <cfloop index="i" from="1" to="#data.RecordCount#">
            <cfset result[i][1]=data.account_number[i]>
            <cfset result[i][2]=data.account_title[i]>
        </cfloop>

        <!--- And return it --->
        <cfreturn result>
    </cffunction>

    <!--- Get art by media type --->
    <cffunction name="getEmp" access="remote" returnType="array">
        <cfargument name="department" type="string" required="true">

        <!--- Define variables --->
        <cfset var data="">
        <cfset var result=ArrayNew(2)>
        <cfset var i=0>

        <!--- Get data --->
        <cfquery name="data" datasource="HatsOff">
        SELECT emp_id, emp_full_name
        FROM employees
        WHERE account_number = '#ARGUMENTS.department#'
        ORDER BY emp_full_name
        </cfquery>
    
        <!--- Convert results to array --->
        <cfloop index="i" from="1" to="#data.RecordCount#">
            <cfset result[i][1]=data.emp_id[i]>
            <cfset result[i][2]=data.emp_full_name[i]>
        </cfloop>

        <!--- And return it --->
        <cfreturn result>
    </cffunction>

</cfcomponent>


