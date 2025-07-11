package lk.jiat.bank.web.servlet.customer;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.CustomerService;
import lk.jiat.bank.core.util.Encryption;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {

    @EJB
    private CustomerService customerBean;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        String encrypt = Encryption.encrypt(password);



        Customer customer = new Customer(name, email, phone, address, encrypt);
        customerBean.addUser(customer);

        resp.sendRedirect("index.jsp");
    }
}
