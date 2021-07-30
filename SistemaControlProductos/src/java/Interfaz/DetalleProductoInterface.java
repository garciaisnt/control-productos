package Interfaz;

import Modelo.DetalleProducto;
import java.util.List;

public interface DetalleProductoInterface {
    public List<DetalleProducto> Listar();
    public DetalleProducto DetalleProductoPorId(int id);
    public int Insertar(DetalleProducto _dp);
    public int Modificar(DetalleProducto _dp);
    public int Eliminar(int id);
    
}
