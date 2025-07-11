package lk.jiat.bank.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bank.core.entities.Admin;

@Remote
public interface AdminService {

    Admin getAdminById(Long id);
    Admin getAdminByEmail(String email);
    void addAdmin(Admin admin);
    void updateAdmin(Admin admin);
    void deleteAdmin(Admin admin);

    boolean validate(String email, String encryptedPassword);

}
