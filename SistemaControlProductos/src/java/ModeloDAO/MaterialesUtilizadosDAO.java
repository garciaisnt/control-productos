package ModeloDAO;

import Interfaz.MaterialesUtilizadosInterface;
import Modelo.DetalleProducto;
import Modelo.MaterialesUtilizados;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MaterialesUtilizadosDAO implements MaterialesUtilizadosInterface{

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int filaInsertada = 0;    
    
    @Override
    public int Insertar(MaterialesUtilizados _mat) {
        try {

            String sql = "INSERT INTO MaterialesUtilizados(IdMaterial, Cantidad, IdDetalleProductos) VALUES( ?, ?, ?);";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, _mat.getIdMaterial());
            ps.setBigDecimal(2, _mat.getCantidad());
            ps.setInt(3, _mat.getDetalleProducto());
            filaInsertada = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public List<MaterialesUtilizados> ListarPorIdDetalleProducto(int Id) {
        List<MaterialesUtilizados> detalleproductoList = new ArrayList<>();
        
        MaterialDAO _matDAO = new MaterialDAO();

        try {
            String sql = "select * from MaterialesUtilizados where IdDetalleProductos = ?;";

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, Id);
            rs = ps.executeQuery();

            while (rs.next()) {
                MaterialesUtilizados _matU = new MaterialesUtilizados();
                _matU.setId(rs.getInt("Id"));
                _matU.setMaterial(_matDAO.MaterialPorId(rs.getInt("IdMaterial")));
                _matU.setCantidad(rs.getBigDecimal("Cantidad"));
                _matU.setDetalleProducto(rs.getInt("IdDetalleProductos"));
                detalleproductoList.add(_matU);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return detalleproductoList;
    }
    
    
}
