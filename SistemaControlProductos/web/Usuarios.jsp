<jsp:include page="auxiliares/encabezado.jsp" />
<jsp:include page="auxiliares/navbar.jsp" />


<div id="UsuariosApp"> <!--Identificador de vueJS-->

    <div class="container">

        <br>

        <div class="row">
            <div class="col-12">
                <h1 class="h1 float-left"><a class="btn btn-outline-danger btn-lg" href="javascript: history.go(-1)" ><</a>&nbsp;&nbsp;Usuarios</h1>
                <!-- Boton que activa el model de agregar -->
                <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#ModalAgregarMod" v-on:click="AccionModal = 'Agregar'">
                    Agregar
                </button>
            </div>
        </div>

        <!--Aqui aparecen los mensajes de errores o exito-->
        <div id="MensajesRegistros"></div>

        <hr>

        <!--Modal de pregunta -->
        <div class="modal fade" id="ConfirmarModal" tabindex="-1" data-keyboard="false" aria-labelledby="ConfirmarModal" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #b71c1c">
                        <h5 class="modal-title text-light">CONFIRMAR</h5>                                
                    </div>
                    <div class="modal-body">
                        <center>
                            <img src="imagenes/delete.png" alt="" height="60">
                            <h5>¿Desea eliminar este registro?</h5>
                            <hr>
                            <input type="button" class="btn btn-primary" value="Si" v-on:click="Eliminar()" data-dismiss="modal"/>
                            <input type="button" class="btn btn-danger" data-dismiss="modal" value="Cancelar" v-on:click="TxtId =''"/> <!--El id se limpia-->

                        </center>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal AGREGAR-->
        <div class="modal fade" id="ModalAgregarMod" tabindex="-1" data-keyboard="false" aria-labelledby="ModalAgregarMod" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4a0072">
                        <h5 class="modal-title text-light">{{AccionModal}}</h5>                                
                    </div>

                    <div class="modal-body">
                        <!--Formulario de agregar-->
                        <form  v-on:submit.prevent="AgregarOModificar()" id="AgregarModificarForm">

                            <input v-model="TxtId" type="hidden" class="form-control" id="TxtId" /><!--Id Oculto-->

                            <div class="mb-3">
                                <label for="TxtNombres" class="col-form-label">Nombres</label>
                                <input v-model="TxtNombres" type="text" class="form-control" id="TxtNombres" required autofocus>
                            </div>
                            <div class="mb-3">
                                <label for="TxtApellidos" class="col-form-label">Apellidos:</label>
                                <input v-model="TxtApellidos" type="text" class="form-control" id="TxtApellidos" required>
                            </div>
                            <div class="mb-3">
                                <label for="TxtUsuario" class="col-form-label">Usuario:</label>
                                <input v-model="TxtUsuario" type="text" class="form-control" id="TxtUsuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="TxtClave" class="col-form-label">Clave</label>
                                <input v-model="TxtClave" type="password" class="form-control" id="TxtClave" required>
                            </div>

                            <div class="mb-3">
                                <label for="TxtIdRol" class="col-form-label">Rol:</label>
                                <select v-model="TxtIdRol" class="form-control" required>
                                    <option disabled selected>Seleccione un Rol</option>
                                    <option v-for="(value, key) in RolesList" v-bind:value="key" >{{value}}</option>                                                                           
                                </select>
                            </div>

                            <hr>                           

                            <center>
                                <div v-show="AccionModal == 'Modificar'">
                                    <div class="alert alert-info" role="alert">
                                        Al modificar, tendras que asignarle una nueva clave al usuario.
                                    </div>
                                </div>

                                <input type="submit" class="btn btn-primary" v-model="AccionModal"/>
                                <input type="button" class="btn btn-danger" data-dismiss="modal" value="Cancelar" v-on:click="LimpiarCampos()"/>

                            </center>
                        </form>
                    </div>

                </div>
            </div>
        </div>


        <table class="table table-striped">
            <thead class="" style="background-color: #4a0072; color: white;">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Nombres</th>
                    <th scope="col">Apellidos</th>
                    <th scope="col">Usuario</th>
                    <th scope="col">Rol</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="item in ListaUsuarios">
                    <th scope="row">{{ item.id }}</th>
                    <td>{{ item.Nombres }}</td>
                    <td>{{ item.Apellidos }}</td>
                    <td>{{ item.Usuario }}</td>
                    <td>                        
                        <span v-if="item.Rol == 2"class="badge badge-dark">{{(RolesList[item.Rol])}}</span>
                        <span v-else class="badge badge-info">{{(RolesList[item.Rol])}}</span>                        
                    </td>
                    <td>
                        <input type="button" value="Modificar" data-toggle="modal" data-target="#ModalAgregarMod" class="btn btn-primary" v-on:click="ColocarDatos(item.id)"/>
                        <input type="button" value="Eliminar" class="btn btn-danger" v-on:click="TxtId = item.id" data-toggle="modal" data-target="#ConfirmarModal"/> <!--En v-on:click se asigna el id-->
                    </td>
                </tr>                    
            </tbody>
        </table>



    </div>
