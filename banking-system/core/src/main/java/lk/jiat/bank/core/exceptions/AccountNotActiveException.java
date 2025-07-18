package lk.jiat.bank.core.exceptions;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class AccountNotActiveException extends RuntimeException{
    public AccountNotActiveException(String message) {
        super(message);
    }

    public AccountNotActiveException(String message, Throwable cause) {
        super(message, cause);
    }
}
