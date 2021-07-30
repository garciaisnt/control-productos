package Interfaz;

import java.util.List;
import Modelo.Usuario;
import java.sql.SQLException;

public interface UsuarioInterface {    
    public List<Usuario> Listar();
    public Usuario UsuarioPorId(int id);
    public int Insertar(Usuario _u);    
    public int Modificar(Usuario _u);
    public int Eliminar(int id);  
    public Usuario ValidarLogin(Usuario _u);    
}
