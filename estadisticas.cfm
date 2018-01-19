<cfparam name="url.estadoID" default="0">
<cfparam name="url.municipioID" default="0">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
<script src="js/lodash.js"></script>
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