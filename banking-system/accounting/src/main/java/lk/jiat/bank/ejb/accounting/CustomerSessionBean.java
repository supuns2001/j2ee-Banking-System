package lk.jiat.bank.ejb.accounting;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jdk.jfr.StackTrace;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.CustomerService;

import java.util.List;

@Stateless
public class CustomerSessionBean implements CustomerService {

    @PersistenceContext
    private EntityManager em;


    @Override
    public Customer getUserById(Long id) {
        Customer userId = em.find(Customer.class , id);
        return userId;
    }

    @Override
    public Customer getUserByEmail(String email) {
        return em.createNamedQuery("Customer.findByEmail", Customer.class).setParameter("email", email).getSingleResult();

    }

    @Override
    public void addUser(Customer user) {
        em.persist(user);
    }

    @RolesAllowed({"CUSTOMER","ADMIN","SUPER_ADMIN"})
    @Override
    public void updateUser(Customer user) {

        em.merge(user);
    }

    @RolesAllowed({"CUSTOMER","ADMIN","SUPER_ADMIN"})
    @Override
    public void deleteUser(Customer user) {

        em.remove(user);
    }

    @Override
    public boolean validate(String email, String password) {

        System.out.println("session Bean  details :"+email + " "+ password);

        Customer u = em.createNamedQuery("Customer.findByEmailAndPassword",Customer.class)
                .setParameter("email", email)
                .setParameter("password",password)
                .getSingleResult();
//        System.out.println("user is ;"+u.getFullName());

        return u != null;
    }
}