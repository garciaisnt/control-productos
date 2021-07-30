package ModeloDAO;

import Interfaz.UsuarioInterface;
import Modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO implements UsuarioInterface {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    Statement stmt;
    ResultSet rs;
    int filaInsertada;
    

    @Override
    public List<Usuario> Listar() {

        List<Usuario> usuariosList = new ArrayList<>();

        try {

            String sql = "select * from Usuarios";

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                Usuario _usuario = new Usuario();

                _usuario.setId(rs.getInt("Id"));
                _usuario.setNombres(rs.getString("Nombres"));
                _usuario.setApellidos(rs.getString("Apellidos"));
                _usuario.setUsuario(rs.getString("Usuario"));
                _usuario.setRol(rs.getInt("Rol"));
                usuariosList.add(_usuario);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return usuariosList;
    }

    @Override
    public Usuario UsuarioPorId(int id) {
        Usuario _usuario = new Usuario();

        try {

            String sql = "select * from Usuarios where Id = ?;";

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                _usuario.setId(rs.getInt("Id"));
                _usuario.setNombres(rs.getString("Nombres"));
                _usuario.setApellidos(rs.getString("Apellidos"));
                _usuario.setUsuario(rs.getString("Usuario"));                
                _usuario.setRol(rs.getInt("Rol"));
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return _usuario;
    }

    @Override
    public int Insertar(Usuario _u) {

        try {
            
            String sql = String.format("INSERT INTO Usuarios(Nombres, Apellidos, Usuario, Clave, Rol) VALUES( '%s','%s','%s', HASHBYTES('MD5', '%s'), %d);",
                    _u.getNombres(), 
                    _u.getApellidos(),
                    _u.getUsuario(), 
                    _u.getClave(), 
                    _u.getRol());                   

            con = cn.getConnection();
            stmt = con.createStatement();
            filaInsertada = stmt.executeUpdate(sql);

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;

    }

    @Override
    public int Modificar(Usuario _u) {
        try {
            
            String sql = String.format("UPDATE Usuarios SET Nombres = '%s', Apellidos = '%s', Usuario = '%s', Clave = HashBytes('MD5', '%s' ), Rol = '%d' WHERE Id = '%d';",
                    _u.getNombres(), 
                    _u.getApellidos(),
                    _u.getUsuario(), 
                    _u.getClave(), 
                    _u.getRol(),
                    _u.getId());                   

            con = cn.getConnection();
            stmt = con.createStatement();
            filaInsertada = stmt.executeUpdate(sql);

        } catch (SQLException e) {
            System.out.println(e);
        }
        return filaInsertada;
    }

    @Override
    public int Eliminar(int id) {
        try {

            String sql = "DELETE FROM Usuarios WHERE Id = ?;";
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
    public Usuario ValidarLogin(Usuario _u) {

        Usuario _usuarioRetornar = new Usuario();
        try {

            String sql = "SELECT * FROM Usuarios WHERE Usuario = '" + _u.getUsuario() + "' AND Clave = HashBytes('MD5', '" + _u.getClave() + "');";

            con = cn.getConnection();
            stmt = con.createStatement();            
            rs = stmt.executeQuery(sql);

            if (rs.next()) {
                _usuarioRetornar.setId(rs.getInt("Id"));
                _usuarioRetornar.setNombres(rs.getString("Nombres"));
                _usuarioRetornar.setApellidos(rs.getString("Apellidos"));
                _usuarioRetornar.setUsuario(rs.getString("Usuario"));
                _usuarioRetornar.setRol(rs.getInt("Rol"));
            }
            return _usuarioRetornar;

        } catch (SQLException e) {
            System.out.println(e);
        }
        return _usuarioRetornar;

    }

}
