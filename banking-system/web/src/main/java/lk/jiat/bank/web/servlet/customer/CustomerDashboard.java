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
        System.out.println("customer dashboard servlet");

        Principal principal = request.getUserPrincipal();

        if (principal != null) {
            String email = principal.getName();

            Customer customer = customerService.getUserByEmail(email);

            if (customer != null) {
                // Get accounts
                List<BankAccount> accounts = accountService.getAccountsByCustomer(customer);

                System.out.println("Accounts found: " + accounts.size());
                for (BankAccount acc : accounts) {
                    System.out.println("Account: " + acc.getAccountNumber() + ", Balance: " + acc.getBalance());
                }

                // Get transactions for customer
                List<Transaction> transactions = transactionService.getTransactionByAccountList(customer.getId());
                System.out.println("Transactions found: " + transactions.size());

                // Set attributes and forward to JSP
                request.setAttribute("customer", customer);
                request.setAttribute("accounts", accounts);
                request.setAttribute("transactions", transactions);
                request.getRequestDispatcher("/customer_dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=user_not_found");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
