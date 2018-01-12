$( document ).ready(function() {
    linkTemplate = _.template($('#tmpl_gasolinera').html());
    gasTemplate = _.template($('#tmpl_precio').html());
    $('#example').DataTable({
      pageLength : 200,
      processing: true,
      serverSide: true, 
      bPaginate: false,
      bInfo : false,
      searching: false,
      ordering: false,
      ajax: {
        url: 'api.cfm?mode=getPrecio&estadoid='+jsEstadoID+'&municipioid='+jsMunID+'&listMode='+listMode,
      },
      createdRow: function ( row, data, index ) {
        var gasCell = linkTemplate({
          nombre:data.gasolina.nombre,
          direccion:data.gasolina.direccion,
          id:data.gasolina.id
        });
        var fechaApp  = data.precio.fechaaplicacion;
        var myGasObj  = data.precio;
        delete myGasObj.fechaaplicacion; 
        var priceCell = gasTemplate({
          gasolinas:myGasObj,
          fechaaplicacion :fechaApp
        });
        $( row ).find('td:eq(0)').html(gasCell);
        $( row ).find('td:eq(1)').html(priceCell);
       
      },
      columns: [
        {data:"gasolina"},
        {data:"precio"}
      ]
    });
});   