package Controlador;

import Modelo.Usuario;
import ModeloDAO.UsuarioDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UsuarioControlador extends HttpServlet {

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create(); //serializar a una respuesta json

    UsuarioDAO dao = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String accion = request.getParameter("accion");
        PrintWriter out = response.getWriter();
        String respuestaJSON;

        switch (accion) {
            case "ValidarLogin": {

                String txtusuario = request.getParameter("txtUsuario");
                String txtclave = request.getParameter("txtClave");

                Usuario _usuario = new Usuario();
                _usuario.setUsuario(txtusuario);
                _usuario.setClave(txtclave);

                Usuario UsuarioValidado = new Usuario();
                UsuarioValidado = dao.ValidarLogin(_usuario); //asignar el valor del objeto
                                
                /* Si al nuevo objeto no se encuentra un valor nulo, significa que fue encontrado y comprobado*/
                if (UsuarioValidado.getNombres() != null) {
                    HttpSession misession = request.getSession(true);
                    misession.setAttribute("NomLogin", UsuarioValidado.getNombres());
                    misession.setAttribute("UsuarioLogin", UsuarioValidado.getUsuario());
                    misession.setAttribute("RolLogin", UsuarioValidado.getRol());                    
                    
                    respuestaJSON = this.gson.toJson(UsuarioValidado);
                    out.print(respuestaJSON); 
                    
                } else {
                    respuestaJSON = this.gson.toJson(false);
                    out.print(respuestaJSON);                    
                }
                out.flush();

            }
            break;
            case "NumeroUsuarios": {

                int nUsuario = dao.Listar().size();
                respuestaJSON = this.gson.toJson(nUsuario);
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "Listar": {

                respuestaJSON = this.gson.toJson(dao.Listar());
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "RegistrarPrimerUsuario": {

                if (dao.Listar().isEmpty()) //verificar si de verdad no hay usuarios
                {
                    String nombres = request.getParameter("txtNombres");
                    String apellidos = request.getParameter("txtApellidos");
                    String usuario = request.getParameter("txtUsuario");
                    String clave = request.getParameter("txtClave");
                    int rol = 2; //Rol de administrador

                    Usuario _usuario = new Usuario();
                    _usuario.setNombres(nombres);
                    _usuario.setApellidos(apellidos);
                    _usuario.setUsuario(usuario);
                    _usuario.setClave(clave);
                    _usuario.setRol(rol);

                    int respuesta = dao.Insertar(_usuario);

                    respuestaJSON = this.gson.toJson(respuesta);
                    out.print(respuestaJSON);
                    out.flush();
                }
            }
            break;
            case "Agregar": {

                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String usuario = request.getParameter("usuario");
                String clave = request.getParameter("clave");
                int rol = Integer.parseInt(request.getParameter("idRol"));

                Usuario _usuario = new Usuario();
                _usuario.setNombres(nombres);
                _usuario.setApellidos(apellidos);
                _usuario.setUsuario(usuario);
                _usuario.setClave(clave);
                _usuario.setRol(rol);

                int respuesta = dao.Insertar(_usuario);
                respuestaJSON = this.gson.toJson(respuesta);
                out.print(respuestaJSON);
                out.flush();

            }
            break;
            case "Modificar": {

                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String usuario = request.getParameter("usuario");
                String clave = request.getParameter("clave");
                int rol = Integer.parseInt(request.getParameter("idRol"));
                int id = Integer.parseInt(request.getParameter("id"));

                Usuario _usuario = new Usuario();
                _usuario.setId(id);
                _usuario.setNombres(nombres);
                _usuario.setApellidos(apellidos);
                _usuario.setUsuario(usuario);
                _usuario.setClave(clave);
                _usuario.setRol(rol);

                int respuesta = dao.Modificar(_usuario);
                respuestaJSON = this.gson.toJson(respuesta);
                out.print(respuestaJSON);
                out.flush();

            }
            break;
            case "ConsultarId": {
                int id = Integer.parseInt(request.getParameter("id"));
                respuestaJSON = this.gson.toJson(dao.UsuarioPorId(id));
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "Eliminar": {
                int id = Integer.parseInt(request.getParameter("id"));
                respuestaJSON = this.gson.toJson(dao.Eliminar(id));
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "CerrarSesion": {
                HttpSession misession = request.getSession(true);
                misession.invalidate();
                response.sendRedirect("index.jsp");
            }
            break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
