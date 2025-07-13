package lk.jiat.bank.web.servlet.transfers;

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
import lk.jiat.bank.core.service.TransactionService;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;

@WebServlet("/transferOwn")
public class TransferOwn extends HttpServlet {
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

        Principal principal = request.getUserPrincipal();
        if (principal == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String email = principal.getName();
        Customer customer = customerService.getUserByEmail(email);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=customer_not_found");
            return;
        }

        List<BankAccount> myAccounts = accountService.getAccountsByCustomer(customer);
        request.setAttribute("myAccounts", myAccounts);

        request.getRequestDispatcher("/transfer_own.jsp").forward(request, response);
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
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=customer_not_found");
            return;
        }

        String sourceAccountNumber = request.getParameter("sourceAccount");
        String targetAccountNumber = request.getParameter("targetAccount");
        String amountStr = request.getParameter("amount");

        if (sourceAccountNumber == null || targetAccountNumber == null || amountStr == null) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            doGet(request, response);
            return;
        }

        if (sourceAccountNumber.equals(targetAccountNumber)) {
            request.setAttribute("errorMessage", "Source and target accounts must be different.");
            doGet(request, response);
            return;
        }

        BigDecimal amount;
        try {
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new NumberFormatException("Amount must be positive");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid transfer amount.");
            doGet(request, response);
            return;
        }

        List<BankAccount> myAccounts = accountService.getAccountsByCustomer(customer);

        boolean validSource = myAccounts.stream()
                .anyMatch(acc -> acc.getAccountNumber().equals(sourceAccountNumber));
        boolean validTarget = myAccounts.stream()
                .anyMatch(acc -> acc.getAccountNumber().equals(targetAccountNumber));

        if (!validSource || !validTarget) {
            request.setAttribute("errorMessage", "Invalid account selection.");
            doGet(request, response);
            return;
        }

        try {
            transactionService.transferAccount(
                    sourceAccountNumber,
                    targetAccountNumber,
                    amount.doubleValue()
            );
            response.sendRedirect(request.getContextPath() + "/customerDashboard");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Transfer failed: " + e.getMessage());
            doGet(request, response);
        }
    }


}
