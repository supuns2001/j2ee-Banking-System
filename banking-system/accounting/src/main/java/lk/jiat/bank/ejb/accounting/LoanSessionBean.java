package lk.jiat.bank.ejb.accounting;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.entities.Loan;
import lk.jiat.bank.core.service.LoanService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Singleton
@Startup
public class LoanSessionBean implements LoanService {

    @PersistenceContext
    private EntityManager em;

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void addLoan(Loan loan) {
        loan.setStartDate(LocalDate.now());
        loan.setRemainingBalance(loan.getPrincipal());
        loan.setPaid(false);
        em.persist(loan);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public List<Loan> getAllLoans() {
        return em.createNamedQuery("Loan.findAll", Loan.class).getResultList();
    }

    @Override
    public List<Loan> getLoansByCustomer(Customer customer) {
        return em.createNamedQuery("Loan.findByCustomer", Loan.class)
                .setParameter("customer", customer)
                .getResultList();
    }

    @Override
    @Schedule(dayOfMonth = "Last", hour = "0", minute = "0")
    //@Schedule(minute = "*/1", hour = "*", persistent = false)
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deductMonthlyInstallment() {
        List<Loan> loans = getAllLoans();

        for (Loan loan : loans) {
            if (loan == null || loan.isPaid()) {
                continue; // Skip null or already paid loans
            }

            Customer customer = loan.getCustomer();
            if (customer == null || customer.getAccounts() == null) {
                continue; // Customer or their accounts are not set
            }

            BigDecimal installment = loan.getMonthlyInstallment();
            BigDecimal remaining = loan.getRemainingBalance();

            if (installment == null || remaining == null) {
                continue; // Invalid loan data
            }

            for (BankAccount acc : customer.getAccounts()) {
                if (acc == null || acc.getBalance() == null) continue;

                if (acc.getBalance().compareTo(installment) >= 0) {
                    // Deduct from account
                    acc.setBalance(acc.getBalance().subtract(installment));
                    em.merge(acc);

                    // Deduct from loan
                    BigDecimal newRemaining = remaining.subtract(installment);
                    loan.setRemainingBalance(newRemaining);

                    // Mark as paid if loan is fully paid
                    if (newRemaining.compareTo(BigDecimal.ZERO) <= 0) {
                        loan.setPaid(true);
                        loan.setRemainingBalance(BigDecimal.ZERO); // Ensure no negative
                    }

                    em.merge(loan);
                    break; // Stop after one successful deduction
                }
            }
        }
    }
}
