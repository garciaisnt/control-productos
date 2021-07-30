package ModeloDAO;

import Interfaz.DetalleProductoInterface;
import Modelo.DetalleProducto;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetalleProductoDAO implements DetalleProductoInterface {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int filaInsertada;

    @Override
    public List<DetalleProducto> Listar() {
        List<DetalleProducto> detalleproductoList = new ArrayList<>();

        try {
            String sql = "select * from DetalleProductos;";

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                DetalleProducto _detalleproducto = new DetalleProducto();

                _detalleproducto.setId(rs.getInt("Id"));
                _detalleproducto.setNomProducto(rs.getString("NomProducto"));
                _detalleproducto.setFecha(rs.getDate("Fecha"));
                detalleproductoList.add(_detalleproducto);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return detalleproductoList;
    }

    @Override
    public int Insertar(DetalleProducto _dp) {
        try {

            String sql = "INSERT INTO DetalleProductos(NomProducto, Fecha) VALUES( ?, ?);";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, _dp.getNomProducto());
            ps.setDate(2, (Date) _dp.getFecha());
            filaInsertada = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public int Modificar(DetalleProducto _dp) {
        try {

            String sql = "UPDATE DetalleProductos SET NomProducto = ?, Fecha = ? WHERE Id = ?";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, _dp.getNomProducto());
            ps.setDate(2, (Date) _dp.getFecha());
            filaInsertada = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public int Eliminar(int id) {
        try {

            String sql = "DELETE FROM DetalleProductos WHERE Id = ?;";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);
            filaInsertada = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public DetalleProducto DetalleProductoPorId(int id) {
       DetalleProducto _detalleproducto = new DetalleProducto();

        try {
            String sql = "select * from DetalleProductos;";

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {  
                _detalleproducto.setId(rs.getInt("Id"));
                _detalleproducto.setNomProducto(rs.getString("NomProducto"));
                _detalleproducto.setFecha(rs.getDate("Fecha"));                
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return _detalleproducto;
    }

}
