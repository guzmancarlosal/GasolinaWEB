<cfparam name="url.estadoID" default="0">
<cfparam name="url.municipioID" default="0">
<cfparam name="url.listMode" default="">
<!DOCTYPE html>
<script src="js\jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" ></script>

<cfif url.estadoID eq 0 and url.municipioID eq 0 and url.listMode eq "">
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
  <title>Precio Gasolina Mexico</title>
  <style>
    i { text-transform: capitalize; } 
    .bg-inverse {background-color: #668178 !important;}
    .navbar {margin-bottom:0px;}
    .navbar-inverse {background-color: #222;border-color: #668178;}
    .navbar-inverse .navbar-brand {color: #ffffff;}
    .logo { position:absolute;left:5px;top:20px;margin: 0px 15px 15px 0px;}
    .navbar-inverse .navbar-nav>.active>a, .navbar-inverse .navbar-nav>.active>a:focus, .navbar-inverse .navbar-nav>.active>a:hover{background-color: #668178 !important;}
  </style>
  <body>
    <cfoutput>
      <nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse" style="">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="##navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="##"><img class="logo" src="img/gassmall.png" width="30" height="30">&nbsp;&nbsp;&nbsp; #qGetMunicipioName.nombre#</a>
        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
          <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                  <a class="nav-link" href="precio.cfm?listMode=fav&estadoid=#url.estadoID#&municipioID=#url.municipioID#"><i class="glyphicon glyphicon-star-empty" aria-hidden="true"></i> Lugares Favoritos</a>
              </li>
              <li class="nav-item active">
                  <a class="nav-link" href="reports.cfm" ><i class="glyphicon glyphicon-transfer" aria-hidden="true"></i> Cambia de Región</a>
              </li>
              <li class="nav-item active">
                  <a class="nav-link" href="reports.cfm" ><i class="glyphicon glyphicon-plus" aria-hidden="true"></i> Opciones</a>
              </li>
              <li class="nav-item active">
                  <a class="nav-link" href="reports.cfm" ><i class="glyphicon glyphicon-road" aria-hidden="true"></i> Consumo de Combustible de Autos</a>
              </li>
          </ul>
        </div>
      </nav>
    </cfoutput>
    <button id="btnEdo">Borrar Edo</button>
<button id="btnMun">Borrar Mun</button>
<button id="btnAll">Borrar Todo</button>
<button id="btnReload">reload</button>
<button id="btngetUserNmae">getUserNmae</button>
      <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <thead>
              <tr>
                  <th>Gasolinera<br>&nbsp;</th>
                  <th>Combustibles<br>Reportados</th>
              </tr>
          </thead> 
      </table>
    <script>
     <cfoutput>var #toScript(url.estadoID, "jsEstadoID")#var #toScript(url.municipioID, "jsMunID")#</cfoutput>
     var listMode ="";
     <cfif url.listMode neq "">
        var listMode ="fav";
     </cfif>
    </script>
    <script src="js/precio.js">
    </script>    
    <cfinclude template="template.cfm">
  </body>
</cfif>



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
  $( "#btngetUserNmae" ).click(function() {
    app.getUsername();
  });
</script>
