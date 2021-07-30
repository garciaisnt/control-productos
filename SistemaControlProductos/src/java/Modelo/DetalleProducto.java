package Modelo;

import java.util.Date;

public class DetalleProducto {

    int id;
    String NomProducto;
    Date fecha;

    public DetalleProducto() {
    }

    public DetalleProducto(int id, String NomProducto, Date fecha) {
        this.id = id;
        this.NomProducto = NomProducto;
        this.fecha = fecha;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomProducto() {
        return NomProducto;
    }

    public void setNomProducto(String NomProducto) {
        this.NomProducto = NomProducto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}
