package lk.jiat.bank.scheduler.interest;

import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.BankAccount;

import java.math.BigDecimal;
import java.util.List;

@Singleton
@Startup
public class InterestSchedulerBean {

    @PersistenceContext
    private EntityManager em;

    // Runs at midnight on the 1st day of each month
    @Schedule(dayOfMonth = "1", hour = "0", minute = "0", second = "0", persistent = false)
    public void applyMonthlyInterest() {
        List<BankAccount> accounts = em.createNamedQuery("BankAccount.findAll", BankAccount.class).getResultList();

        for (BankAccount account : accounts) {
            BigDecimal annualRate = account.getInterestRate();
            if (annualRate != null && annualRate.compareTo(BigDecimal.ZERO) > 0) {
                // Monthly rate = annualRate / 12
                BigDecimal monthlyRate = annualRate.divide(BigDecimal.valueOf(12), 10, BigDecimal.ROUND_HALF_UP);
                BigDecimal interest = account.getBalance().multiply(monthlyRate).divide(BigDecimal.valueOf(100), 10, BigDecimal.ROUND_HALF_UP);
                account.setBalance(account.getBalance().add(interest));
                em.merge(account); // Update with new balance
            }
        }
    }

}
