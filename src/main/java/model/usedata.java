package model;

public class usedata {
    private Integer id;
    private String username;
    private String password;
    private String tel;
    private String gender;
    private String avatar;
    private String mail_address;
    private String datetime;

    public usedata(int id, String username, String password, String tel, String gender, String avatar,
                   String mail_address, String datetime) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.tel = tel;
        this.gender = gender;
        this.avatar = avatar;
        this.mail_address = mail_address;
        this.datetime = datetime;
    }


    public Integer getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getTel() {
        return tel;
    }

    public String getGender() {
//        return gender.equals("male") ? "男" : "女" ;
        return gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public String getMail_address() {
        return mail_address;
    }

    public String getDatetime() {
        return datetime;
    }
}
