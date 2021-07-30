package Controlador;

import Modelo.DetalleProducto;
import Modelo.MaterialesUtilizados;
import ModeloDAO.MaterialesUtilizadosDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MaterialesUtilizadosControlador extends HttpServlet {

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create(); //serializar a una respuesta json 

    MaterialesUtilizadosDAO dao = new MaterialesUtilizadosDAO();

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
            case "Agregar": {

                int idMaterial = Integer.parseInt(request.getParameter("txtIdMaterial"));
                BigDecimal Cantidad = new BigDecimal((request.getParameter("txtCantidad")));
                int idDetalleProductos = Integer.parseInt(request.getParameter("txtId"));

                int r = 0;

                MaterialesUtilizados _mU = new MaterialesUtilizados();
                _mU.setIdMaterial(idMaterial);
                _mU.setCantidad(Cantidad);
                _mU.setDetalleProducto(idDetalleProductos);

                r = dao.Insertar(_mU);

                respuestaJSON = this.gson.toJson(r);
                out.print(respuestaJSON);
                out.flush();

            }
            case "ListarPorIdDetalleProducto":{
                int id = Integer.parseInt(request.getParameter("txtId")); 
                respuestaJSON = this.gson.toJson(dao.ListarPorIdDetalleProducto(id));
                out.print(respuestaJSON);
                out.flush();
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
