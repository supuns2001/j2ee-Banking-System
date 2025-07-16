package lk.jiat.bank.web.servlet.admin;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.entities.Loan;
import lk.jiat.bank.core.entities.LoanType;
import lk.jiat.bank.core.service.CustomerService;
import lk.jiat.bank.core.service.LoanService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/addLoan")
public class AddLoanServlet extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @EJB
    private LoanService loanService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Customer> customers = customerService.getAllUsers();
        req.setAttribute("customers", customers);
        req.setAttribute("loanTypes", LoanType.values());
        req.getRequestDispatcher("/admin_add_loan.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Long custId = Long.parseLong(req.getParameter("customerId"));
        LoanType type = LoanType.valueOf(req.getParameter("loanType"));
        BigDecimal principal = new BigDecimal(req.getParameter("principal"));
        BigDecimal monthly = new BigDecimal(req.getParameter("monthlyInstallment"));
        String desc = req.getParameter("description");

        Customer cust = customerService.getUserById(custId);
        Loan loan = new Loan();
        loan.setCustomer(cust);
        loan.setType(type);
        loan.setPrincipal(principal);
        loan.setMonthlyInstallment(monthly);
        loan.setDescription(desc);

        loanService.addLoan(loan);
        resp.sendRedirect(req.getContextPath() + "/admin_dashboard.jsp?loanAdded=1");
    }


}
