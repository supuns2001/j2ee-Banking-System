package lk.jiat.bank.ejb.interceptors.interceptor;

import jakarta.enterprise.context.Dependent;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import lk.jiat.bank.core.entities.Customer;
import lk.jiat.bank.ejb.interceptors.annotation.CustomerRegister;

@CustomerRegister
@Interceptor
//@Dependent
public class CustomerValidInterceptor {

    @AroundInvoke
    public Object intercept(InvocationContext context) throws Exception {
        System.out.println("CustomerValidInterceptor.intercept start");

        Object[] params = context.getParameters();
        for (Object param : params) {
            if (param instanceof Customer) {
                Customer customer = (Customer) param;
                if (customer.getEmail() == null || customer.getEmail().isEmpty()) {
                    throw new IllegalArgumentException("Email is required");
                }
                // Other validations here
                System.out.println(" Interceptor: Customer is valid");
            }
        }
        return context.proceed();
    }

}
