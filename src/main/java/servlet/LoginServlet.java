package servlet;

import db.DataBase;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "LoginServlet", urlPatterns = "/Login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);

        /* 编码设置 */
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        String username = req.getParameter("username");
        String pwd = req.getParameter("password");
        PrintWriter out = resp.getWriter();
//        out.println("用户："+username+"密码："+pwd);

        try {
            DataBase dataBase = new DataBase();
            usedata usedata = dataBase.login(username,pwd);

            if (usedata == null){
//                    System.out.println("该用户不存在!/密码输入错误！)"+"<a href=\"http://localhost/web_demo_war/login.jsp\">返回登录</a>");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('该用户不存在或密码输入错误！');");
                out.println("location='login.jsp';");
                out.println("</script>");
            } else {
//                System.out.println("欢迎登录~"+usedata.getUsername());
                HttpSession session = req.getSession();
                session.setAttribute("LoginUserName", username);
                try {
                    session.setAttribute("LoginUserMessage", dataBase.getUser(username));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                resp.setHeader("Refresh", "3;url=index_1.jsp");
                resp.sendRedirect("index_1.jsp");
            }

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        /*
        * 在前端与servlet交互时，如超链接href，url等，常遇到此bug
        * 原因：服务器在访问servlet会优先访问doGet方法，出现问题是servlet中doGet缺失。
        * 解决办法：检查servlet，修改doPost为doGet方法，或者单独写一个doGet方法指向doPost方法，*/
        // 防止出现405报错
        doPost(req,resp);
    }
}
