
<!--Navegacion-->
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #723dbe;" >
    <a class="navbar-brand" href="#" style="color: #fff;">Sistema Control De Producción</a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarText">          
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #fff;">
                    <%= session.getAttribute("NomLogin")%>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">                         
                    <a class="dropdown-item" href="UsuarioControlador?accion=CerrarSesion">Cerrar Sesion</a>                  
                </div>
            </li>
        </ul>             
    </div>
</nav>
