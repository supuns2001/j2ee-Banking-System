package lk.jiat.bank.web.servlet.account;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.service.AccountService;

import java.io.IOException;

@WebServlet("/toggleAccountStatus")
public class ToggleAccountStatusServlet extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");

        System.out.println("account number is :"+ accountNumber);

        if (accountNumber != null) {
            BankAccount account = accountService.getAccountByNumber(accountNumber);
            if (account != null) {
                account.setActive(!account.isActive()); // Toggle status
                accountService.updateAccount(account);
            }
        }

        response.sendRedirect("admin_dashboard.jsp");
    }
}