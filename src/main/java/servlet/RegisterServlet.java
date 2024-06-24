package servlet;

import db.DataBase;
import model.usedata;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "RegisterServlet", urlPatterns = "/Register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);

        /* 编码设置 */
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        String username = req.getParameter("username");
        String pwd = req.getParameter("password");
        String tel = req.getParameter("tel");
        String gender = req.getParameter("gender");
        String mail_address = req.getParameter("mail_address");
        String datetime = req.getParameter("datetime");

        PrintWriter out = resp.getWriter();
//        out.println("用户："+username+"密码："+pwd+"手机号："+tel+gender+mail_address+datetime);

        try {
            DataBase db = new DataBase();

            //注册
            ArrayList<usedata> users = db.getallUsers();
            for(usedata user: users){
                if(username.equals(user.getUsername())){  //存在用户，需要重新注册
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('用户名已存在！请重新输入');");
                    out.println("location='register.jsp';");
                    out.println("</script>");
//                    resp.setHeader("Refresh", "url=user_exist.jsp");
//                    resp.sendRedirect("user_exist.jsp");
                    return;
                }
            }
            //可以注册 1.添加用户 2.添加积分
            gender = (gender.equals("male") ? "男" : "女");
            db.insertUser(username, pwd, tel, gender, mail_address, datetime);

            db.showUsers();
            db.close();  //记得关闭连接

            out.println("<script type=\"text/javascript\">");
            out.println("alert('注册成功！前往登录...');");
            out.println("location='login.jsp';");
            out.println("</script>");
//            resp.setHeader("Refresh", "3;url=login.jsp");
//            resp.sendRedirect("login.jsp");
//            resp.setHeader("Refresh", "url=register_success.jsp");
//            resp.sendRedirect("register_success.jsp");


        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        doPost(req, resp);
    }
}
