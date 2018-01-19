<script type="text/template" id="tmpl_gasolinera" class="template">
	<h4><a href="https://www.google.com.mx/maps/place/<%=obj.direccion%> <%=obj.nombre%>" target="_blank"><img src="img/gmsmall.png" height="40" width="40"></a> <%=obj.direccion%> <b><%=obj.nombre%></b></h4> 
	<% if (_.includes(isFav, obj.id)) {%>
		<button type="button" class="btn btn-default btn-md" id="btn<%=obj.id%>" onclick="remFav('<%=obj.id%>');">
			<span class="glyphicon glyphicon-star" aria-hidden="true" ></span>Quitar Favorito
		</button>
		<span id="spn<%=obj.id%>" style="color:red;font-style: italic;"></span>
	<%} else { %>
		<button type="button" class="btn btn-default btn-md" id="btn<%=obj.id%>" onclick="addFav('<%=obj.id%>');">
			<span class="glyphicon glyphicon-star-empty" aria-hidden="true" ></span>Agregar Favorito
		</button>
		<span id="spn<%=obj.id%>" style="color:green;font-style: italic;"></span>
	<%}%>
	<br><br>
	<table style="margin:20px;background-color: #F0F0F0;">
		<tr class="precioheader">
		<% var loopCounter = 0; %>
		<% _.forEach(obj.precio, function(value, key) { 
			if (key != "i") {		%>
			<td width="30%" style="border-top:0px solid #F0F0F0;"><%- key %>:<br>
			<b style="font-size: 200%;"><%- value %></b></td>
		<% 	loopCounter++;
			}
			}); %> 
		</tr>
		<tr>
			<td colspan="<%=loopCounter%>">
				<b>Fecha de reporte</b>:<span  style="color:red;"> <%=obj.fechaaplicacion%></span>
			</td>
		</tr>
	</table><br><br>
	
</script>
