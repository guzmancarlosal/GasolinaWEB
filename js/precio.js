  $( document ).ready(function() {
    linkTemplate = _.template($('#tmpl_gasolinera').html());
    var thisTable = document.getElementById("example");
    function populateTable () {
      $('#example tr:not(:first)').remove();
      $.ajax({
        url: 'api.cfm?mode=getPrecio&estadoid='+jsEstadoID+'&municipioid='+jsMunID,
        method: "POST",
        data: {
          favList : $('#favList').val()
        }
        }).done(function(data){
        _.forEach(data,function(value, key) {
          var row = thisTable.insertRow();
          var gasCell = linkTemplate({
            obj:value,
            isFav:getFavList()
          });

          row.insertCell().innerHTML = gasCell;
        }); 
      });
    }
    populateTable ();
   
    $( "#linkFav" ).click(function() {
      $('#tableheader').text('Favoritos');
      $('.nav-item').toggle();
      var favL = getFavList();
      $('#favList').val(favL);
      populateTable ();
    });
    $( "#linkNonFav" ).click(function() {
      $('#tableheader').text(siteName);
      $('.nav-item').toggle();
      $('#favList').val("");
      populateTable ();
    });
    
    $( "#rChange" ).click(function() {
      app.clearPreferences('edo');
      app.clearPreferences('mun');
      app.loadApp();
    });
    function getFavList () {
      try {
        var favList = app.getFavorites();
      } catch (e) {
        var favList = '0,10,50,1,20,300'
      }
      return favList;
    }
    addFav = function (id) {
      try {app.saveArray(id);}catch(e){}
      $('#btn'+id).hide();
      $('#spn'+id).text('Agregado! Ve a la sección de Favoritos en el menú de la aplicación ');
      $('#spn'+id).append('<span class="glyphicon glyphicon-ok" aria-hidden="true" >');
    }
    remFav = function (id) {
      try {app.removeArray(id);}catch(e){}
      $('#btn'+id).hide();
      $('#spn'+id).text('Eliminado de Favoritos!');
       $('#spn'+id).append('<span class="glyphicon glyphicon-remove" aria-hidden="true" >');
    }

    ftnDeleteFav = function (id) {
      bootbox.confirm("¿Eliminar todos tus Favoritos?", function(result){  try {app.clearPreferences('all');}catch(e){} });
     
    }
   

    // for debugging purposes
    $( "#btnEdo" ).click(function() {
      app.clearPreferences('edo');
    });
    $( "#btnMun" ).click(function() {
      app.clearPreferences('mun');
    });
    $( "#btnAll" ).click(function() {
      app.clearPreferences('all');
      location.reload();
    });
    $( "#btnReload" ).click(function() {
      app.clearPreferences('reload');
    });
    $( "#btngetUserNmae" ).click(function() {
      app.getUsername();
    });
    
});   

