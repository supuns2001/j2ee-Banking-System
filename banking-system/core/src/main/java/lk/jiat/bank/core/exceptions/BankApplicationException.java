package lk.jiat.bank.core.exceptions;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class BankApplicationException extends RuntimeException{

    public BankApplicationException(String message) {
        super(message);
    }

    public BankApplicationException(String message, Throwable cause) {
        super(message, cause);
    }
}
