package lk.jiat.bank.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bank.core.entities.Admin;
import lk.jiat.bank.core.service.AdminService;

@Stateless
public class AdminSessionBean implements AdminService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Admin getAdminById(Long id) {
        return em.find(Admin.class, id);
    }

    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    @Override
    public Admin getAdminByEmail(String email) {
            return em.createNamedQuery("Admin.findByEmail", Admin.class).setParameter("email", email).getSingleResult();

    }

    @Override
    public void addAdmin(Admin admin) {
        em.persist(admin);
    }

    @Override
    public void updateAdmin(Admin admin) {
        em.merge(admin);
    }

    @Override
    public void deleteAdmin(Admin admin) {
        Admin managedAdmin = em.find(Admin.class, admin.getId());
        if (managedAdmin != null) {
            em.remove(managedAdmin);
        }
    }

    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    @Override
    public boolean validate(String email, String encryptedPassword) {

        try {

            System.out.println("Admin session Bean  details :"+email + " "+ encryptedPassword);
            Admin a = em.createNamedQuery("Admin.findByEmailAndPassword",Admin.class)
                    .setParameter("email", email)
                    .setParameter("password",encryptedPassword)
                    .getSingleResult();
            System.out.println("Admin is ;"+a.getName());

            return a != null;

        } catch (Exception e) {
            System.out.println("Admin is not found");
            return false;
        }

    }
}
