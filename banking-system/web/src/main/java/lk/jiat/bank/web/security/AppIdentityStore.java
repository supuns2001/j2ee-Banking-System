package lk.jiat.bank.web.security;

import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.core.service.CustomerService;

import java.util.Set;

@ApplicationScoped
public class AppIdentityStore implements IdentityStore {

    @EJB
    private CustomerService customerService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential){
            UsernamePasswordCredential upc = (UsernamePasswordCredential) credential;

            if (customerService.validate(upc.getCaller(), upc.getPasswordAsString())){
                Customer user = customerService.getUserByEmail(upc.getCaller());

                return new CredentialValidationResult(user.getEmail(), Set.of(user.getUserType().name()));
            }

        }
        return CredentialValidationResult.INVALID_RESULT;
    }
}
