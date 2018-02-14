<cftry>
<cfparam name="url.estadoID" default="0">
<cfparam name="url.municipioID" default="0">
<!DOCTYPE html>
<script src="js\jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" ></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css"/>
<link rel="stylesheet" href="css/precio.css">
<script src="js\bootbox.min.js"></script>

<cfif url.estadoID eq 0 and url.municipioID eq 0>
  <script>
  	$( document ).ready(function() {
      	$.ajax({
         		url:'api.cfm?mode=getEstados'
         	}).done(function(data){
         		var options =[];
         		data.forEach (function(value, key) { 
  				    options.push({text:value[1],value:value[0]});

            });
            bootbox.prompt({
              closeButton: false,
              title: "Selecciona tu Estado",
              inputType: 'select',
              inputOptions: options,
              callback: function (edo) {
                $( "[data-bb-handler*='cancel']" ).hide();
                $.ajax({
                  url:'api.cfm?mode=getMunicipios&estadoid='+edo
                }).done(function(data1){
                  var options1 =[];
                  data1.forEach (function(value, key) { 
                    options1.push({text:value[1],value:value[0]});
                  });
                  $("select").val($("select option:first").val());
                  bootbox.prompt({
                    closeButton: false,
                    title: "Selecciona tu Municipio",
                    inputType: 'select',
                    inputOptions: options1,
                    callback: function (mun) {
                        app.addMyMun(mun, edo);
                        app.loadApp();
                      }
                  });
                  $("select").val($("select option:first").val());
                  $( "[data-bb-handler*='cancel']" ).hide();
                });   
              }
            });
            $("select").val($("select option:first").val());
            $( "[data-bb-handler*='cancel']" ).hide();
          });
         
  	});
  </script>
<cfelse>
 <cfprocessingdirective pageencoding = "utf-8">

  <script src="js/lodash.js"></script>
  <cfquery name="qGetMunicipioName" datasource="cc_gasolina">
    select Nombre 
    from Municipio with (nolock)
    where estadoid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.estadoid#">
          and id= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.municipioID#">
  </cfquery>
  <title>Precio Gasolina Mexico</title>
  
  <body>
    <cfoutput>
      <nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse" style="">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="##navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="##"><img class="logo" src="img/gassmall.png" width="30" height="30">&nbsp;&nbsp;&nbsp; Precio Gasolina México</a>
        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
          <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                  <a class="nav-link" href="##" id='linkFav'><i class="glyphicon glyphicon-star-empty" aria-hidden="true"></i> Lugares Favoritos</a>
              </li>
              <li class="nav-item active" style="display:none;">
                  <a class="nav-link" href="##" id='linkNonFav'><i class="glyphicon glyphicon-star-empty" aria-hidden="true"></i> Regresar a #qGetMunicipioName.nombre#</a>
              </li>
              <li class="nav-item active">
                  <a class="nav-link" href="##" onclick="ftnDeleteFav()" ><i class="glyphicon glyphicon-alert" aria-hidden="true"></i> Borrar todos los favoritos</a>
              </li>
               <li class="nav-item active">
                  <a class="nav-link" href="estadisticas.cfm?estadoID=#url.estadoID#&municipioID=#url.municipioID#" ><i class="glyphicon glyphicon-stats" aria-hidden="true"></i> Estadísticas de #qGetMunicipioName.nombre#</a>
              </li>
              <li class="nav-item active">
                  <a class="nav-link" href="##"  id='rChange'><i class="glyphicon glyphicon-transfer" aria-hidden="true"></i> Cambia de Región</a>
              </li>
             
              <li class="nav-item active">
                  <a class="nav-link" href="https://play.google.com/store/apps/details?id=com.ttpCorp.carlosguzman.gasolinamexico"  target="_blank"><i class="glyphicon glyphicon-heart-empty" aria-hidden="true"></i> Mándanos un mensaje</a>
              </li>
              <li class="nav-item active">
                  <a class="nav-link" href="https://play.google.com/store/apps/details?id=mtracker.carlosguzman.xikma.consumocombustible"  target="_blank"><i class="glyphicon glyphicon-road" aria-hidden="true"></i> Consumo de Combustible de Autos</a>
              </li>
          </ul>
        </div>
      </nav>
    </cfoutput>
    <!---<button id="btnEdo">Borrar Edo</button>
    <button id="btnMun">Borrar Mun</button>
    <button id="btnAll">Borrar Todo</button>
    <button id="btnReload">reload</button>
    <button id="btngetUserNmae">getUserNmae</button>--->
    <input type="hidden" id="favList" value="">
    <table id="example" class="table table-borderless table-condensed table-hover" cellspacing="0" width="100%">
            <tr>
                <th><h2><b id="tableheader"><cfoutput>#qGetMunicipioName.nombre#</cfoutput></b></h2></th>
                <!---<th>Combustibles<br>Reportados</th>--->
            </tr>
    </table>
    <script>
      <cfoutput>var #toScript(url.estadoID, "jsEstadoID")#var #toScript(url.municipioID, "jsMunID")# var #toScript(qGetMunicipioName.nombre, "siteName")#</cfoutput>
    </script>
    <script src="js/precio.js"></script>    
    <cfinclude template="template.cfm">
  </body>
</cfif>
<cfcatch><cfdump var="#cfcatch#"></cfcatch></cftry>