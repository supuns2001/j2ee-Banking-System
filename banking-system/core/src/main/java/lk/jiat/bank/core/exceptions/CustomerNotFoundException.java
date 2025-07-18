package lk.jiat.bank.core.exceptions;

public class CustomerNotFoundException extends BankApplicationException{

    public CustomerNotFoundException(String message) {
        super(message);
    }
}
