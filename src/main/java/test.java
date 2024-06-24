import db.DataBase;
import model.*;

import java.util.ArrayList;

public class test {
    public static void main(String[] args) throws Exception {
        DataBase db = new DataBase();
//        db.insertUser("ciao", "1234567", "18339601107",
//                "male","23", "3040793707@qq.com","2023-10-19");
//        db.showUsers();

//        ArrayList<usedata> ud = db.getUsers();
//        System.out.println(ud.size());
//        for (usedata each:ud){
//            System.out.println(each.getId()+each.getUsername());
//        }
//        db.close();

//        usedata ud = db.getUser("ciao");
//        System.out.println(ud.getId()+ud.getUsername());
        usedata ud = db.login("li","1234567");
        System.out.println(ud);
        if (ud == null){
            System.out.println("该用户不存在或密码错误！");
        }
        else {
            System.out.println("欢迎登录,"+ud.getUsername());
        }
    }
}
