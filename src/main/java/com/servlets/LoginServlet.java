package com.servlets;

import java.io.IOException;
import java.security.MessageDigest;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.Entities.User;
import com.UserDao.UserDao;
import com.provider.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        // TODO Auto-generated constructor stub
    }
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session = null;
		Transaction tx = null;
		try {
			String userEmail = request.getParameter("user_email");
			String userPassword  = request.getParameter("user_password");

			/* Password Encryption */


			/* MessageDigest instance for MD5. */
            MessageDigest m = MessageDigest.getInstance("MD5");

            /* Add plain-text password bytes to digest using MD5 update() method. */
            m.update(userPassword.getBytes());

            /* Convert the hash value into bytes */
            byte[] bytes = m.digest();

            /* The bytes array has bytes in decimal form. Converting it into hexadecimal format. */
            StringBuilder s = new StringBuilder();
            for (byte element : bytes) {
                s.append(Integer.toString((element & 0xff) + 0x100, 16).substring(1));
            }

            /* Complete hashed password in hexadecimal format */
            String encryptedPassword = s.toString();


            // Authenticating User
            UserDao userDao = new UserDao(FactoryProvider.getSessionFactory());
            User user = userDao.getUserByEmailAndPassword(userEmail, encryptedPassword);
            //System.out.println(user);

            HttpSession httpSession = request.getSession();
            if(user == null) {
    			httpSession.setAttribute("message", "Invalid email or password!!!");
    			response.sendRedirect("login.jsp");
    			return;
            }
            else {
            	httpSession.setAttribute("current_user", user);
            	// checking type of user : admin or normal
            	if(user.getUserType().equals("admin")) {
            		// redirected to admin panel
            		response.sendRedirect("admin.jsp");
            	}
            	else {
            		// redirected to normal user panel
            		response.sendRedirect("normal.jsp");
            	}
            }
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
