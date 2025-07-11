package lk.jiat.bank.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bank.core.entities.BankAccount;
import lk.jiat.bank.core.entities.Customer;

import java.util.List;

@Remote
public interface AccountService {

    void createAccount(BankAccount account);
    void updateAccount(BankAccount account);
    void deleteAccount(BankAccount account);
    BankAccount getAccountByNumber(String accountNumber);
    List<BankAccount> getAccountsByCustomer(Customer customer);
    List<BankAccount> getAllAccounts();
}
