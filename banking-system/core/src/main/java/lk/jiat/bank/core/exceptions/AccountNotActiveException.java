package lk.jiat.bank.core.exceptions;

public class AccountNotActiveException extends RuntimeException{
    public AccountNotActiveException(String message) {
        super(message);
    }

    public AccountNotActiveException(String message, Throwable cause) {
        super(message, cause);
    }
}
