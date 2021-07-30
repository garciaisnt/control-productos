<jsp:include page="auxiliares/encabezado.jsp" />
<jsp:include page="auxiliares/navbar.jsp" />

<div id="appProductos">
    <div class="container">
        <br>
        <div class="row">
            <div class="col-12">
                <h1 class="h1 float-left"><a class="btn btn-outline-danger btn-lg" href="javascript: history.go(-1)" ><</a>&nbsp;&nbsp;Productos</h1>
                <!-- Boton que activa el model de agregar -->
                <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#ModalAgregarMod">
                    Agregar
                </button>
            </div>
        </div>        
        <hr>



        <!-- Modal MaterialesDelProducto-->
        <div class="modal fade" id="MaterialesDelProducto" tabindex="-1" data-keyboard="false" aria-labelledby="MaterialesDelProducto" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4a0072">
                        <h5 class="modal-title text-light">Materiales del producto</h5>                                
                    </div>

                    <div class="modal-body">                        
                        <br>

                        <table class="table table-striped">
                            <thead class="">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Material</th>
                                    <th scope="col">Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>                            
                                <tr v-for="item in ListaMaterialesDelProducto">
                                    <th scope="row">{{ item.Id }}</th>
                                    <td>{{ item._material.Nombrematerial }}</td>
                                    <td>{{ item.Cantidad }}  {{ MaterialesList[item.UnidadMedida] }}</td> 
                                </tr>                    
                            </tbody>
                        </table>
                        <div v-if="ListaMaterialesDelProducto.length == 0">
                            <div class="alert alert-warning" role="alert">
                                <center>No hay datos que mostrar</center>
                            </div>
                        </div>
                        <hr>                                             
                        <center>
                            <input type="button" class="btn btn-outline-danger" data-dismiss="modal" value="Cancelar" v-on:click="txtId = null"/>
                        </center>
                        </form>
                    </div>

                </div>
            </div>
        </div>




        <!-- Modal AGREGAR-->
        <div class="modal fade" id="ModalAgregarMod" tabindex="-1" data-keyboard="false" aria-labelledby="ModalAgregarMod" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4a0072">
                        <h5 class="modal-title text-light">Agregar</h5>                                
                    </div>

                    <div class="modal-body">
                        <!-- txtId, txtNombreProducto, txtFecha --> 
                        <!--Formulario de agregar-->
                        <form v-on:submit.prevent="AgregarM()" id="AgregarModificarForm">

                            <!-- <input type="hidden" v-model="txtId" id="txtId" class="form-control"> Id oculto-->
                            <div class="mb-3">
                                <label for="txtNombreProducto" class="form-label">Nombre Producto: </label>
                                <input type="text" v-model="txtNombreProducto" autocomplete="off" id="txtNombreProducto" class="form-control">
                            </div>                            
                            <hr> 
                            <center>                               
                                <input type="submit" class="btn btn-primary" value="Agregar"/>
                                <input type="button" class="btn btn-danger" data-dismiss="modal" value="Cancelar" />
                            </center>
                        </form>
                    </div>

                </div>
            </div>
        </div>


        <div id="Mensajes"></div>


        <!-- Modal AGREGAR Materiales-->
        <div class="modal fade" id="ModalAgregarMateriales" tabindex="-1" data-keyboard="false" aria-labelledby="ModalAgregarMateriales" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4a0072">
                        <h5 class="modal-title text-light">Agregar</h5>                                
                    </div>

                    <div class="modal-body">

                        <div class="row">
                            <div class="col-12">
                                <h5 class="h5 float-left">&nbsp;&nbsp;Materiales</h5>
                                <!-- Boton que activa el model de agregar -->

                                <a href="Materiales.jsp" class="btn btn-primary float-right">Agregar</a>
                            </div>
                        </div>
                        <br>

                        <table class="table table-striped">
                            <thead class="">
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
                                        <input type="button" value="Seleccionar" data-toggle="modal" data-target="#ModalAsignarCantidad" class="btn btn-primary" v-on:click="txtIdMaterial = item.id"/>
                                    </td>
                                </tr>                    
                            </tbody>
                        </table>
                        <hr>
                        <div id="MensajesMaterial"></div>

                        <center>
                            <input type="button" class="btn btn-outline-danger" data-dismiss="modal" value="Cancelar" v-on:click="txtId = null"/>
                        </center>
                        </form>
                    </div>

                </div>
            </div>
        </div>





        <!-- Modal ASIGNAR CANTIDAD-->
        <div class="modal fade" id="ModalAsignarCantidad" tabindex="-1" data-keyboard="false" aria-labelledby="ModalAsignarCantidad" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4a0072">
                        <h5 class="modal-title text-light">Asignar cantidad</h5>                                
                    </div>

                    <div class="modal-body">

                        <!--Formulario de cantidad-->
                        <form v-on:submit.prevent="AgregarMaterialAProducto()" id="AsignarCantidadForm">

                            <input type="hidden" v-model="txtId"/>
                            <input type="hidden" v-model="txtIdMaterial"/>                                    
                            <div class="mb-3">
                                <label for="txtCantidad" class="col-form-label">Cantidad:</label>
                                <input v-model="txtCantidad" type="number" step="any" min="1" class="form-control" id="txtCantidad" required>
                            </div>                            
                            <hr> 
                            <center>                               
                                <input type="submit" class="btn btn-outline-primary" value="Agregar"/>
                                <input type="button" class="btn btn-outline-danger" data-dismiss="modal" value="Cancelar"/>
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
                    <th scope="col">Nombre Producto</th>
                    <th scope="col">Fecha</th>                    
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="item in ListaProductos">
                    <th scope="row">{{ item.id }}</th>
                    <td>{{ item.NomProducto }}</td>                    
                    <td>{{ item.fecha }}</td>                    
                    <td>
                        <input type="button" value="Agregar" data-toggle="modal" data-target="#ModalAgregarMateriales" class="btn btn-outline-primary" v-on:click="ListarMatyAsignarId(item.id)"/>  <!--En v-on:click se asigna el id-->
                        <input type="button" value="ver" data-toggle="modal" data-target="#MaterialesDelProducto" class="btn btn-outline-secondary" v-on:click="AsignarIdMaterialDelProducto(item.id)"/>  <!--En v-on:click se asigna el id-->

                    </td>
                </tr>                    
            </tbody>
        </table>

    </div>
