package Interfaz;

import Modelo.MaterialesUtilizados;
import java.util.List;


public interface MaterialesUtilizadosInterface {
    
   public int Insertar(MaterialesUtilizados _mat);
   public List<MaterialesUtilizados> ListarPorIdDetalleProducto(int Id);
    
}
