package lk.jiat.bank.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bank.core.entities.Customer;

import java.util.List;

@Remote
public interface CustomerService {

    Customer getUserById(Long id);
    Customer getUserByEmail(String email);
    void addUser(Customer user );
    void updateUser(Customer user );
    void deleteUser(Customer user );

    boolean validate(String email , String password);

}