</div>


<script>

    var app = new Vue({
        el: '#UsuariosApp',
        data: {
            AccionModal: "",
            TxtId: "",
            TxtNombres: "",
            TxtApellidos: "",
            TxtUsuario: "",
            TxtClave: "",
            TxtIdRol: 0,
            ListaUsuarios: [],
            RolesList: {"1": 'Usuario Basico', "2": 'Administrador'}
        },
        methods: {
            ListarDatos: function () {
                axios.get('UsuarioControlador', {
                    params: {
                        accion: "Listar"
                    }
                }).then(response => this.ListaUsuarios = response.data);
            },
            LimpiarCampos: function () {
                this.TxtId = "";
                this.TxtNombres = "";
                this.TxtApellidos = "";
                this.TxtUsuario = "";
                this.TxtClave = "";
                this.TxtIdRol = null;
            },
            AgregarOModificar: function () {
                if (this.AccionModal === "Agregar")
                    this.Agregar();
                else if (this.AccionModal === "Modificar")
                    this.Modificar();
            },
            Agregar: function () {
                $('#ModalAgregarMod').modal('toggle'); //Cierra el modal

                axios.get('UsuarioControlador', {
                    params: {
                        accion: "Agregar",
                        nombres: this.TxtNombres,
                        apellidos: this.TxtApellidos,
                        usuario: this.TxtUsuario,
                        clave: this.TxtClave,
                        idRol: this.TxtIdRol
                    }
                }).then(response => {
                    this.LimpiarCampos();
                    this.ListarDatos();
                    $("#AgregarModificarForm").trigger("reset");

                    if (response.data == 1) {
                        MostrarMensaje("#MensajesRegistros", "success", "El registro se agrego con exito!");
                    } else
                        MostrarMensaje("#MensajesRegistros", "danger", "El registro no pudo ser procesado!");
                });
            },
            Modificar: function () {
                $('#ModalAgregarMod').modal('toggle'); //Cierra el modal

                axios.get('UsuarioControlador', {
                    params: {
                        accion: "Modificar",
                        id: this.TxtId,
                        nombres: this.TxtNombres,
                        apellidos: this.TxtApellidos,
                        usuario: this.TxtUsuario,
                        clave: this.TxtClave,
                        idRol: this.TxtIdRol
                    }
                }).then(response => {
                    this.LimpiarCampos();
                    this.ListarDatos();
                    $("#AgregarModificarForm").trigger("reset");
                    if (response.data == 1) {
                        MostrarMensaje("#MensajesRegistros", "success", "El registro se ha modificado con exito!");
                    } else
                        MostrarMensaje("#MensajesRegistros", "danger", "El registro no pudo ser modificado!");
                });
            },
            Eliminar: function () {
                axios.get('UsuarioControlador', {
                    params: {
                        accion: "Eliminar",
                        id: this.TxtId
                    }
                }).then(response => {

                    this.TxtId = '';
                    this.ListarDatos();

                    if (response.data == 1) {
                        MostrarMensaje("#MensajesRegistros", "success", "El registro se ha eliminado con exito!");
                    } else
                        MostrarMensaje("#MensajesRegistros", "danger", "El registro no pudo ser eliminado!");
                });
            },
            ColocarDatos: function (id) {
                this.AccionModal = "Modificar";
                axios.get('UsuarioControlador', {
                    params: {
                        accion: "ConsultarId",
                        id: id
                    }
                }).then(respuesta => {
                    console.log(respuesta.data);
                    let datos = respuesta.data;
                    this.TxtId = datos.id;
                    this.TxtNombres = datos.Nombres;
                    this.TxtApellidos = datos.Apellidos;
                    this.TxtUsuario = datos.Usuario;
                    this.TxtClave = '';
                    this.TxtIdRol = datos.Rol;
                });
            }
        },
        mounted: function () { //Esto se ejecuta al cargar el DOM                    
            this.ListarDatos();
        }
    });

</script>





<jsp:include page="auxiliares/piedePagina.jsp" />