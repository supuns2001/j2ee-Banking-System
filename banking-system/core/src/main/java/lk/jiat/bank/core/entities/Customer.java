package lk.jiat.bank.core.entities;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "customers")


@NamedQueries({
        @NamedQuery(name = "Customer.findByEmail", query = "select c from Customer c where c.email =:email"),
        @NamedQuery(name = "Customer.findByEmailAndPassword", query = "select c from Customer c where c.email =:email and c.password=:password"),
        @NamedQuery(name = "Customer.findAll", query = "select c from Customer c")
})
@Cacheable(value = false)
public class Customer implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fullName;
    @Column(unique = true)
    private String email;
    private String phone;
    private String address;
    private String password;
    @Enumerated(EnumType.STRING)
    private UserType userType = UserType.CUSTOMER;


    // Constructors
    public Customer() {
    }

    public Customer(String fullName, String email, String phone, String address, String password) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }
}