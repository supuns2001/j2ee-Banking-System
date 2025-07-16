package lk.jiat.bank.core.service;


import jakarta.ejb.Remote;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.entities.Loan;

import java.util.List;

@Remote
public  interface LoanService {

    void addLoan(Loan loan);
    List<Loan> getAllLoans();
    List<Loan> getLoansByCustomer(Customer customer);
    void deductMonthlyInstallment();
}
