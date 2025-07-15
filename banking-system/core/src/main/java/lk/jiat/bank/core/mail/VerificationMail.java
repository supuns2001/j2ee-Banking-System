package lk.jiat.bank.core.mail;

import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

import java.util.Base64;

public class VerificationMail extends Mailable{

    private String to;
    private String verificationCode;

    public VerificationMail(String to, String password) {
        this.to = to;
        this.verificationCode = password;
    }

    @Override
    public void build(Message message) throws Exception {

        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Verification Mail");

//        String encode = Base64.getEncoder().encodeToString(to.getBytes());

//        String link = "http://localhost:8080/j2ee-example/verify?id="+encode+"&vc="+verificationCode;

        //
//        message.setText("Hello Dev, your account password is " + verificationCode);
//        message.setContent(link, "text/html; charset=utf-8");


        // Build HTML content
        String htmlContent =
                        "<html>" +
                        "<body style='font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px;'>" +
                        "<div style='max-width: 600px; margin: auto; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); padding: 30px;'>" +
                        "<h2 style='color: #333;'>Email Verification</h2>" +
                        "<p>Hello,</p>" +
                        "<p>Thank you for creating an account with us. Please use the Password below:</p>" +
                        "<div style='background-color: #f1f1f1; padding: 15px; font-size: 18px; font-weight: bold; text-align: center; border-radius: 4px; color: #2c3e50;'>" +
                        verificationCode +
                        "</div>" +
                        "<p style='margin-top: 20px;'>If you didn’t request this, you can safely ignore this email.</p>" +
                        "<p style='color: #888; font-size: 12px;'>— Your Company Team</p>" +
                        "</div>" +
                        "</body>" +
                        "</html>";


        // Set content as HTML
        message.setContent(htmlContent, "text/html; charset=utf-8");
    }
}
