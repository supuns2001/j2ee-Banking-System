package lk.jiat.bank.web.servlet.account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bank.core.entities.AccountType;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.AccountService;
import lk.jiat.bank.core.service.CustomerService;

import javax.naming.InitialContext;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "CreateAccountServlet", urlPatterns = {"/CreateAccountServlet"})
public class CreateAccountServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            InitialContext ctx = new InitialContext();
            CustomerService customerService = (CustomerService) ctx.lookup("lk.jiat.bank.core.service.CustomerService");
            AccountService accountService = (AccountService) ctx.lookup("lk.jiat.bank.core.service.AccountService");

            Long customerId = Long.parseLong(request.getParameter("customerId"));
            String accountNumber = request.getParameter("accountNumber");
            String accountTypeStr = request.getParameter("accountType");
            double balance = Double.parseDouble(request.getParameter("balance"));

            Customer customer = customerService.getUserById(customerId);
            AccountType accountType = AccountType.valueOf(accountTypeStr);

            BankAccount account = new BankAccount();
            account.setAccountNumber(accountNumber);
            account.setAccountType(accountType);
            account.setBalance(BigDecimal.valueOf(balance));
            account.setCustomer(customer);

            accountService.createAccount(account);

            response.sendRedirect("admin_dashboard.jsp"); // Redirect back to dashboard

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error creating account: " + e.getMessage());
        }

        }

}
