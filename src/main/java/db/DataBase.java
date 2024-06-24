package db;

import model.*;

import java.sql.*;
import java.util.ArrayList;

public class DataBase {
    public Connection connect = null;
    public DataBase() throws ClassNotFoundException{
        try {
            /* 注册驱动——加载MYSQL JDBC驱动程序 */
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Success loading Mysql Driver!");
        } catch (Exception e) {
            System.out.print("Error loading Mysql Driver!");
            e.printStackTrace();
        }
        try {
            connect = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/web-demo?serverTimezone=GMT%2B8",
                    "root", "klkkllkkklll0");
            // 连接URL为 jdbc:mysql//服务器地址/数据库名 ，后面的2个参数分别是登陆用户名和密码

            System.out.println(connect);
            System.out.println("Success connect Mysql server!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() throws SQLException {
        System.out.println("Close the SQL!");
        connect.close();
    }

    // 注册时添加数据
    public void insertUser(String username, String password, String tel, String gender,
                           String mail_address, String datetime) throws SQLException {
        PreparedStatement prep = connect.prepareStatement("INSERT INTO login (username, password, tel, gender, mail_address, datetime) VALUES (?,?,?,?,?,?)");
        prep.setString(1, username);
        prep.setString(2, password);
        prep.setString(3, tel);
        prep.setString(4, gender);
        prep.setString(5, mail_address);
        prep.setString(6, datetime);

        prep.execute();
    }
    public void deleteUser(String username) throws SQLException {
        PreparedStatement prep = connect.prepareStatement("delete from login where username=?");
        prep.setString(1, username);
        prep.execute();
    }
    // 告诉用户的id
    public ArrayList<usedata> getallUsers() throws SQLException{
        ArrayList<usedata> userList = new ArrayList<usedata>();
        PreparedStatement prep = connect.prepareStatement("select * from login" );
        prep.execute();
        ResultSet resultSet = prep.executeQuery();
        while(resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("username");
            String pwd = resultSet.getString("password");
            String tel = resultSet.getString("tel");
            String gender = resultSet.getString("gender");
            String avatar = resultSet.getString("avatar");
            String mail_address = resultSet.getString("mail_address");
            String datetime = resultSet.getString("datetime");
            userList.add(new usedata(id, name, pwd, tel, gender, avatar, mail_address, datetime));
        }
        return userList;
    }
    public void showUsers() throws SQLException {
        PreparedStatement prep = connect.prepareStatement("select * from login" );
        prep.execute();
        ResultSet resultSet = prep.executeQuery();
        System.out.println("username  password  tel  gender  avatar  mail_address  datetime");
        while(resultSet.next()) {
            String name = resultSet.getString("username");
            String pwd = resultSet.getString("password");
            String tel = resultSet.getString("tel");
            String gender = resultSet.getString("gender");
            String avatar = resultSet.getString("avatar");
            String mail_address = resultSet.getString("mail_address");
            String datetime = resultSet.getString("datetime");
            System.out.println(name+"  "+pwd+"  "+tel+"  "+gender+"  "+avatar+"  "+mail_address+"  "+datetime);
        }
    }

    public usedata getUser(String username) throws SQLException{
        // 准备一个带有参数的 SQL 查询语句
        PreparedStatement prep = connect.prepareStatement("select * from login where username=?" );
        // 设置查询语句中的参数
        prep.setString(1,username);
        // 如果查询结果集中有下一行数据
        ResultSet resultSet = prep.executeQuery();
        if(resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("username");
            String pwd = resultSet.getString("password");
            String tel = resultSet.getString("tel");
            String gender = resultSet.getString("gender");
            String avatar = resultSet.getString("avatar");
            String mail_address = resultSet.getString("mail_address");
            String datetime = resultSet.getString("datetime");
            return new usedata(id, name, pwd, tel, gender, avatar, mail_address, datetime);
        }
        return null;
    }

    public usedata login(String username, String pwd) throws SQLException{
        PreparedStatement prep = connect.prepareStatement("select login.password from login where username=?");
        prep.setString(1,username);
        ResultSet resultSet=prep.executeQuery();
        if(resultSet.next()){
            String my_pwd = resultSet.getString("password");
            if(pwd.equals(my_pwd)){
                return getUser(username);
            }
            else
                return null;
        }
        return null;
    }

}
