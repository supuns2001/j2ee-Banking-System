package lk.jiat.bank.scheduler.interest;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.service.AccountService;

import java.math.BigDecimal;
import java.util.List;

@Singleton
@Startup
public class InterestSchedulerBean {

    @EJB
    private AccountService accountService;

    //    @Schedule(minute = "*/1", hour = "*", persistent = false)
    @Schedule(dayOfMonth = "Last", hour = "23", minute = "59", persistent = false)
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void updateMonthlyInterest() {
        List<BankAccount> accounts = accountService.getAllAccounts();

        for (BankAccount account : accounts) {
            BigDecimal balance = account.getBalance();
            BigDecimal interestRate = account.getInterestRate();

            // Calculate interest: balance * (rate / 100)
            BigDecimal interest = balance.multiply(interestRate).divide(BigDecimal.valueOf(100));

            account.setBalance(balance.add(interest));
            accountService.updateAccount(account);
        }

        System.out.println("Monthly Interest Update Completed.");
    }
}