</div>

<script>

    new Vue({
        el: '#appProductos',
        data: {
            txtId: 0,
            txtIdMaterial: 0,
            txtCantidad: 0,
            txtNombreProducto: '',
            txtFecha: '',
            ListaProductos: [],
            ListaMateriales: [],
            ListaMaterialesDelProducto: [],
            MaterialesList: {1: "Kilogramos", 2: "Metros", 3: "Metros Cuadrados", 4: "Litros"}
        },
        methods: {
            AgregarMaterialAProducto: function () {
                axios.get('MaterialesUtilizadosControlador', {
                    params: {
                        accion: "Agregar",
                        txtId: this.txtId,
                        txtIdMaterial: this.txtIdMaterial,
                        txtCantidad: this.txtCantidad
                    }
                }).then(response => {
                    $('#ModalAsignarCantidad').modal('toggle'); //Cierra el modal
                    this.txtIdMaterial = null;
                    this.txtCantidad = 0;

                    console.log(response.data);
                    if (response.data.includes('1')) {
                        MostrarMensaje("#MensajesMaterial", "success", "El material se agrego con exito!");
                    } else {
                        MostrarMensaje("#MensajesMaterial", "danger", "El material no pudo ser procesado!");
                    }
                    this.ListarDatos();
                    this.ListarMateriales();
                    $("#AsignarCantidadForm").trigger("reset");

                });
            },
            ListarMatyAsignarId: function (id) {
                this.txtId = id;
                this.ListarMateriales();
            },
            ListarDatos: function () {
                axios.get('DetalleProductoControlador', {
                    params: {
                        accion: "Listar"
                    }
                }).then(response => {
                    this.ListaProductos = response.data;
                    console.log(response.data);
                });
            },
            /***************************************************************/
            AsignarIdMaterialDelProducto: function (id) {
                this.txtId = id;
                this.ListarMaterialesDelProducto();
            },
            ListarMaterialesDelProducto: function () {
                axios.get('MaterialesUtilizadosControlador', {
                    params: {
                        accion: "ListarPorIdDetalleProducto",
                        txtId: this.txtId
                    }
                }).then(response => {
                    this.ListaMaterialesDelProducto = response.data;
                    console.log(response.data);
                });
            },
            ListarMateriales: function () {
                axios.get('MaterialControlador', {
                    params: {
                        accion: "Listar"
                    }
                }).then(response => this.ListaMateriales = response.data);
            },
            AgregarM: function () {
                $('#ModalAgregarMod').modal('toggle'); //Cierra el modal

                axios.get('DetalleProductoControlador', {
                    params: {
                        accion: "Agregar",
                        txtNombreProducto: this.txtNombreProducto
                    }
                }).then(response => {
                    this.txtNombreProducto = '';
                    this.ListarDatos();
                    $("#AgregarModificarForm").trigger("reset");

                    if (response.data == 1) {
                        MostrarMensaje("#Mensajes", "success", "El registro se agrego con exito!");
                    } else
                        MostrarMensaje("#Mensajes", "danger", "El registro no pudo ser procesado!");
                });

            }
        },
        mounted: function () { //Esto se ejecuta al cargar el DOM                    
            this.ListarDatos();
            this.ListarMaterialesDelProducto();
        }

    });



</script>


<jsp:include page="auxiliares/piedePagina.jsp" />