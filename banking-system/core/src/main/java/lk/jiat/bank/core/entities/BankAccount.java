package lk.jiat.bank.core.entities;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;


@Entity
@Table(name = "bank_accounts")
@NamedQueries({
        @NamedQuery(name = "BankAccount.findAll", query = "SELECT b FROM BankAccount b"),
        @NamedQuery(name = "BankAccount.findByAccountNumber", query = "SELECT b FROM BankAccount b WHERE b.accountNumber = :accountNumber"),
        @NamedQuery(name = "BankAccount.findByCustomer", query = "SELECT b FROM BankAccount b WHERE b.customer = :customer")
})
public class BankAccount implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String accountNumber;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AccountType accountType;

    @Column(nullable = false)
    private BigDecimal balance;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @ManyToOne(optional = false)
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Column(nullable = false)
    private BigDecimal interestRate;

    @Column(nullable = false)
    private boolean active = true;


    public BankAccount() {
        this.createdAt = LocalDateTime.now();
        this.balance = BigDecimal.ZERO;
    }

    public BankAccount(String accountNumber, AccountType accountType, BigDecimal balance, BigDecimal interestRate, Customer customer) {
        this.accountNumber = accountNumber;
        this.accountType = accountType;
        this.balance = balance;
        this.interestRate = interestRate;
        this.customer = customer;
        this.createdAt = LocalDateTime.now();
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public AccountType getAccountType() {
        return accountType;
    }

    public void setAccountType(AccountType accountType) {
        this.accountType = accountType;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    public BigDecimal getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(BigDecimal interestRate) {
        this.interestRate = interestRate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }





}
