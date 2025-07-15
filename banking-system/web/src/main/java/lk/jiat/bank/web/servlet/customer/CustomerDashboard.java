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
import lk.jiat.bank.core.entities.Transaction;
import lk.jiat.bank.core.service.AccountService;
import lk.jiat.bank.core.service.CustomerService;
import lk.jiat.bank.core.service.TransactionService;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@WebServlet("/customerDashboard")
public class CustomerDashboard extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @EJB
    private AccountService accountService;

    @EJB
    private TransactionService transactionService;

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("customer dashboard servlet");

            Principal principal = request.getUserPrincipal();

            if (principal != null) {
                String email = principal.getName();

                Customer customer = customerService.getUserByEmail(email);

                if (customer != null) {
                    List<BankAccount> accounts = accountService.getAccountsByCustomer(customer);
                    List<Transaction> transactions = transactionService.getTransactionByAccountList(customer.getId());

                    request.setAttribute("customer", customer);
                    request.setAttribute("accounts", accounts);
                    request.setAttribute("transactions", transactions);
                    request.getRequestDispatcher("/customer_dashboard.jsp").forward(request, response);
                } else {
                    // Handle user not found
                    request.setAttribute("jakarta.servlet.error.message", "Customer not found with email: " + email);
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("jakarta.servlet.error.message", "An unexpected error occurred: " + e.getMessage());
            request.setAttribute("jakarta.servlet.error.exception", e);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
