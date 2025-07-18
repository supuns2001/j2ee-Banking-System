package lk.jiat.bank.web.servlet.admin;

import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bank.core.util.Encryption;

import java.io.IOException;

@WebServlet("/admin_login")
public class AdminLoginServlet extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            System.out.println("admin login is :" + email + " " + password);

            AuthenticationParameters parameters = AuthenticationParameters.withParams()
                    .credential(new UsernamePasswordCredential(email, Encryption.encrypt(password)));

            AuthenticationStatus status = securityContext.authenticate(request, response, parameters);

            System.out.println("Admin status is :" + status);

            if (status == AuthenticationStatus.SUCCESS) {
                System.out.println("Admin Authentication successful");
                response.sendRedirect(request.getContextPath() + "/admin_dashboard.jsp");
            } else {
                System.out.println("Admin Authentication failed");
                // Forward to error.jsp with message
                request.setAttribute("jakarta.servlet.error.message", "Invalid email or password.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();

            // Forward to error.jsp with exception details
            request.setAttribute("jakarta.servlet.error.message", "Unexpected error during login: " + e.getMessage());
            request.setAttribute("jakarta.servlet.error.exception", e);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
