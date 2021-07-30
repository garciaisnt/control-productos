package ModeloDAO;

import Interfaz.MaterialInterface;
import Modelo.Material;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO implements MaterialInterface {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int filaInsertada;

    @Override
    public List<Material> Listar() {
        List<Material> materialesList = new ArrayList<>();

        try {
            String sql = "select * from Materiales;";

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Material _material = new Material();

                _material.setId(rs.getInt("Id"));
                _material.setNombrematerial(rs.getString("NomMaterial"));
                _material.setCantidad(rs.getBigDecimal("Cantidad"));
                _material.setUnidadMedida(rs.getInt("UnidadMedida"));
                materialesList.add(_material);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return materialesList;
    }

    @Override
    public Material MaterialPorId(int id) {
        Material _material = new Material();

        try {
            
            String sql = "select * from Materiales where Id = ?;";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                _material.setId(rs.getInt("Id"));
                _material.setNombrematerial(rs.getString("NomMaterial"));
                _material.setCantidad(rs.getBigDecimal("Cantidad"));
                _material.setUnidadMedida(rs.getInt("UnidadMedida"));
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return _material;
    }

    @Override
    public int Insertar(Material _m) {
        try {
                        
            String sql = "INSERT INTO Materiales(NomMaterial, Cantidad, UnidadMedida) VALUES( ?, ?, ?);";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, _m.getNombrematerial());
            ps.setBigDecimal(2, _m.getCantidad());
            ps.setInt(3, _m.getUnidadMedida());
            filaInsertada = ps.executeUpdate();    
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public int Modificar(Material _m) {
        try {
            
            String sql = "UPDATE Materiales SET NomMaterial = ?, Cantidad = ?, UnidadMedida = ? WHERE Id = ?";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, _m.getNombrematerial());
            ps.setBigDecimal(2, _m.getCantidad());
            ps.setInt(3, _m.getUnidadMedida());
            ps.setInt(4, _m.getId());
            filaInsertada = ps.executeUpdate(); 

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public int Eliminar(int id) {
        try {

            String sql = "DELETE FROM Materiales WHERE Id = ?;";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);
            filaInsertada = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

}
