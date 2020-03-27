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
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bcpms?characterEncoding=utf8&useConfigs=maxPerformance","root","root");
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
public static void main(String args[]){
    new Conn();
}
}
