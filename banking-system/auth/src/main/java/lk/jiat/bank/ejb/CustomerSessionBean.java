package lk.jiat.bank.ejb;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.exceptions.CustomerNotFoundException;
import lk.jiat.bank.core.service.CustomerService;
import lk.jiat.bank.ejb.interceptors.annotation.CustomerRegister;

import java.util.List;

@Stateless
public class CustomerSessionBean implements CustomerService {

    @PersistenceContext
    private EntityManager em;


    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    @Override
    public Customer getUserById(Long id) {
        Customer customer = em.find(Customer.class, id);
        if (customer == null) {
            throw new CustomerNotFoundException("Customer with ID " + id + " not found.");
        }
        return customer;
    }

    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    @Override
    public Customer getUserByEmail(String email) {
        return em.createNamedQuery("Customer.findByEmail", Customer.class).setParameter("email", email).getSingleResult();

    }

    @CustomerRegister
    @Override
    public void addUser(Customer user) {
        em.persist(user);
    }

    @RolesAllowed({"CUSTOMER","ADMIN"})
    @Override
    public void updateUser(Customer user) {

        em.merge(user);
    }

    @RolesAllowed({"CUSTOMER","ADMIN"})
    @Override
    public void deleteUser(Customer user) {

        em.remove(user);
    }

    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    @Override
    public boolean validate(String email, String password) {

        try {

            System.out.println("session Bean  details :"+email + " "+ password);

            Customer u = em.createNamedQuery("Customer.findByEmailAndPassword",Customer.class)
                    .setParameter("email", email)
                    .setParameter("password",password)
                    .getSingleResult();
        System.out.println("user is ;"+u.getFullName());

            return u != null;

        } catch (Exception e) {
            System.out.println("customer not found");
            return false;
        }

    }

    @Override
    public List<Customer> getAllUsers() {
        List<Customer> customers = em.createNamedQuery("Customer.findAll", Customer.class)
                .getResultList();

        System.out.println("customer list is :"+customers);
        return customers;
    }
}