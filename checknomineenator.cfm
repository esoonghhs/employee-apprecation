<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<CFINCLUDE TEMPLATE="header-award.cfm">

<body>
<!-- Check duplicate UIDs for same nominator/nominee -->
<cfset nominee_uid = '#session.emp_id#'>
<cfset nominator_uid = "#emp_full_name#">

<cfif nominee_uid eq #nominator_uid#>
	<cfoutput>'Alert: Nominee and Nominator can not be same person!'</cfoutput>
    <!-- Allow user to re-select nominator -->
    <cfquery name="getEmps" datasource="HatsOff">
        Select emp_id, emp_full_name
        From employees inner join departments on employees.account_number = departments.account_number
			<cfif session.vdept is not "All" and session.vdept is not "Letter">
            	Where departments.[department name] = '#session.vdept#'
        	</cfif>
        Order by emp_full_name
	</cfquery>
    <form action="process.cfm" method="post" name="frmScan">
	<table align="center" border="0" cellpadding="0" cellspacing="4" width="400">
        <tr>
            <td>
            5. Enter the Nominator's name:
            </td>
        </tr>
        <tr>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <select name="nominator">
                    <option value=""></option>
                    <cfoutput query="getEmps">
                        <option value="#emp_id#">#emp_full_name#</option>
                    </cfoutput>
                </select>
            </td>
        </tr>
        <tr>
        <td>
        <input type="hidden" name="supervisor" value="#emp_id.emp_full_name#">
        <!-- need to use session to bring emp_id.emp_full_name for supervisor over from nominator.cfm and cfset a new variable equal to it -->
       	</td>
        </tr>
        <input type="submit" value="  Submit  ">
    </table>
    </form>
    
<cfelse>
	<!-- use form below for submission -->
    <TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="400">
        <TR>
            <FORM ACTION="process.cfm" METHOD="post">
            <input type="hidden" name="nominee" value="#nominee name#">
            <input type="hidden" name="achievement" value="#achievement#">
            <input type="hidden" name="achievementdesc" value="#achievement_desc#">
            <input type="hidden" name="nominator" value="#nominator name#">
            <input type="hidden" name="supervisor" value="#supervisor name#">
            <TD><input type="submit" value="  Submit  "></TD>
            </FORM>
        </TR>
    </TABLE>
</body>

<CFINCLUDE TEMPLATE="footer.cfm">
</html>
<cfdump var="#GetEmps#">