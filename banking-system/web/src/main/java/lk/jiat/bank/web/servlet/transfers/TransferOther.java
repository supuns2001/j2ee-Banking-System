package lk.jiat.bank.web.servlet.transfers;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.SecurityContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.AccountService;
import lk.jiat.bank.core.service.CustomerService;
import lk.jiat.bank.core.service.TransactionService;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/transferOther")
public class TransferOther extends HttpServlet {

    @EJB
    private TransactionService transactionService;

    @EJB
    private CustomerService customerService;

    @EJB
    private AccountService accountService;

    @Inject
    private SecurityContext securityContext;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Load to transfer code");
        Principal principal = request.getUserPrincipal();

        if (principal == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String email = principal.getName();
        Customer loggedInCustomer = customerService.getUserByEmail(email);

        if (loggedInCustomer == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=user_not_found");
            return;
        }

        System.out.println("Logged in customer: " + loggedInCustomer);

        List<BankAccount> myAccounts = accountService.getAccountsByCustomer(loggedInCustomer);
        List<BankAccount> otherAccounts = accountService.getAllAccounts()
                .stream()
                .filter(acc -> !acc.getCustomer().getId().equals(loggedInCustomer.getId()))
                .collect(Collectors.toList());

        System.out.println("my accounts is :"+myAccounts);
        System.out.println("other accounts is :"+otherAccounts);

        request.setAttribute("myAccounts", myAccounts);
        request.setAttribute("otherAccounts", otherAccounts);

        request.getRequestDispatcher("/transfer_other.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Principal principal = request.getUserPrincipal();

        if (principal == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String email = principal.getName();
        Customer customer = customerService.getUserByEmail(email);

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=user_not_found");
            return;
        }

        // Extract parameters from form
        String sourceAccountNumber = request.getParameter("sourceAccount");
        String targetAccountNumber = request.getParameter("targetAccount");
        String amountStr = request.getParameter("amount");

        if (sourceAccountNumber == null || targetAccountNumber == null || amountStr == null) {
            response.sendRedirect(request.getContextPath() + "/transfer_other.jsp?error=missing_fields");
            return;
        }

        BigDecimal amount;
        try {
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new NumberFormatException("Amount must be positive");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/transfer_other.jsp?error=invalid_amount");
            return;
        }

        // Check if source account belongs to the user
        List<BankAccount> myAccounts = accountService.getAccountsByCustomer(customer);
        boolean ownsSource = myAccounts.stream()
                .anyMatch(acc -> acc.getAccountNumber().equals(sourceAccountNumber));

        if (!ownsSource) {
            response.sendRedirect(request.getContextPath() + "/transfer_other.jsp?error=unauthorized_source_account");
            return;
        }

        try {
            // Perform the transfer
            transactionService.transferAccount(
                    sourceAccountNumber,
                    targetAccountNumber,
                    amount.doubleValue()
            );

            // Redirect on success
            response.sendRedirect(request.getContextPath() + "/customerDashboard");

        } catch (Exception e) {
            e.printStackTrace();
            // Show error
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response);  // Reload form with dropdowns
        }
    }

}
