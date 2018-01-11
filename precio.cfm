<cfparam name="url.estadoID" default="0">
<cfparam name="url.municipioID" default="0">
<!DOCTYPE html>
<script src="js\jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bootstrap-theme.min.css">

<cfif url.estadoID eq 0 and url.municipioID eq 0>
  <script src="js/bootstrap.min.js"></script>
  <script src="js\bootbox.min.js"></script>
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
              title: "Selecciona tu Estado",
              inputType: 'select',
              inputOptions: options,
              callback: function (edo) {
                $.ajax({
                  url:'api.cfm?mode=getMunicipios&estadoid='+edo
                }).done(function(data1){
                  var options1 =[];
                  data1.forEach (function(value, key) { 
                    options1.push({text:value[1],value:value[0]});
                  });
                  bootbox.prompt({
                    title: "Selecciona tu Municipio",
                    inputType: 'select',
                    inputOptions: options1,
                    callback: function (mun) {
                        app.addMyMun(mun, edo);
                      }
                  });
                });   
              }
            });
          });
  	});
  </script>
<cfelse>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css"/>
  <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
  <script src="js/lodash.js"></script>
  <cfquery name="qGetMunicipioName" datasource="cc_gasolina">
    select Nombre 
    from Municipio with (nolock)
    where estadoid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.estadoid#">
          and id= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.municipioID#">
  </cfquery>
  <style>
  </style>
  <body>
   
    <div class="main-panel">
      <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Combustibles</th>
                </tr>
            </thead> 
      </table>
    </div>
    <script>
     <cfoutput>var #toScript(url.estadoid, "jsEstadoID")#var #toScript(url.municipioid, "jsMunID")#</cfoutput>
    </script>
    <script src="js/precio.js">
    </script>    
    <cfinclude template="template.cfm">
  </body>
</cfif>

<cfabort>
<button id="btnEdo">Borrar Edo</button>
<button id="btnMun">Borrar Mun</button>
<button id="btnAll">Borrar Todo</button>
<button id="btnReload">reload</button>
<script>
  $( "#btnEdo" ).click(function() {
    app.clearPreferences('edo');
  });
  $( "#btnMun" ).click(function() {
    app.clearPreferences('mun');
  });
  $( "#btnAll" ).click(function() {
    app.clearPreferences('all');
  });
  $( "#btnReload" ).click(function() {
    app.clearPreferences('reload');
  });
</script>
