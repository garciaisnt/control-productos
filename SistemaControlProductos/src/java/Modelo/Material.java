package Modelo;

import java.math.BigDecimal;

public class Material {

    int id;
    String Nombrematerial;
    BigDecimal Cantidad;
    int UnidadMedida;    

    public Material() {
       
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombrematerial() {
        return Nombrematerial;
    }

    public void setNombrematerial(String Nombrematerial) {
        this.Nombrematerial = Nombrematerial;
    }

    public BigDecimal getCantidad() {
        return Cantidad;
    }

    public void setCantidad(BigDecimal Cantidad) {
        this.Cantidad = Cantidad;
    }

    public int getUnidadMedida() {
        return UnidadMedida;
    }

    public void setUnidadMedida(int UnidadMedida) {
        this.UnidadMedida = UnidadMedida;
    }

}
