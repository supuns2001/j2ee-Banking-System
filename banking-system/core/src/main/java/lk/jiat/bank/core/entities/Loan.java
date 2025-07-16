package lk.jiat.bank.core.entities;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "loans")
@NamedQueries({
        @NamedQuery(name = "Loan.findAll", query = "SELECT l FROM Loan l"),
        @NamedQuery(name = "Loan.findByCustomer", query = "SELECT l FROM Loan l WHERE l.customer = :customer")
})
public class Loan implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private Customer customer;

    @Enumerated(EnumType.STRING)
    private LoanType type;

    @Column(nullable = false)
    private BigDecimal principal;

    @Column(nullable = false)
    private BigDecimal monthlyInstallment;

    @Column(length = 500)
    private String description;

    @Column(nullable = false)
    private LocalDate startDate;

    @Column(name = "REMAININGBALACE", nullable = false)
    private BigDecimal remainingBalance;

    @Column(name = "PAID")
    private boolean paid;



    public Loan(Customer customer, LoanType type, BigDecimal principal, BigDecimal monthlyInstallment, String description, LocalDate startDate) {
        this.customer = customer;
        this.type = type;
        this.principal = principal;
        this.monthlyInstallment = monthlyInstallment;
        this.description = description;
        this.startDate = startDate;
    }

    public Loan() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public LoanType getType() {
        return type;
    }

    public void setType(LoanType type) {
        this.type = type;
    }

    public BigDecimal getPrincipal() {
        return principal;
    }

    public void setPrincipal(BigDecimal principal) {
        this.principal = principal;
    }

    public BigDecimal getMonthlyInstallment() {
        return monthlyInstallment;
    }

    public void setMonthlyInstallment(BigDecimal monthlyInstallment) {
        this.monthlyInstallment = monthlyInstallment;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public BigDecimal getRemainingBalance() {
        return remainingBalance;
    }

    public void setRemainingBalance(BigDecimal remainingBalance) {
        this.remainingBalance = remainingBalance;
    }

    public boolean isPaid() {
        return paid;
    }
    public void setPaid(boolean paid) {
        this.paid = paid;
    }
}
