<%@ page import="java.net.ConnectException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: 30407
  Date: 2024/5/30
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
</head>
<body>
<%
    //获取用户输入信息
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String password = request.getParameter("userpwd");
    String surepwd = request.getParameter("surepwd");

    //判断两次输入的密码是否相同
    if(surepwd.equals(password)){
        Connection con = null;  //数据库连接
        Statement sta = null;
        try{
            //连接jdbc
            Class.forName("com.mysql.jdbc.Driver");//加载MYSQL JDBC驱动程序
            System.out.println("Success loading Mysql Driver!");
        }catch (ClassNotFoundException e){
            System.out.print("Error loading Mysql Driver!");
            e.printStackTrace();
        }
        //建立数据库连接
        String url = "jdbc:mysql://localhost:3306/login_sql";
        //数据库账号
        String user="root";
        //数据库密码
        String upwd="root";
        try {
            con= DriverManager.getConnection(url,user,upwd);
            //创建发射器
            sta=con.createStatement();
            //创建sql语句
            ResultSet sql= sta.executeQuery("INSERT INTO login_user(username,password) VALUE(\"1\",\"1234\")");
            //发送sql语句并接收结果
            int count = sta.executeUpdate(sql);
            if (count>0){
                out.print("注册成功");
                out.print("<a href='logoin.jsp'>登录</a>");
            }
            else{
                out.print("注册失败");
            }
            //关闭资源
            sta.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    else {
        out.print("注册失败");
    }
    }
%>
</body>
</html>
