package lk.jiat.bank.web.servlet.admin;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.mail.VerificationMail;
import lk.jiat.bank.core.provider.MailServiceProvider;
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
        try {
            // Send verification email
            VerificationMail mail = new VerificationMail(email, password);
            MailServiceProvider.getInstance().sendMail(mail);

            // Persist customer (this may trigger interceptor validation)
            customerBean.addUser(customer);

            resp.sendRedirect("admin_dashboard.jsp");

        } catch (Exception ex) {
            // Log and forward to error page
            ex.printStackTrace();
            req.setAttribute("jakarta.servlet.error.message", ex.getMessage());
            req.setAttribute("jakarta.servlet.error.exception", ex);
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
