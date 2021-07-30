package Controlador;

import Modelo.DetalleProducto;
import ModeloDAO.DetalleProductoDAO;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DetalleProductoControlador extends HttpServlet {

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create(); //serializar a una respuesta json   

    DetalleProductoDAO dao = new DetalleProductoDAO();

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
            case "Listar": {
                respuestaJSON = this.gson.toJson(dao.Listar());
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "Agregar": {

                String nomProducto = request.getParameter("txtNombreProducto");
                Date Fecha = new Date(System.currentTimeMillis());
                int r = 0;

                try {
                    DetalleProducto _dp = new DetalleProducto();
                    _dp.setNomProducto(nomProducto);
                    _dp.setFecha(Fecha);

                    r = dao.Insertar(_dp);
                } catch (Exception e) {
                    System.out.println(e);
                }

                respuestaJSON = this.gson.toJson(r);
                out.print(respuestaJSON);
                out.flush();

            }

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
