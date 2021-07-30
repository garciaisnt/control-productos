package Interfaz;

import Modelo.Material;
import java.util.List;

public interface MaterialInterface {
    public List<Material>Listar();
    public Material MaterialPorId(int id);
    public int Insertar(Material _m);
    public int Modificar(Material _m);
    public int Eliminar(int id);
}
