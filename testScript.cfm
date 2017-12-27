<cftry>

<cfparam name="url.mode" default="">
	1- getEstados<br>
	2- getMunicipio<br>
	3- getPrecioDiario<br>
<cfif url.mode eq "">

<cfelseif url.mode eq "readEstados">
	<cfhttp
	    url="http://api-catalogo.cre.gob.mx/api/utiles/entidadesfederativas"
	    method="get"
	    useragent="#CGI.http_user_agent#"
	    result="myxml">

	    <!---
	        When posting the xml data, remember to trim
	        the value so that it is valid XML.
	    --->
	</cfhttp>
	<cfset cfData=DeserializeJSON(myxml.FileContent)> 
	<!---<cfdump var="#cfData#">
	<cfoutput>
		<cftransaction>
		<cfloop array="#cfdata#" index="i">
			<cfquery name="qInsertestado" datasource="cc_Gasolina">
				insert into Estado values('#i.nombre#',1)
			</cfquery>
		</cfloop>
		</cftransaction>
	</cfoutput>--->
</cfif>
<cfcatch><cfdump var="#cfcatch#"></cfcatch>
</cftry>