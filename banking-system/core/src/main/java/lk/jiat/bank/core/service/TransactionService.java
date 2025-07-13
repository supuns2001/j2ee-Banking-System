package lk.jiat.bank.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bank.core.entities.Transaction;

import java.util.List;

@Remote
public interface TransactionService {

    void addTransaction(Transaction transaction);
    List<Transaction> getTransactionByAccountList(Long accountId);
    List<Transaction> getAllTransactions();
    void transferAccount(String sourceAccountNumber , String destinationAccountNumber, double amount) throws Exception;

}
