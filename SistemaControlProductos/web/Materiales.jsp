<jsp:include page="auxiliares/encabezado.jsp" />
<jsp:include page="auxiliares/navbar.jsp" />


<div id="MaterialesApp"> <!--Identificador de vueJS-->

    <div class="container">

        <br>

        <div class="row">
            <div class="col-12">
                <h1 class="h1 float-left"><a class="btn btn-outline-danger btn-lg" href="javascript: history.go(-1)" ><</a>&nbsp;&nbsp;Materiales</h1>
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
                                <label for="TxtNomMaterial" class="col-form-label">Nombre Material: </label>
                                <input v-model="TxtNomMaterial" type="text" class="form-control" id="TxtNomMaterial" required autofocus>
                            </div>
                            <div class="mb-3">
                                <label for="TxtCantidad" class="col-form-label">Cantidad:</label>
                                <input v-model="TxtCantidad" type="number" step="any" class="form-control" id="TxtCantidad" required>
                            </div>                           

                            <div class="mb-3">
                                <label for="TxtUniMedida" class="col-form-label">Unidad de medida:</label>
                                <select v-model="TxtUniMedida" class="form-control" required>
                                    <option disabled selected>Seleccione un Rol</option>
                                    <option v-for="(value, key) in MaterialesList" v-bind:value="key" >{{value}}</option>                                                                           
                                </select>
                            </div>
                            <hr>                          

                            <center>                               

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
                    <th scope="col">Material</th>
                    <th scope="col">Cantidad</th>                                       
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="item in ListaMateriales">
                    <th scope="row">{{ item.id }}</th>
                    <td>{{ item.Nombrematerial }}</td>
                    <td>{{ item.Cantidad }}  {{ MaterialesList[item.UnidadMedida] }}</td>                                     
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
        el: '#MaterialesApp',
        data: {
            AccionModal: "",
            TxtId: "",
            TxtNomMaterial: "",
            TxtCantidad: "",
            TxtUniMedida: null,
            ListaMateriales: [],
            MaterialesList: {1: "Kilogramos", 2: "Metros", 3: "Metros Cuadrados", 4: "Litros"}
        },
        methods: {
            ListarDatos: function () {
                axios.get('MaterialControlador', {
                    params: {
                        accion: "Listar"
                    }
                }).then(response => this.ListaMateriales = response.data);
                console.log("Listar");
            },
            LimpiarCampos: function () {
                this.TxtId = "";
                this.TxtNomMaterial = "";
                this.TxtCantidad = "";
                this.TxtUniMedida = null;
            },
            AgregarOModificar: function () {
                if (this.AccionModal === "Agregar")
                    this.Agregar();
                else if (this.AccionModal === "Modificar")
                    this.Modificar();
            },
            Agregar: function () {
                $('#ModalAgregarMod').modal('toggle'); //Cierra el modal

                axios.get('MaterialControlador', {
                    params: {
                        accion: "Agregar",
                        txtNomMaterial: this.TxtNomMaterial,
                        txtCantidad: this.TxtCantidad,
                        txtUniMedida: this.TxtUniMedida
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

                axios.get('MaterialControlador', {
                    params: {
                        accion: "Modificar",
                        txtId: this.TxtId,
                        txtNomMaterial: this.TxtNomMaterial,
                        txtCantidad: this.TxtCantidad,
                        txtUniMedida: this.TxtUniMedida
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
                axios.get('MaterialControlador', {
                    params: {
                        accion: "Eliminar",
                        txtId: this.TxtId
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
                axios.get('MaterialControlador', {
                    params: {
                        accion: "ConsultarId",
                        txtId: id
                    }
                }).then(respuesta => {
                    console.log(respuesta.data);
                    let datos = respuesta.data;
                    this.TxtId = datos.id;
                    this.TxtNomMaterial = datos.Nombrematerial;
                    this.TxtCantidad = datos.Cantidad;
                    this.TxtUniMedida = datos.UnidadMedida;
                });
            }
        },
        mounted: function () { //Esto se ejecuta al cargar el DOM                    
            this.ListarDatos();
        }
    });

</script>





<jsp:include page="auxiliares/piedePagina.jsp" />