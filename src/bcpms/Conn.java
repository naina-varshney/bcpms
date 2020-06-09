/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bcpms;

import java.sql.Connection;
import java.sql.DriverManager;


public class Conn {

    public Connection con;

    public Conn() {
    	//edit the database configuration variables in the production environment.
    	String username = "root";
    	String password = "root";
    	String hostname = "localhost";
    	String dbport = "3306";
    	
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://"+hostname+":"+dbport+"/bcpms?characterEncoding=utf8&useConfigs=maxPerformance",username,password);
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
public static void main(String args[]){
    new Conn();
}
}
