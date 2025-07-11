package lk.jiat.bank.web.security;

import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import lk.jiat.bank.core.entities.Admin;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.AdminService;
import lk.jiat.bank.core.service.CustomerService;
import lk.jiat.bank.core.util.Encryption;

import java.util.Set;

@ApplicationScoped
public class AppIdentityStore implements IdentityStore {

    @EJB
    private CustomerService customerService;

    @EJB
    private AdminService adminService; // Add this EJB

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential) {
            UsernamePasswordCredential upc = (UsernamePasswordCredential) credential;
//            String email = upc.getCaller();
//            String password = upc.getPasswordAsString();

            // First check if this is an admin
            if (adminService.validate(upc.getCaller(), upc.getPasswordAsString())){
                Admin user = adminService.getAdminByEmail(upc.getCaller());
                return new CredentialValidationResult(user.getEmail(), Set.of(user.getUserType().name()));
            }

            // If not admin, check customer
            if (customerService.validate(upc.getCaller(), upc.getPasswordAsString())){
                Customer user = customerService.getUserByEmail(upc.getCaller());
                return new CredentialValidationResult(user.getEmail(), Set.of(user.getUserType().name()));
            }
        }

        return CredentialValidationResult.INVALID_RESULT;
    }
}
