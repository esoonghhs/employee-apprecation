<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<CFINCLUDE TEMPLATE="header.cfm">

<!-- Make sure employee and achievement values are carried over from achievement.cfm -->
<cfoutput>Employee is #session.employee#</cfoutput><br />
<cfoutput>Achievement is #achievement#</cfoutput><br />
<cfoutput>Time logged on is #session.logintime#</cfoutput><br />

<cfset yearnow = year(now())>
<cfoutput>Year is #yearnow#</cfoutput><br />

<cfset monthnow = month(now())>
<cfoutput>Month is #monthnow#</cfoutput><br />

<!-- Query awards table for nominee_uid and nominee_achievement and nomination_createdate -->
<cfquery name="GetNominfo" datasource="hatsoff">
	SELECT nominee_uid, nominee_achievement, nomination_createdate
	FROM awards
	WHERE nominee_uid = <CFQUERYPARAM VALUE='#session.employee#' CFSQLTYPE="CF_SQL_INTEGER">
	AND nominee_achievement = <CFQUERYPARAM VALUE='#achievement#' MAXLENGTH="1">
	AND year(nomination_createdate) = '#yearnow#'
    AND month(nomination_createdate) = '#monthnow#';
</cfquery>

<body>
<!-- Compare values from variable to query results for a match in nominee uid and achievement, then compare today's date to awards nomination_createdate, if within same month, then display error msg, offer choices, else go to nominator.cfm  -->
<cfoutput>The create date is #GetNominfo.nomination_createdate#</cfoutput><br />
<cfif len(GetNominfo.nomination_createdate) neq 0>
	<cflocation url = "http://localhost:8500/hatsoff/finish.cfm/>
<cfelse>
	<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="400">
    	<TR>
        <TD>
		<cfoutput><h3>#session.employee# has been nominated for this achievement already this month, please change achievement or nominate someone else or cancel.</h3></cfoutput>
        </TD>
        </TR>
    </TABLE>
    <TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="400">
    	<TR>
        <TD>&nbsp;</TD>
        </TR>
    </TABLE>
    <TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="400">
        <TR>
            <FORM ACTION="achievement.cfm" METHOD="post">
            <TD><INPUT TYPE="Submit" VALUE="Re-select Achievement"></TD>
            </FORM>
            <TD>&nbsp;&nbsp;&nbsp;</TD>
            <FORM ACTION="nominee.cfm" METHOD="post">
            <TD><INPUT TYPE="Submit" VALUE="Nominate Someone Else"></TD>
            </FORM>
            <TD>&nbsp;&nbsp;&nbsp;</TD>
            <FORM ACTION="logoff.cfm" METHOD="post">
            <TD><input type="button" value="    Cancel (logoff)   " onclick="window.location='logoff.cfm';"></TD>
            </FORM>
        </TR>
    </TABLE>
</body>

<CFINCLUDE TEMPLATE="footer.cfm">
</html>
<cfdump var="#GetNominfo#">