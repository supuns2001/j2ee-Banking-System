package lk.jiat.bank.web.servlet.customer;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.SecurityContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.AccountService;
import lk.jiat.bank.core.service.CustomerService;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@WebServlet("/customerDashboard")
public class CustomerDashboard extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @EJB
    private AccountService accountService;

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("customer dashboard servlet");
        // Get authenticated user's email
        Principal principal = request.getUserPrincipal();

        if (principal != null) {
            String email = principal.getName();

            // Get customer entity from service
            Customer customer = customerService.getUserByEmail(email);

            if (customer != null) {
                // Get accounts for this customer
                List<BankAccount> accounts = accountService.getAccountsByCustomer(customer);

                System.out.println("Accounts found: " + accounts.size());
                for (BankAccount acc : accounts) {
                    System.out.println("Account: " + acc.getAccountNumber() + ", Balance: " + acc.getBalance());
                }


                // Set attributes and forward to dashboard JSP
                request.setAttribute("customer", customer);
                request.setAttribute("accounts", accounts);
                request.getRequestDispatcher("/customer_dashboard.jsp").forward(request, response);
            } else {
                // Email found but no user in DB
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=user_not_found");
            }
        } else {
            // User not logged in
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
