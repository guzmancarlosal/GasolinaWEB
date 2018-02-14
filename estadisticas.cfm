<cfparam name="url.estadoID" default="0">
<cfparam name="url.municipioID" default="0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" ></script>
<script src="js/lodash.js"></script>
 <cfprocessingdirective pageencoding = "utf-8">

<style>
  i { text-transform: capitalize; } 
  .bg-inverse {background-color: #668178 !important;}
  .navbar {margin-bottom:0px;}
  .navbar-inverse {background-color: #222;border-color: #668178;}
  .navbar-inverse .navbar-brand {color: #ffffff;}
  .logo { position:absolute;left:5px;top:20px;margin: 0px 15px 15px 0px;}
  .navbar-inverse .navbar-nav>.active>a, .navbar-inverse .navbar-nav>.active>a:focus, .navbar-inverse .navbar-nav>.active>a:hover{background-color: #668178 !important;}
</style>
<nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse" style="">
    <cfoutput>
      <a class="navbar-brand" href="precio.cfm?estadoID=#url.estadoID#&municipioID=#url.municipioID#">&nbsp;&nbsp;&nbsp; <i class="glyphicon glyphicon-arrow-left" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp; Atras</a>
    </cfoutput>
</nav>
<div class="jumbotron">
  <div class="container text-center">
   La sección de estadísticas esta bajo construcción,
  </div>
</div>