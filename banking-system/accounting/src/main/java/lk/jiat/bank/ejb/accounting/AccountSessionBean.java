package lk.jiat.bank.ejb.accounting;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.AccountService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Stateless
public class AccountSessionBean implements AccountService {

    @PersistenceContext
    private EntityManager em;

    @RolesAllowed({"ADMIN"})
    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void createAccount(BankAccount account) {
        em.persist(account);
    }

    @RolesAllowed({"ADMIN"})
    @Override
    public void updateAccount(BankAccount account) {
        em.merge(account);
    }

    @RolesAllowed({"ADMIN"})
    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deleteAccount(BankAccount account) {
        BankAccount managed = em.merge(account); // ensure it's managed
        em.remove(managed);
    }

    @RolesAllowed({"ADMIN" , "CUSTOMER"})
    public BankAccount getAccountByNumber(String accountNumber) {
        return em.createNamedQuery("BankAccount.findByAccountNumber", BankAccount.class)
                .setParameter("accountNumber", accountNumber)
                .getSingleResult();
    }

    @RolesAllowed({"ADMIN" , "CUSTOMER"})
    public List<BankAccount> getAccountsByCustomer(Customer customer) {
        return em.createNamedQuery("BankAccount.findByCustomer", BankAccount.class)
                .setParameter("customer", customer)
                .getResultList();
    }

    @RolesAllowed({"ADMIN"})
    public List<BankAccount> getAllAccounts() {
        return em.createNamedQuery("BankAccount.findAll", BankAccount.class)
                .getResultList();
    }

    @Override
    public int getTotalAccountCount() {
        return getAllAccounts().size();
    }

    @Override
    public double getTotalBalance() {
        return getAllAccounts().stream()
                .map(BankAccount::getBalance)
                .reduce(BigDecimal.ZERO, BigDecimal::add)
                .doubleValue();
    }

    @Override
    public double getMonthlyCollection() {
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        return getAllAccounts().stream()
                .filter(acc -> acc.getCreatedAt().getMonthValue() == currentMonth &&
                        acc.getCreatedAt().getYear() == currentYear)
                .map(BankAccount::getBalance)
                .reduce(BigDecimal.ZERO, BigDecimal::add)
                .doubleValue();
    }
}
