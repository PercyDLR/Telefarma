package com.example.telefarma.daos;

import java.sql.*;
import java.util.ArrayList;
import com.example.telefarma.beans.BFarmaciasAdmin;


import java.sql.*;
import java.util.ArrayList;

public class PharmacyAdminDao {

    String user = "root";
    String pass = "root";
    String url = "jdbc:mysql://localhost:3306/telefarma";

    private void agregarClase(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<String> listarDistritosLimite(int paginaDistritoAdmin, String busqueda, int limite) {

        ArrayList<String> listaDistritosPagina = new ArrayList<>();

        this.agregarClase();

        /*OBTENGO TODOS LOS DISTRITOS CON FARMACIAS QUE COINCIDAN CON LA BUSQUEDA*/
        String sqlObtenerDistritos = "select f.District_name from telefarma.pharmacy f \n"+
                "where lower(f.name) like '%"+ busqueda +"%'\n" +
                "group by District_name \n" +
                "order by count(*) desc \n"+
                "limit " + paginaDistritoAdmin*limite + "," + limite + ";";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sqlObtenerDistritos)) {

            while (rs.next()) {
                listaDistritosPagina.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaDistritosPagina;

    }

    public ArrayList<BFarmaciasAdmin> listarFarmaciasAdminPorDistrito(String distrito, String busqueda) {

        this.agregarClase();

        ArrayList<BFarmaciasAdmin> listaFarmaciasAdminPorDistrito = new ArrayList<>();

        /*OBTENGO LAS FARMACIAS DE LOS DISTRITOS QUE SE MOSTRARAN POR PAGINA*/
        String sqlObtenerFarmacias = "select name, address, mail, RUC, District_name, isBanned, idPharmacy from telefarma.pharmacy\n" +
                "where lower(name) like '%"+ busqueda +"%' and District_name = '" + distrito + "';";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sqlObtenerFarmacias)) {

            while (rs.next()) {
                BFarmaciasAdmin bFarmaciasAdmin = new BFarmaciasAdmin();
                bFarmaciasAdmin.setNombreFarmacia(rs.getString(1));
                bFarmaciasAdmin.setDireccionFarmacia(rs.getString(2));
                bFarmaciasAdmin.setEmailFarmacia(rs.getString(3));
                bFarmaciasAdmin.setRUCFarmacia(rs.getString(4));
                bFarmaciasAdmin.setDistritoFarmacia(rs.getString(5));
                bFarmaciasAdmin.setIsBanned(rs.getByte(6));
                bFarmaciasAdmin.setIdPharmacy(rs.getInt(7));
                listaFarmaciasAdminPorDistrito.add(bFarmaciasAdmin);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaFarmaciasAdminPorDistrito;
    }

    public ArrayList<String> listarDistritosEnSistema() {

        this.agregarClase();

        ArrayList<String> listaDistritos = new ArrayList<>();

        /*OBTENGO LAS FARMACIAS DE LOS DISTRITOS QUE SE MOSTRARAN POR PAGINA*/
        String sqlObtenerFarmacias = "select * from district;";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sqlObtenerFarmacias)) {

            while (rs.next()) {
                listaDistritos.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaDistritos;
    }

    public boolean validarCorreoFarmacia(String correo) {

        boolean correoUnico = true;

        this.agregarClase();

        String sql = "select idClient as 'id',mail,'client' as 'tipo' from telefarma.client\n" +
                "where mail = ?\n" +
                "union\n" +
                "select idPharmacy,mail,'pharmacy' from telefarma.pharmacy\n" +
                "where mail = ?\n" +
                "union\n" +
                "select idAdmin,mail,'admin' from telefarma.administrator\n" +
                "where mail = ?;";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setString(1,correo);
            pstmt.setString(2,correo);
            pstmt.setString(3,correo);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    if (rs.getString(2).equals(correo)) {
                        correoUnico = false;
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return correoUnico;
    }

    public boolean validarRUCFarmacia(String ruc) {

        boolean rucUnico = true;

        this.agregarClase();

        String sql = "select idPharmacy,RUC from pharmacy\n" +
                "where RUC = ?;";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setString(1,ruc);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    rucUnico = false;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rucUnico;
    }

    public String registrarFarmacia(String ruc, String nombre, String correo, String direccion, String distrito) {

        this.agregarClase();

        String sql = "insert into telefarma.pharmacy (RUC,name,mail,address,District_name)\n" +
                "values(?,?,?,?,?);";

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setString(1, ruc);
            pstmt.setString(2, nombre);
            pstmt.setString(3, correo);
            pstmt.setString(4, direccion);
            pstmt.setString(5, distrito);
            System.out.println(pstmt);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return "ne";
        }

        return "e";

    }

    public boolean conPedidosPendientes(int idPharmacy){

        boolean pendiente = false;

        this.agregarClase();

        String sql = "select o.idOrder,o.status from orders o\n" +
                "inner join orderdetails od on (od.idOrder=o.idOrder)\n" +
                "inner join product p on (p.idProduct=od.idProduct)\n" +
                "where o.status='Pendiente' and p.idPharmacy="+idPharmacy+"\n" +
                "group by o.idOrder;";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if(rs.next()){
                pendiente = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendiente;
    }

    public void banearFarmacia(int id, String razon){
        String sql = "update pharmacy set isBanned=1, banReason='"+razon+"'\n" +
                "where idPharmacy="+id+";";

        try (Connection conn = DriverManager.getConnection(url,user,pass);
             Statement stmt = conn.createStatement();){

            stmt.executeUpdate(sql);

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
