<cfparam name="url.estadoID" default="0">
<cfparam name="url.municipioID" default="0">
<!DOCTYPE html>
<script src="js\jquery-3.2.1.min.js"/>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bootstrap-theme.min.css">
<script src="js/bootstrap.min.js"/>
<script src="js\bootbox.min.js"/>
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
<cfif url.estadoID eq 0 and url.municipioID eq 0>

</cfif>


<cfabort>
<!DOCTYPE html>
<html>
<head>
    <title>JavaScript View</title>

    <script type="text/javascript">

        function showToast(){
            var message = document.getElementById("message").value;
            var lengthLong = document.getElementById("length").checked;

            /* 
                Call the 'makeToast' method in the Java code. 
                'app' is specified in MainActivity.java when 
                adding the JavaScript interface. 
             */
            app.makeToast(message, lengthLong);
            return false;
        }

        /* 
            Call the 'showToast' method when the form gets 
            submitted (by pressing button or return key on keyboard). 
         */
        window.onload = function(){
            var form = document.getElementById("form");
            form.onsubmit = showToast;
        }
    </script>
</head>

<body>

<form id="form">
    Message: <input id="message" name="message" type="text"/><br />
    Long: <input id="length" name="length" type="checkbox" /><br />

    <input type="submit" value="Make Toast" />
</form>

</body>
</html>