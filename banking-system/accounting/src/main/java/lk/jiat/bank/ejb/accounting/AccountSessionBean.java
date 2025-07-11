package lk.jiat.bank.ejb.accounting;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.AccountService;

import java.util.List;

@Stateless
public class AccountSessionBean implements AccountService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void createAccount(BankAccount account) {
        em.persist(account);
    }

    @Override
    public void updateAccount(BankAccount account) {
        em.merge(account);
    }

    @Override
    public void deleteAccount(BankAccount account) {
        BankAccount managed = em.merge(account); // ensure it's managed
        em.remove(managed);
    }

    public BankAccount getAccountByNumber(String accountNumber) {
        return em.createNamedQuery("BankAccount.findByAccountNumber", BankAccount.class)
                .setParameter("accountNumber", accountNumber)
                .getSingleResult();
    }

    public List<BankAccount> getAccountsByCustomer(Customer customer) {
        return em.createNamedQuery("BankAccount.findByCustomer", BankAccount.class)
                .setParameter("customer", customer)
                .getResultList();
    }

    public List<BankAccount> getAllAccounts() {
        return em.createNamedQuery("BankAccount.findAll", BankAccount.class)
                .getResultList();
    }
}
