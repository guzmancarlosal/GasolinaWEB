
<cftry>
<cfparam name="url.mode" default="">

<cfif url.mode eq "getEstados">
	<cfquery name="qGetEstados" datasource="cc_gasolina">
		SELECT  id, nombre from estado
	</cfquery>
	<cfheader charset="utf-8" name="Content-Type" value="application/json">
	
	<cfset queryAsStruct = DeSerializeJSON(SerializeJSON(qGetEstados))>
	<cfset dataJSON = SerializeJSON(queryAsStruct.data)>
	<cfoutput>#dataJSON#</cfoutput>

<cfelseif url.mode eq "getMunicipios">
	<cfparam name="url.estadoID" default="0">
	<cfif url.estadoID neq "" and isnumeric(url.estadoID)>
		<cfquery name="qGetEstados" datasource="cc_gasolina">
			SELECT id, nombre from municipio where estadoid=#url.estadoid#
		</cfquery>
		<cfheader charset="utf-8" name="Content-Type" value="application/json">
		<cfset queryAsStruct = DeSerializeJSON(SerializeJSON(qGetEstados))>
		<cfset dataJSON = SerializeJSON(queryAsStruct.data)>
		<cfoutput>#dataJSON#</cfoutput>
	</cfif>
<cfelseif url.mode eq "getPrecio">
	<cfoutput>#SetLocale("Spanish (Modern)")#</cfoutput>
	<cfcontent reset="true">
	<cfparam name="url.estadoID" default="0">
	<cfparam name="url.municipioID" default="0">
	<cfparam name="form.favList" default="">
	<cfif url.estadoid neq 0 and url.municipioID neq 0>
		<cfquery name="qGetData" datasource="cc_gasolina"><!------>
			select   g.nombre, g.direccion,valor,p.fechaaplicacion, g.id,cast(lower(gs.subproducto) as varchar(max)) collate SQL_Latin1_General_Cp1251_CS_AS as subproducto 
			into ##temp
			from precio p with (nolock)
			Inner join gasolinera g with (nolock) ON g.id = p.idGasolinera
			Inner join gasolina gs with (nolock) ON gs.id = p.idgasolina
			where
				<cfif form.favList eq ""> 
					g.idestado = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.estadoid#">
					and g.idmunicipio= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.municipioID#">
				<cfelse>
					g.id IN ( <cfqueryparam 
		                value="#form.favList#" 
		                cfsqltype="CF_SQL_INTEGER"
		                list="yes" 
		                /> )
				</cfif>

			DECLARE @cols  AS NVARCHAR(MAX)='';
			DECLARE @query AS NVARCHAR(MAX)='';

			SELECT @cols = @cols + QUOTENAME(subproducto) + ',' FROM (select distinct subproducto from ##temp ) as tmp
			select @cols = substring(@cols, 0, len(@cols)) 

			set @query = 'SELECT * from (select * from ##temp) src pivot (  max(valor) for subproducto in (' + @cols + ')) piv order by nombre';

			execute(@query)
			drop table ##temp
	    </cfquery>

		<cfheader charset="utf-8" name="Content-Type" value="application/json">   
		<cfprocessingdirective pageencoding = "utf-8">
		<cfset myGasolinalist ="">
		<cfloop list="#qGetData.columnList#" index="col">
			<cfif col neq "DIRECCION" and col neq "NOMBRE" and col neq "FECHAAPLICACION" and col neq "ID">
				<cfset myGasolinalist= listAppend(myGasolinalist, col,",")>
			</cfif>
			
		</cfloop>
	  
	    {	
			
				<cfset counter = 1>
				<cfoutput query="qGetData">
					<cfif counter neq 1>,</cfif>

						"gasolinera#counter#": {
							"direccion":"#jsStringFormat(qGetData.direccion)#",
							"nombre":"#jsStringFormat(qGetData.nombre)#",
							"id":"#qGetData.id#",
							"fechaaplicacion":"#dateformat(qGetData.fechaaplicacion,"dd-mmm-yyyy")#",
							"precio": {
								"i":"1"
								<cfloop list="#myGasolinalist#" item="i">
									<cfif #qgetdata['#i#']['#counter#']# neq "">
									,"#jsStringFormat(LCase(i))#":"#qgetdata['#i#']['#counter#']#"
									</cfif>
								</cfloop>
							}

							
						}
						
					<cfset counter++>
				</cfoutput>
			

		}

		<cfabort>
		<cfset queryAsStruct = DeSerializeJSON(SerializeJSON(qGetData))>
		<cfset dataJSON = SerializeJSON(queryAsStruct.data)>
		<cfoutput>#dataJSON#</cfoutput>
	    <!---<cfoutput>#SerializeJSON(qGetData)#</cfoutput>--->
	</cfif>
</cfif>

<cfcatch><cfdump var="#cfcatch#"></cfcatch></cftry>