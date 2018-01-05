<cftry>

	<cfparam name="url.mode" default="">
	1- getEstados<br>
	2- getMunicipio<br>
	3- getGasolineras<br>
	4- getGasolinas<br>
	5- getPrecioDiario<br>
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
	<cfelseif url.mode eq "getMunicipio">
		<cfhttp
		    url="http://api-catalogo.cre.gob.mx/api/utiles/municipios?EntidadFederativaId="
		    method="get"
		    useragent="#CGI.http_user_agent#"
		    result="myxml">
		</cfhttp>
		<cfset cfData=DeserializeJSON(myxml.FileContent)> 
		<!---<cfdump var="#cfData#">
		<cfoutput>
			<cftransaction>
			<cfloop array="#cfdata#" index="i">
				<cfquery name="qInsertestado" datasource="cc_Gasolina">
					insert into municipio (id, nombre, estadoid) values('#i.municipioid#','#i.nombre#',#i.EntidadFederativaId#)
				</cfquery>
			</cfloop>
			</cftransaction>
		</cfoutput>--->
	<cfelseif url.mode eq "getGasolineras">
		<cfhttp
		    url="http://api-reportediario.cre.gob.mx/api/EstacionServicio/Petroliferos?entidadId=&municipioId=&_=1514402356616"
		    method="get"
		    useragent="#CGI.http_user_agent#"
		    result="myxml">
		</cfhttp>
		<cfset cfData=DeserializeJSON(myxml.FileContent)> 
		<cfset STCGASOLINERA ={}>
		<cfloop array="#cfdata#" index="i">
			<cfif not structKeyExists(stcgasolinera, i.nombre)>
				<cfset stcgasolinera[i.nombre]=i.nombre>
				<!---<cfquery name="qInsertestado" datasource="cc_Gasolina">
				insert into gasolinera (nombre, direccion, numero, idMunicipio, idestado)
				values('#i.nombre#','#i.direccion#','#i.numero#','#i.municipioid#','#i.entidadfederativaid#')
				</cfquery>--->
			</cfif>
		</cfloop>

		<cfdump var="#stcgasolinera#">
	<cfelseif url.mode eq "getGasolinas">
		<cfhttp
		    url="http://api-reportediario.cre.gob.mx/api/EstacionServicio/Petroliferos?entidadId=&municipioId=&_=1514402356616"
		    method="get"
		    useragent="#CGI.http_user_agent#"
		    result="myxml">
		</cfhttp>
		<cfset cfData=DeserializeJSON(myxml.FileContent)> 
		<cfset STCGASOLINERA ={}>
		<!---<cfloop array="#cfdata#" index="i">
			<cfif not structKeyExists(stcgasolinera, i.Marca)>
				<cfset stcgasolinera[i.Marca]=i.Marca>
				<cfquery name="qInsertestado" datasource="cc_Gasolina">
				insert into gasolina ( producto, marca, subproducto)
				values('#i.producto#','#i.marca#','#i.subproducto#')
				</cfquery>
			</cfif>
		</cfloop>--->

		<cfdump var="#stcgasolinera#">
	<cfelseif url.mode eq "getPrecioDiario">
		<cfsetting requesttimeout="240">
		<!---
		<cfhttp
		    url="http://api-reportediario.cre.gob.mx/api/EstacionServicio/Petroliferos?entidadId=&municipioId=&_=1514402356616"
		    method="get"
		    useragent="#CGI.http_user_agent#"
		    result="myxml">
		</cfhttp>
		<cfset cfData=DeserializeJSON(myxml.FileContent)> 

		<cfquery name="qGetAllGasolineras" datasource="cc_Gasolina">
			select id, numero
			from gasolinera with (nolock)
		</cfquery>
		<cfset stcGetAllGasolineras = {}>
		<cfloop query="qGetAllGasolineras">
			<cfset stcGetAllGasolineras[numero] = id>
		</cfloop>
		<cfquery name="qGetAllproducts" datasource="cc_Gasolina">
			select *
			from gasolina with (nolock)
		</cfquery>
		<cfset initialloop=0>
		<cfset queryScript = "" >
			<cfloop array="#cfdata#" index="i">
				<cftry>
					<cfquery name="qgetGasID" dbtype="query">
						select id from qGetAllproducts where subproducto='#i.subproducto#' and marca ='#i.marca#' and producto ='#i.producto#'
					</cfquery>
					<cfif structKeyExists(stcGetAllGasolineras, i.numero) and qgetGasID.recordcount>
						<cfif isdefined('i.fechaaplicacion')>
							<cfset fechaApp = #dateFormat(replace(i.fechaaplicacion,"T"," "),"dd-mmm-yyyy")#>
							<cfif not isDate(fechaApp)>
								<cfset fechaApp ="">
							</cfif>
						<cfelse>
								<cfset fechaApp ="">
						</cfif>

						<cfoutput>
							<cfif initialloop neq 0>
								<cfset queryScript = queryScript & " , ">
							</cfif>
							<cfset queryScript = queryScript & "('#i.preciovigente#','#qgetGasID.id#','#stcGetAllGasolineras[i.numero]#','#fechaApp#' )">
						</cfoutput>
						<cfset initialloop++>
						<cfif initialloop eq 500>
							<cfquery name="insertData" datasource="cc_gasolina">
								insert into precio (valor, idgasolina, idgasolinera,fechaaplicacion)
								values #PreserveSingleQuotes(queryScript)#
							</cfquery>
							<cfset initialloop=0>
							<cfset queryScript ="">
						</cfif>
					<cfelse>
					
					</cfif>
				<cfcatch><cfdump var="#cfcatch#"><cfdump var=#i#><cfabort></cfcatch>
				</cftry>
				
			</cfloop>
			<cfif queryScript neq "">
				<cfquery name="insertData" datasource="cc_gasolina">
					insert into precio (valor, idgasolina, idgasolinera,fechaaplicacion)
					values #PreserveSingleQuotes(queryScript)#
				</cfquery>
			</cfif>
		<cfsetting showdebugoutput="true">
--->

	</cfif>
<cfcatch><cfdump var="#cfcatch#"></cfcatch>
</cftry>