<jsp:include page="auxiliares/encabezado.jsp" />

<div id="app">

    <!-- MODAL PARA VERIFICAR SI EXISTEN USUARIOS EN LA DB--->
    <div class="modal fade" id="NuevoUsuario" tabindex="-1" aria-labelledby="NuevoUsuario" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning" >         
                    <h5 class="modal-title text-center">!ATENCION¡</h5>                 
                </div>
                <div class="modal-body">
                    <center>
                        <img src="imagenes/warning.png" alt="" height="60">
                        <div class="alert alert-warning" role="alert">
                            No se ha detectado ningun usuario en la base de datos. Proceda a crearlo.
                        </div>
                    </center>

                    <form v-on:submit.prevent="RegistrarPrimerUsuario()">

                        <div class="form-group">
                            <label for="txtNombres">Nombres:</label>
                            <input type="text" class="form-control" id="txtNombres" required v-model='txtNombres'>                        
                        </div>
                        <div class="form-group">
                            <label for="txtApellidos">Apellidos: </label>
                            <input type="text" class="form-control" id="txtApellidos" required v-model="txtApellidos">                        
                        </div>
                        <div class="form-group">
                            <label for="txtUsuario">Usuario: </label>
                            <input type="text" class="form-control" id="txtUsuario" required v-model="txtUsuario">                        
                        </div>
                        <div class="form-group">
                            <label for="txtClave">Clave: </label>
                            <input type="password" class="form-control" id="txtClave" required v-model="txtClave">                        
                        </div>
                        <small class="form-text text-muted text-center">Por favor guarde su informacion para posteriormente acceder.</small>
                        <br>

                        <input type="submit" value='CREAR' class='btn btn-primary btn-block'>
                    </form>
                    <hr/>
                </div>            
            </div>
        </div>
    </div>

    <!------------------------------------------------------------------------------------------------------------------------->

    <div class="d-flex justify-content-center align-items-center contenedor-login">
        <form class="formulario-login text-center" v-on:submit.prevent="ValidarLogin()">
            <h1 class="mb-5 font-weight-light text-uppercase">Inicio de sesión</h1>
            <div class="form-group"> 
                <input type="text" autofocus class="form-control rounded-pill form-control-lg" autocomplete="off" placeholder="Nombre de usuario" name="txtUsuario" required v-model="txtUsuario">
            </div>
            <div class="form-group">
                <input type="password" class="form-control rounded-pill form-control-lg" autocomplete="off" placeholder="Contraseña" name="txtClave" required v-model="txtClave">
            </div>
            <div id="MensajesLogin">

            </div> 
            <button type="submit" class="btn mt-5 rounded-pill btn-lg btn-custom btn-block text-uppercase" name="accion" value="Ingresar">Iniciar sesión</button>                

        </form>
    </div> 
</div>



<script type="text/javascript">

    new Vue({
        el: '#app',
        data: {
            txtNombres: "",
            txtApellidos: "",
            txtUsuario: "",
            txtClave: "",
        },
        methods: {
            ValidarLogin: function () {

                axios.get('UsuarioControlador', {
                    params: {
                        accion: "ValidarLogin",
                        txtUsuario: this.txtUsuario,
                        txtClave: this.txtClave
                    }
                }).then(respuesta => {

                    console.log(respuesta.data);
                    let datos = respuesta.data;

                    if (datos == false) {
                        MostrarMensaje("#MensajesLogin", "danger", "Usuario o contraseña incorrecta.");
                    } else {
                        if (datos.Rol === 2) {
                            window.location.href = "MenuAdministrador.jsp";
                        } else {
                            window.location.href = "MenuUsuario.jsp";
                        }
                    }


                    /*if (res[0] == true) {                        
                     if (res[1] == 2) {
                     window.location.href = "MenuAdministrador.jsp";
                     } else {
                     window.location.href = "MenuUsuario.jsp";
                     }
                     } else {
                     MostrarMensaje("#MensajesLogin", "danger", "Usuario o contraseña incorrecta.");
                     }*/

                }).catch(error => {
                    MostrarMensaje("#MensajesLogin", "danger", "Problemas con el servidor");
                });
            },
            RegistrarPrimerUsuario: function () {

                axios.get('UsuarioControlador', {
                    params: {
                        accion: "RegistrarPrimerUsuario",
                        txtNombres: this.txtNombres,
                        txtApellidos: this.txtApellidos,
                        txtUsuario: this.txtUsuario,
                        txtClave: this.txtClave
                    }
                }).then(respuesta => {
                    console.log(respuesta.data);
                    $('#NuevoUsuario').modal('toggle'); //cierra modal

                    if (respuesta.data === 1)
                        MostrarMensaje("#MensajesLogin", "success", "Registro completo! Por favor inicia sesion.");
                    else {
                        MostrarMensaje("#MensajesLogin", "warning", "No se pudo crear el registro. Por favor recarga la pagina.");
                    }
                }).catch(error => {
                    MostrarMensaje("#MensajesLogin", "danger", "Problemas con el servidor");
                });
            }
        },
        mounted: function () {
            //este metodo se ejecuta nomas carga la pagina  y verifica si hay usuarios registrados
            axios.get('UsuarioControlador', {
                params: {
                    accion: "NumeroUsuarios"
                }
            }).then(response => {
                if (response.data == 0) {
                    $('#NuevoUsuario').modal('toggle'); //Abre modal de no haber encontrado registros.
                }
            });
        }

    });
</script>



<jsp:include page="auxiliares/piedePagina.jsp" />