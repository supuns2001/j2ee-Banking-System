package lk.jiat.bank.core.exceptions;

public class BankApplicationException extends RuntimeException{

    public BankApplicationException(String message) {
        super(message);
    }

    public BankApplicationException(String message, Throwable cause) {
        super(message, cause);
    }
}
