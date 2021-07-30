package ModeloDAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
     Connection con;
    
    public Connection getConnection(){
        try{
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=ControlProductosDS;","sa","123");
        }catch(Exception e){
            
        }
        return con;
    }
}
