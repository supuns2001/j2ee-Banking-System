package lk.jiat.bank.web.servlet.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class Logout extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getSession().invalidate();

        // Optionally logout from container (if using security context)
        try {
            request.logout();
        } catch (ServletException e) {
            e.printStackTrace(); // optional: log or handle logout exception
        }

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
