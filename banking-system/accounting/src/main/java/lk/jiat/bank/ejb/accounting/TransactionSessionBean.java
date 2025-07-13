package lk.jiat.bank.ejb.accounting;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Transaction;
import lk.jiat.bank.core.entities.TransactionType;
import lk.jiat.bank.core.service.TransactionService;

import java.math.BigDecimal;
import java.util.List;

@Stateless
public class TransactionSessionBean implements TransactionService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void addTransaction(Transaction transaction) {
        em.persist(transaction);
    }

    @Override
    public List<Transaction> getTransactionByAccountList(Long accountId) {
      return em.createNamedQuery("Transaction.findByAccountId", Transaction.class).setParameter("accountId", accountId).getResultList();
    }

    @Override
    public List<Transaction> getAllTransactions() {
        return em.createNamedQuery("Transaction.findAll", Transaction.class).getResultList();
    }

    @Override
    public void transferAccount(String sourceAccountNumber, String destinationAccountNumber, double amount) throws Exception {

        BankAccount from = em.createQuery("SELECT a FROM BankAccount a WHERE a.accountNumber = :num", BankAccount.class)
                .setParameter("num", sourceAccountNumber)
                .getSingleResult();

        BankAccount to = em.createQuery("SELECT a FROM BankAccount a WHERE a.accountNumber = :num", BankAccount.class)
                .setParameter("num", destinationAccountNumber)
                .getSingleResult();

        if (from.getBalance().compareTo(BigDecimal.valueOf(amount)) < 0) {
            throw new Exception("Insufficient funds.");
        }

        from.setBalance(from.getBalance().subtract(BigDecimal.valueOf(amount)));
        to.setBalance(to.getBalance().add(BigDecimal.valueOf(amount)));

        em.merge(from);
        em.merge(to);

        Transaction tx = new Transaction();
        tx.setFromAccount(from);
        tx.setToAccount(to);
        tx.setAmount(BigDecimal.valueOf(amount));
        tx.setType(TransactionType.TRANSFER);
        tx.setNote("Transfer from " + sourceAccountNumber + " to " + destinationAccountNumber);
        em.persist(tx);

    }
}
