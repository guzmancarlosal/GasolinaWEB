<cfparam name="url.mode" default="">

<cfif url.mode eq "getEstados">
	<cfquery name="qGetEstados" datasource="cc_gasolina">
	</cfquery>
<cfif url.mode eq "getMunicipios">
	<cfparam name="url.estadoID" default="0">
	<cfif url.estadoID neq "" and isnumeric(url.estadoID)>
		<cfquery name="qGetEstados" datasource="cc_gasolina">
			SELECT 
		</cfquery>
	</cfif>
</cfif>