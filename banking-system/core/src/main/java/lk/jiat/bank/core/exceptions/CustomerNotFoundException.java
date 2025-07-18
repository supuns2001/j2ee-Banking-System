package lk.jiat.bank.core.exceptions;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class CustomerNotFoundException extends BankApplicationException{

    public CustomerNotFoundException(String message) {
        super(message);
    }
}
