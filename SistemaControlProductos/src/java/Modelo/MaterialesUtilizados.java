package Modelo;

import java.math.BigDecimal;

public class MaterialesUtilizados {
    
    //Id, IdMaterial, Cantidad    
    int Id;
    int IdMaterial;
    BigDecimal Cantidad;
    int DetalleProducto;    
    Material _material;

    public Material getMaterial() {
        return _material;
    }

    public void setMaterial(Material _material) {
        this._material = _material;
    }

    public int getDetalleProducto() {
        return DetalleProducto;
    }

    public void setDetalleProducto(int DetalleProducto) {
        this.DetalleProducto = DetalleProducto;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getIdMaterial() {
        return IdMaterial;
    }

    public void setIdMaterial(int IdMaterial) {
        this.IdMaterial = IdMaterial;
    }

    public BigDecimal getCantidad() {
        return Cantidad;
    }

    public void setCantidad(BigDecimal Cantidad) {
        this.Cantidad = Cantidad;
    }
    
}
