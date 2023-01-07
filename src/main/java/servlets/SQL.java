package servlets;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class SQL {

    public SQL() {

    }

    private static Connection getCon() throws ClassNotFoundException, SQLException {
        Connection con;
        String myDriver = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/cabinet_avocatura";
        String username = "SiteBD";
        String password = "SiteBD";
        Class.forName(myDriver);
        con = DriverManager.getConnection(url, username, password);
        return con;
    }

    public static List<Map<String,Object>> Ex06b() throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex6b()}");
        return getRows(st.executeQuery(),con);
    }

    public static List<Map<String,Object>> Ex06a(String functia,String anC) throws SQLException, ClassNotFoundException {
        if(functia.equals("") || anC.equals(""))
            return null;
        int an=Integer.parseInt(anC);
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex6a(?,?)}");
        st.setInt(1,an);
        st.setString(2,functia);
        return getRows(st.executeQuery(),con);
    }
    public static List<Map<String,Object>> Ex05b() throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex5b()}");
        return getRows(st.executeQuery(),con);
    }
    public static List<Map<String,Object>> Ex05a() throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex5a()}");
        return getRows(st.executeQuery(),con);
    }

    public static List<Map<String,Object>> Ex04b(String idAvC) throws SQLException, ClassNotFoundException {
        if(idAvC.equals(""))
            return null;
        int idAv=Integer.parseInt(idAvC);
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex4b(?)}");
        st.setInt(1,idAv);
        return getRows(st.executeQuery(),con);
    }

    public static List<Map<String,Object>> Ex04a(String functia,String anC) throws SQLException, ClassNotFoundException {
        if(functia.equals("") || anC.equals(""))
            return null;
        int an=Integer.parseInt(anC);
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex4a(?,?)}");
        st.setInt(1,an);
        st.setString(2,functia);
        return getRows(st.executeQuery(),con);
    }

    public static List<Map<String,Object>> Ex03b(String litera) throws SQLException, ClassNotFoundException {
        if(litera.equals("") || litera.length()>1)
            return null;
        Connection con = getCon();
        CallableStatement st=con.prepareCall("{CALL Ex3b(?)}");
        st.setString(1,litera);
        return getRows(st.executeQuery(),con);
    }

    public static List<Map<String,Object>> Ex03a(String lunaC,String anC,String onorarMinC,String onorarMaxC) throws SQLException, ClassNotFoundException {
        if(anC.equals("") || onorarMinC.equals("") || onorarMaxC.equals(""))
            return null;
        int luna=Integer.parseInt(lunaC);
        int an=Integer.parseInt(anC);
        int onorarMin=Integer.parseInt(onorarMinC);
        int onorarMax=Integer.parseInt(onorarMaxC);
        Connection con = getCon();
        List<Map<String,Object>> rows=null;
        CallableStatement st=con.prepareCall("{CALL Ex3a(?,?,?,?)}");
        st.setInt(1,luna);
        st.setInt(2,an);
        st.setInt(3,onorarMin);
        st.setInt(4,onorarMax);
        return getRows(st.executeQuery(),con);
    }

    public static List<Map<String,Object>> getRows(ResultSet rs,Connection con) throws SQLException {
        List<Map<String,Object>> rows=new ArrayList<>();;
        ResultSetMetaData metaData =rs.getMetaData();
        int columnCount=metaData.getColumnCount();
        while(rs.next()){
            Map<String,Object> columns= new LinkedHashMap<>();
            for (int i = 1; i <= columnCount; i++)
                columns.put(metaData.getColumnLabel(i), rs.getObject(i));
            rows.add(columns);
        }
        rs.close();
        con.close();
        return rows;
    }

    public static String getJob(String email) throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        PreparedStatement st = con.prepareStatement("SELECT functie FROM Contract_m JOIN Persoana ON id_angajat=id_p WHERE email='"+email+"'");
        ResultSet rs = st.executeQuery();
        if(rs.next()){
            String ret=rs.getString(1);
            con.close();
            return ret;
        }
        con.close();
        return null;
    }

    public static String getEmailAndTimeLeftByRememberMe(String selector, String validator) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        Connection con = getCon();
        Timestamp data=null;
        String email=null;
        if(selector!=null && validator!=null){
            PreparedStatement st = con.prepareStatement("SELECT email,data FROM Persoana JOIN Cookies ON Persoana.id_p=Cookies.id_p WHERE selector='"+selector+"' AND validator='"+Hash.genHash(validator)+"'");
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                email=rs.getString(1);
                data=rs.getTimestamp(2);
            }else{
                con.close();
                return null;
            }
        }
        long timpRamas=0;
        if(data!=null){
            timpRamas = data.getTime()+3600000-System.currentTimeMillis();
            email+=","+timpRamas;
        }
        con.close();
        return email;
    }

    public static boolean checkAccountLogInGood(String email, String password) throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        PreparedStatement st = con.prepareStatement("SELECT COUNT(*) FROM Conturi JOIN Persoana ON Conturi.id_p=Persoana.id_p WHERE email='"+email+"' AND parola='"+password+"'");
        ResultSet rs = st.executeQuery();
        boolean isGood=false;
        if(rs.next()){
            isGood=rs.getInt(1) > 0;
        }
        con.close();
        return isGood;
    }

    public static void insertRememberMe(String email, String selector, String hashedValidator) throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        int id_p;
        PreparedStatement st = con.prepareStatement("SELECT Persoana.id_p FROM Persoana JOIN Conturi ON Persoana.id_p=Conturi.id_p WHERE email='" + email + "'");
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            id_p = rs.getInt(1);
            st = con.prepareStatement("INSERT INTO Cookies(id_p,selector,validator,data) VALUES('" + id_p + "','" + selector + "','" + hashedValidator + "',NOW())");
            st.executeUpdate();
        }
        con.close();
    }

    public static void insertIntoConturi(String email, String parola) throws SQLException, ClassNotFoundException {
        Connection con = getCon();
        int id_p;
        PreparedStatement st = con.prepareStatement("SELECT id_p FROM Persoana WHERE email='" + email + "'");
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            id_p = rs.getInt(1);
            st = con.prepareStatement("INSERT INTO CONTURI(id_p,parola) VALUES('" + id_p + "','" + parola + "')");
            st.executeUpdate();
        }
        con.close();
    }

    public static boolean checkEmailExists(String email) throws SQLException, ClassNotFoundException {
        boolean exista = true;
        Connection con = getCon();
        PreparedStatement st = con.prepareStatement("SELECT COUNT(*) FROM Persoana WHERE email='" + email + "'");
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            if (rs.getInt(1) == 0)
                exista = false;
        }
        con.close();
        return exista;
    }

    public static boolean checkAccountExists(String email) throws SQLException, ClassNotFoundException {
        boolean exista = true;
        Connection con = getCon();
        PreparedStatement st = con.prepareStatement("SELECT COUNT(*) FROM Persoana,Conturi WHERE email='" + email + "' AND Persoana.id_p=Conturi.id_p");
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            if (rs.getInt(1) == 0)
                exista = false;
        }
        con.close();
        return exista;
    }

    public static boolean checkSelectorExists(String selector) throws SQLException, ClassNotFoundException {
        boolean exista = true;
        Connection con = getCon();
        PreparedStatement st = con.prepareStatement("SELECT COUNT(*) FROM Cookies WHERE selector='" + selector + "'");
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            if (rs.getInt(1) == 0)
                exista = false;
        }
        con.close();
        return exista;
    }

}
