<script type="text/template" id="tmpl_gasolinera" class="template">
	<b><%=nombre%></b><br>
	<a href="https://www.google.com.mx/maps/place/<%=direccion%> <%=nombre%>" target="_blank"><img src="img/gmsmall.png" height="20" width="20"> <i><%=direccion%></i></a>
	<br>
	<button type="button" class="btn btn-default btn-xs" onclick="app.saveArray('<%=id%>');">
		<span class="glyphicon glyphicon-star-empty" aria-hidden="true" ></span>Favorito
	</button>
</script>
<script type="text/template" id="tmpl_precio" class="template">
	<p>
	<% _.forEach(gasolinas, function(value, key) { %>
			<b><%- value %></b>:<i><%- key %></i><br>
	<% }); %> 
	<b>Fecha</b>:<span color="red"><%=fechaaplicacion%></span>
	</p>
</script>
