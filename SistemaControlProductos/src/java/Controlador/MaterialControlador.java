package Controlador;

import Modelo.Material;
import ModeloDAO.MaterialDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MaterialControlador extends HttpServlet {

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create(); //serializar a una respuesta json

    MaterialDAO dao = new MaterialDAO();

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
            case "ConsultarId": {
                int Id = Integer.parseInt(request.getParameter("txtId"));               
                respuestaJSON = this.gson.toJson(dao.MaterialPorId(Id));
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "Agregar": {
                String NomMaterial = request.getParameter("txtNomMaterial");
                BigDecimal Cantidad = new BigDecimal((request.getParameter("txtCantidad")));
                int UniMedida = Integer.parseInt(request.getParameter("txtUniMedida"));

                Material _m = new Material();

                _m.setNombrematerial(NomMaterial);
                _m.setCantidad(Cantidad);
                _m.setUnidadMedida(UniMedida);

                try {
                    int r = dao.Insertar(_m);

                respuestaJSON = this.gson.toJson(r);
                out.print(respuestaJSON);
                out.flush();
                } catch (Exception e) {
                    System.out.println(e);
                }

            }
            break;           
            case "Modificar": {
                int Id = Integer.parseInt(request.getParameter("txtId"));
                String NomMaterial = request.getParameter("txtNomMaterial");
                BigDecimal Cantidad = new BigDecimal((request.getParameter("txtCantidad")));
                int UniMedida = Integer.parseInt(request.getParameter("txtUniMedida"));

                Material _m = new Material();

                _m.setNombrematerial(NomMaterial);
                _m.setCantidad(Cantidad);
                _m.setUnidadMedida(UniMedida);
                _m.setId(Id);

                int r = dao.Modificar(_m);

                respuestaJSON = this.gson.toJson(r);
                out.print(respuestaJSON);
                out.flush();
            }
            break;
            case "Eliminar": {
                int Id = Integer.parseInt(request.getParameter("txtId"));               

                respuestaJSON = this.gson.toJson(dao.Eliminar(Id));
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
