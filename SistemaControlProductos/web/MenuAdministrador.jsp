<jsp:include page="auxiliares/encabezado.jsp" />
<jsp:include page="auxiliares/navbar.jsp" />

<br>


<div class="container">
    <br>
    <p class="h1">Bienvenido <%= session.getAttribute("NomLogin")%> </p>
    <span class="badge badge-dark">Administrador</span>
    <hr>


    <div class="col-md-12">
        <div class="card-deck">

            <div class="card text-center">
                <div class="card-header">
                    Productos
                </div>
                <div class="card-body">                          
                    <img src="imagenes/product.svg" alt="" height="75">
                    <p class="card-text">Administra las opciones de productos</p>
                </div>
                <div class="card-footer text-muted">
                    <a href="Productos.jsp" class="btn" style="background-color: #723dbe; color: #fff;">Acceder</a>
                </div>
            </div>
            
            <div class="card text-center">
                <div class="card-header">
                    Materiales
                </div>
                <div class="card-body">                          
                    <img src="imagenes/herramientas.png" alt="" height="75">
                    <p class="card-text">Administra las opciones de Ingredientes</p>
                </div>
                <div class="card-footer text-muted">
                    <a href="Materiales.jsp" class="btn" style="background-color: #723dbe; color: #fff;">Acceder</a>
                </div>
            </div>


            <div class="card text-center">
                <div class="card-header">
                    Usuarios
                </div>
                <div class="card-body">                          
                    <img src="imagenes/users.png" alt="" height="75">
                    <p class="card-text">Administra las opciones de materiales</p>
                </div>
                <div class="card-footer text-muted">
                    <a href="Usuarios.jsp" class="btn" style="background-color: #723dbe; color: #fff;">Acceder</a>
                </div>
            </div>
            <div class="card text-center">
                <div class="card-header">
                    Reportes
                </div>
                <div class="card-body">                          
                    <img src="imagenes/report.svg" alt="" height="75">
                    <p class="card-text">Mira los reportes disponibles</p>
                </div>
                <div class="card-footer text-muted">
                    <a href="ReporteUsuarios.jsp" class="btn" style="background-color: #723dbe; color: #fff;">Acceder</a>
                </div>
            </div>
            

        </div>
    </div>

</div>
</div>

<jsp:include page="auxiliares/piedePagina.jsp" />