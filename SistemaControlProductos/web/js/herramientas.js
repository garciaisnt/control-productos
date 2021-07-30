
/*METODO PARA MOSTRAR MENSAJES*/
function MostrarMensaje(enElemento, tipo, texto) { /*PLANTILLA DE MENSAJE A MOSTRAR*/
    const cadena = `<div class="alert alert-` + tipo + ` alert-dismissible fade show" role="alert">
            ` + texto + `
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
            </div>`;
    $(enElemento).append(cadena);
}


