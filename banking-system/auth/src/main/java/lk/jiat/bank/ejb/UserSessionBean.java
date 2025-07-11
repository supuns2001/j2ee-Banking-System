package lk.jiat.bank.ejb;

import jakarta.ejb.Stateless;

@Stateless
public class UserSessionBean {
    public String login(String username, String password) {
        // logic
        return "success";
    }
}
