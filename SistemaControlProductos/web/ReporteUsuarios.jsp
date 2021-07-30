<jsp:include page="auxiliares/encabezado.jsp" />
<style>
    @media print{
        .noimprimir{
            display: none;
        }
    }
</style>

<div id="UsuariosApp"> <!--Identificador de vueJS-->    

    <div class="container">

        <br>

        <div class="row">
            <div class="col-12">
                <h1 class="h1 float-left"><a class="btn btn-outline-danger btn-lg noimprimir" href="javascript: history.go(-1)" ><</a>&nbsp;&nbsp;Reporte Usuarios</h1>
            </div>
        </div>

        <table class="table table-striped">
            <thead class="" >
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Nombres</th>
                    <th scope="col">Apellidos</th>
                    <th scope="col">Usuario</th>
                    <th scope="col">Rol</th>
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
                </tr>                    
            </tbody>
        </table>

        <button class="noimprimir btn badge-dark" onclick="window.print()">Imprimir</button>
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
            Imprimir: function () {
                axios.get('UsuarioControlador', {
                    params: {
                        accion: "Imprimir"
                    }
                }).then(response => {
                    console.log(accion);
                });
            }
        },
        mounted: function () { //Esto se ejecuta al cargar el DOM                    
            this.ListarDatos();
        }
    });

</script>





<jsp:include page="auxiliares/piedePagina.jsp" />